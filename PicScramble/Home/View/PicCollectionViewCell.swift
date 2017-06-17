//
//  PicCollectionViewCell.swift
//  PicScramble
//
//  Created by Pratik Grover on 17/06/17.
//  Copyright © 2017 Personal. All rights reserved.
//

import UIKit
import AlamofireImage

class PicCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var randomImage: UIImageView!
    
    static getReusableIdentifier() -> String {
        return "PicScrambleCell"
    }

    func configure(imageUrl: String) {
        guard let url = URL(string: imageUrl) else {
            //add broken image
            return
        }
        //TODO: add broken image above and add default image here
        self.randomImage.af_setImage(withURL: url, placeholderImage: nil)
    }
}
