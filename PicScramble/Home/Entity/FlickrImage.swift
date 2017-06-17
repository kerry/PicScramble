//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import ObjectMapper

class FlickrImage: Mappable {
    var imageUrl: String!

    required init(map: Map) {
    }

    func mapping(map: Map) {
        imageUrl <- map["items.media.m"]
    }
}
