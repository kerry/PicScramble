//
// Created by Prateek Grover on 18/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import Swinject

class DependencyManager {
    private static let sharedInstance = DependencyManager()

    class func getInstance() -> DependencyManager {
        return self.sharedInstance
    }

    var assembler: Assembler

    private init() {
        self.assembler = Assembler([
                HomeFactory()
        ])
    }
}