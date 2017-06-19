//
// Created by Prateek Grover on 18/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func underlined() -> NSAttributedString {
        let attributes = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        return NSAttributedString(string: self, attributes: attributes)
    }
}
