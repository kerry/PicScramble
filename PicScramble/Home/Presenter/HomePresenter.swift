//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: NSObject, HomeViewOutput, HomeInteractorOutput {
    weak var view: HomeViewInput!
    var output: HomeInteractorInput!

    override init() {
        super.init()
    }

    func viewIsReady() {
        self.output.fetchImages()
    }
    
    func fetchedImages(images: [FlickrImage]) {
        
    }
    
    func errorfetchingImages(error: Error) {
        
    }
}
