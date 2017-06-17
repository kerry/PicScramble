//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation

protocol HomeInteractorOutput {
    func fetchedImages(images: [FlickrImage])
    func errorfetchingImages(error: Error)
}
