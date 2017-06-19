//
// Created by Prateek Grover on 18/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation

func getRandom(min: Int, max: Int) -> Int {
    return Int(arc4random_uniform(UInt32(UInt(max) - UInt(min) + UInt(1)))) + min
}
