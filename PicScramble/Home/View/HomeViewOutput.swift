//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation

protocol HomeViewOutput: class {
    func viewIsReady()
    func actionButtonClicked()
    func answerQuestion(indexSelected: Int)
}
