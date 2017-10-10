//
//  SourceObject.swift
//  NetNews
//
//  Created by Thanhbv on 9/12/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import ObjectMapper

class SourceObject: Mappable {

    var id = -1
    var image : String?
    var name: String?
    
    required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["ID"]
        image <- map["Image"]
        name <- map["Name"]
    }
}
