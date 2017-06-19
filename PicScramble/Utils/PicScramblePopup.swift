//
//  PicScramblePopup.swift
//  PicScramble
//
//  Created by Prateek Grover on 18/06/17.
//  Copyright © 2017 Personal. All rights reserved.
//

import Foundation
import PopupDialog

class PicScramblePopup {
    
    static let sharedInstance = PicScramblePopup()
    
    init() {
        self.configure()
    }
    
    func configure() {
        let popupAppearance = PopupDialogContainerView.appearance()
        
        popupAppearance.backgroundColor = UIColor.white
        
        let ov = PopupDialogOverlayView.appearance()
        ov.blurEnabled = false
        ov.opacity     = 0.7
        ov.color       = UIColor.black
    }
    
    func showImageQuestion(viewController: QuestionViewController,
                        presentingViewController: UIViewController?) {
        let popup = PopupDialog(viewController: viewController,
                                buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn,
                                gestureDismissal: false,
                                completion: nil
        )
        let okButton = DefaultButton(title: "Okay", action: nil)
        popup.addButtons([okButton])
        presentingViewController?.present(popup, animated: true, completion: nil)
    }
}
