//
//  PicCollectionViewCell.swift
//  PicScramble
//
//  Created by Pratik Grover on 17/06/17.
//  Copyright © 2017 Personal. All rights reserved.
//

import UIKit
import AlamofireImage
import QuartzCore

enum PicScrambleImageState {
    case shown
    case hidden
}

class PicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var randomImage: UIImageView!

    var viewModel: PicScrambleViewModel!

    static func getReusableIdentifier() -> String {
        return "PicScrambleCell"
    }

    func configure(viewModel: PicScrambleViewModel, animated: Bool) {
        self.viewModel = viewModel
        guard let url = URL(string: viewModel.imageUrl) else {
            return
        }
        switch self.viewModel.imageState {
        case .hidden:
            if animated {
                self.switchState(newState: .hidden)
            } else {
                self.randomImage.image = nil
            }
        case .shown:
            //TODO: add broken image above and add default image here
            if animated {
                self.switchState(newState: .shown)
            } else {
                self.randomImage.af_setImage(withURL: url, placeholderImage: nil)
            }
        }
        self.isUserInteractionEnabled = self.viewModel.isClickable
    }

    func switchState(newState: PicScrambleImageState) {
        self.isUserInteractionEnabled = false
        switch newState {
        case .hidden:
            UIView.transition(with: self, duration: 1, options: .transitionFlipFromRight, animations: {
                self.randomImage.image = nil
            }) { (success) in
                self.viewModel.imageState = newState
                self.isUserInteractionEnabled = self.viewModel.isClickable
            }
        case .shown:
            UIView.transition(with: self, duration: 1, options: .transitionFlipFromRight, animations: {
                guard let url = URL(string: self.viewModel.imageUrl) else {
                    return
                }
                self.randomImage.af_setImage(withURL: url, placeholderImage: nil)
            }) { (success) in
                self.viewModel.imageState = newState
                self.isUserInteractionEnabled = self.viewModel.isClickable
            }
        }
    }

    func setClickable(_ isClickable: Bool) {
        self.isUserInteractionEnabled = isClickable
    }
}
