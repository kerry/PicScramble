//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import UIKit

struct PicScrambleViewModel {
    var imageUrl: String
    var imageState: PicScrambleImageState
    var isClickable: Bool
}

struct PicScrambleImageQuestion {
    var imageUrl: String
    var index: Int
}

class HomePresenter: NSObject, HomeViewOutput, HomeInteractorOutput, TimerDelegate {
    weak var view: HomeViewInput!
    var interactor: HomeInteractorInput!
    var router: HomeRouterInput!
    var timerService: TimerService!

    let startText = "Start"
    let showImageText = "Show Image"
    let restartText = "Reset"
    let topBarHeight: CGFloat = 49
    let navigationBarHeight: CGFloat = 44
    let statusBarHeight: CGFloat = 20

    var imageSize: CGSize
    var viewModel: [PicScrambleViewModel]
    var unansweredQuestions: [PicScrambleImageQuestion]
    var answeredQuestions: [PicScrambleImageQuestion]
    var currentQuestion: PicScrambleImageQuestion!
    let startButtonText: NSAttributedString
    let showImageButtonText: NSAttributedString
    let restartButtonText: NSAttributedString

    var actionButtonMode: ActionButtonMode = .hidden

    override init() {
        self.viewModel = []
        self.unansweredQuestions = []
        self.answeredQuestions = []
        let heightAvailable = UIScreen.main.bounds.height - self.topBarHeight - self.navigationBarHeight - self.statusBarHeight
        self.imageSize = CGSize.init(
                width: (UIScreen.main.bounds.width - 40) / 3,
                height: (heightAvailable - 40) / 3
        )
        self.startButtonText = self.startText.underlined()
        self.showImageButtonText = self.showImageText.underlined()
        self.restartButtonText = self.restartText.underlined()
        super.init()

        self.timerService = TimerServiceImpl(interval: 1, delegate: self)

        NotificationCenter.default.addObserver(self, selector: #selector(self.goingBackground), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.comingForeground), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    func viewIsReady() {
        self.view.setupInitialState(imageSize: self.imageSize, timerLabelText: "0", actionButtonMode: self.actionButtonMode)
        self.interactor.fetchImages()
    }

    func actionButtonClicked() {
        switch self.actionButtonMode {
        case .startGame(_):
            //ask view to show images
            //start the timer
            self.startTimer()
            self.showAllImages(isClickable: false)
            self.actionButtonMode = .hidden
            self.view.changeActionButtonMode(newMode: self.actionButtonMode)
            break
        case .showImage(_):
            //ask view to show the current question image
            self.showQuestion()
            break
        case .restart(_):
            self.viewIsReady()
        case .hidden:
            break
        }
    }

    func startTimer() {
        self.timerService.startTimer()
    }

    func showAllImages(isClickable: Bool) {
        self.viewModel = self.viewModel.map({
            return PicScrambleViewModel(imageUrl: $0.imageUrl, imageState: .shown, isClickable: isClickable)
        })
        self.view.updateAllViewModelsAnimated(viewModel: self.viewModel, isClickable: isClickable)
    }

    func hideAllImages(isClickable: Bool) {
        self.viewModel = self.viewModel.map({
            return PicScrambleViewModel(imageUrl: $0.imageUrl, imageState: .hidden, isClickable: isClickable)
        })
        self.view.updateAllViewModelsAnimated(viewModel: self.viewModel, isClickable: isClickable)
    }

    func updateTimer(elapsedIntervals: Int) {
        if elapsedIntervals == 15 {
            //stop the timer and hide all images
            self.view.changeTimerText(text: "\(elapsedIntervals)")
            self.timerService.stopTimer()
            self.hideAllImages(isClickable: true)
            self.actionButtonMode = .showImage(text: self.showImageButtonText)
            self.view.changeActionButtonMode(newMode: self.actionButtonMode)
            self.createQuestion()
            self.showQuestion()
        } else {
            //update view to show time left
            self.view.changeTimerText(text: "\(elapsedIntervals)")
        }
    }

    func fetchedImages(images: [FlickrImage]) {
        self.viewModel = images.map({ return PicScrambleViewModel(imageUrl: $0.imageUrl, imageState: .hidden, isClickable: false) })
        self.unansweredQuestions = self.viewModel.enumerated().map { (index, element) in
            return PicScrambleImageQuestion(imageUrl: element.imageUrl, index: index)
        }
        self.answeredQuestions = []
        self.view.refreshData(viewModel: self.viewModel)
        self.actionButtonMode = .startGame(text: self.startButtonText)
        self.view.changeActionButtonMode(newMode: self.actionButtonMode)
    }

    func errorfetchingImages(error: Error) {
        self.view.showMessage(message: "Error fetching data", mode: .error)
    }

    func comingForeground() {
        self.timerService.resumeTimer()
    }

    func goingBackground() {
        self.timerService.pauseTimer()
    }

    func showQuestion() {
        self.view.showImageQuestion(question: self.currentQuestion)
    }

    func createQuestion() {
        let random = getRandom(min: 0, max: self.unansweredQuestions.count - 1)
        self.currentQuestion = self.unansweredQuestions[random]
    }
    
    func revealAnswer(index: Int) {
        let data = self.viewModel[index]
        self.viewModel[index] = PicScrambleViewModel(imageUrl: data.imageUrl, imageState: .shown, isClickable: false)
        self.view.revealAnswer(index: index, data: self.viewModel[index])
    }

    func answerQuestion(indexSelected: Int) {
        if self.currentQuestion.index == indexSelected {
            //correct answer
            self.revealAnswer(index: indexSelected)
            let unAnsweredQuestionIndex = self.unansweredQuestions.index(where: { $0.index == indexSelected })!
            self.answeredQuestions.append(self.unansweredQuestions[unAnsweredQuestionIndex])
            self.unansweredQuestions.remove(at: unAnsweredQuestionIndex)
            if self.answeredQuestions.count == self.viewModel.count {
                //quiz completed
                //send message
                self.actionButtonMode = .restart(text: self.restartButtonText)
                self.view.changeActionButtonMode(newMode: self.actionButtonMode)
                self.view.showMessage(message: "You won!!", mode: .success)
            } else {
                self.createQuestion()
                self.showQuestion()
            }
            //set image user interaction false
        } else {
            //flip the image and flip back to show incorrect answer
            self.view.showMessage(message: "Incorrect answer", mode: .error)
        }
    }
}
