//
//  TVCategory.swift
//  NetNews
//
//  Created by Thanhbv on 8/31/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import ObjectMapper

class TVCategory: Mappable {

    var id = -1
    var image: String?
    var index: NSNumber?
    var name: String?
    
    init() {
    
    }
    
    required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["ID"]
        image <- map["Image"]
        name <- map["Name"]
    }
}
