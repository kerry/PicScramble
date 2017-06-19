//
// Created by Prateek Grover on 18/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class QuestionViewController: UIViewController {
    @IBOutlet weak var questionImage: UIImageView!
    
    var question: PicScrambleImageQuestion!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setViewModel(viewModel: PicScrambleImageQuestion) {
        self.question = viewModel
        self.questionImage.af_setImage(withURL: URL(string: self.question.imageUrl)!, placeholderImage: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
