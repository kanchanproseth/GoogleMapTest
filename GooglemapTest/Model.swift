//
//  Model.swift
//  GooglemapTest
//
//  Created by Cyberk on 3/12/17.
//  Copyright © 2017 Cyberk. All rights reserved.
//

import Foundation
import ObjectMapper

class predictions: Mappable{
    
    var description: String?
    var matched_substrings: [AnyObject]?
    var structured_formatting: AnyObject!
    var terms: [AnyObject]?

    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    // Mappable
    func mapping(map: Map) {
        description    <- map["description"]
        matched_substrings         <- map["matched_substrings"]
        structured_formatting      <- map["structured_formatting"]
        terms       <- map["terms"]
    }
 
    
}
