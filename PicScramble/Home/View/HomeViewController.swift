//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

enum ActionButtonMode {
    case startGame(text: NSAttributedString)
    case hidden
    case showImage(text: NSAttributedString)
    case restart(text: NSAttributedString)
}

enum MessageMode {
    case error
    case success
    case info
}

class HomeViewController: UIViewController, HomeViewInput {
    var output: HomeViewOutput!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    let messageView = MessageView.viewFromNib(layout: .MessageView)
    var config = SwiftMessages.defaultConfig
    
    var imageSize: CGSize!
    var viewModel: [PicScrambleViewModel] = []
    var questionImageViewController: QuestionViewController = QuestionViewController(nibName: "QuestionImageView", bundle: Bundle.main)

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = self.questionImageViewController.view
        self.output.viewIsReady()
        self.setupViews()
        self.setupDelegates()
    }
    
    func setupViews() {
        self.messageView.button?.isHidden = true
        self.messageView.titleLabel?.isHidden = true
        self.config.presentationStyle = .bottom
        self.config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
    }
    
    func setupDelegates() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    func setupInitialState(imageSize: CGSize, timerLabelText: String, actionButtonMode: ActionButtonMode) {
        self.imageSize = imageSize
        self.timerLabel.text = timerLabelText
        self.changeActionButtonMode(newMode: actionButtonMode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "PicScramble"
    }
    
    func changeActionButtonMode(newMode: ActionButtonMode) {
        switch newMode {
        case .showImage(let text), .startGame(let text), .restart(let text):
            self.actionButton.isHidden = false
            self.actionButton.setAttributedTitle(text, for: .normal)
        case .hidden:
            self.actionButton.isHidden = true
        }
    }
    
    func refreshData(viewModel: [PicScrambleViewModel]) {
        self.viewModel = viewModel
        self.collectionView.reloadData()
    }

    func changeTimerText(text: String) {
        self.timerLabel.text = text
    }

    func updateAllViewModelsAnimated(viewModel: [PicScrambleViewModel], isClickable: Bool) {
        self.viewModel = viewModel
        self.collectionView.indexPathsForVisibleItems.forEach { (indexPath) in
            let cell: PicCollectionViewCell = self.collectionView.cellForItem(at: indexPath) as! PicCollectionViewCell
            cell.configure(viewModel: viewModel[indexPath.row], animated: true)
        }
    }

    func showImageQuestion(question: PicScrambleImageQuestion) {
        self.questionImageViewController.setViewModel(viewModel: question)
        PicScramblePopup.sharedInstance.showImageQuestion(
                viewController: self.questionImageViewController, presentingViewController: self
        )
    }
    
    func showMessage(message: String, mode: MessageMode) {
        switch mode {
        case .error:
            self.messageView.configureTheme(.error)
        case .success:
            self.messageView.configureTheme(.success)
        case .info:
            self.messageView.configureTheme(.info)
        }
        messageView.configureContent(body: message)
        SwiftMessages.show(config: self.config, view: self.messageView)
    }
    
    func revealAnswer(index: Int, data: PicScrambleViewModel) {
        self.viewModel[index] = data
        let cell: PicCollectionViewCell? = self.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? PicCollectionViewCell
        cell?.configure(viewModel: data, animated: true)
    }
    
    @IBAction func actionButtonClicked(_ sender: Any) {
        self.output.actionButtonClicked()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PicCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: PicCollectionViewCell.getReusableIdentifier(), for: indexPath) as! PicCollectionViewCell
        cell.configure(viewModel: self.viewModel[indexPath.row], animated: false)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.imageSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.output.answerQuestion(indexSelected: indexPath.item)
    }
}
