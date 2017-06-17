//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol NetworkingProtocol {
    associatedtype T
    func get<T:Mappable>(_ url: String,
                         completionHandler: @escaping ([T]?, Error?) -> Void) -> Alamofire.Request
}
