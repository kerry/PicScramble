//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class Networking {
    static let sharedInstance = Networking()
    
    typealias T = Mappable
    func get<T:Mappable>(_ url: String,
                         completionHandler: @escaping (T?, Error?) -> Void) -> Alamofire.Request {

        let fullUrl = AppSettings.NetworkSettings.flickrPublicUrl

        var urlRequest = URLRequest(url: URL(string: fullUrl)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        
        return Alamofire.request(urlRequest)
                .validate()
                .responseObject {(response: DataResponse<T>) in
                    switch response.result {
                    case .success(let result):
                        completionHandler(result, nil)
                        break
                    case .failure(let error):
                        completionHandler(nil, error)
                        break
                    }
                }
    }
}
