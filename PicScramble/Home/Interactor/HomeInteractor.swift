//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import Alamofire

class HomeInteractor: HomeInteractorInput {
    weak var output: HomeInteractorOutput!
    var requestArray: [Alamofire.Request] = []
    
    func fetchImages() {
        let request = Networking.sharedInstance.get("/") { (data: FlickrObject?, error: Error?) in
            guard error == nil else {
                self.output.errorfetchingImages(error: error!)
                return
            }
            guard let imageArray = data?.items else {
                return
            }
            self.output.fetchedImages(images: Array(imageArray.prefix(9)))
        }
        self.requestArray.append(request)
    }
    
    deinit {
        self.requestArray.forEach({ $0.cancel() })
    }
}
