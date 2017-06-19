//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewInput: class {
    func setupInitialState(imageSize: CGSize, timerLabelText: String, actionButtonMode: ActionButtonMode)
    func changeActionButtonMode(newMode: ActionButtonMode)
    func refreshData(viewModel: [PicScrambleViewModel])
    func changeTimerText(text: String)
    func showImageQuestion(question: PicScrambleImageQuestion)
    func revealAnswer(index: Int, data: PicScrambleViewModel)
    func updateAllViewModelsAnimated(viewModel: [PicScrambleViewModel], isClickable: Bool)
    func showMessage(message: String, mode: MessageMode)
}
