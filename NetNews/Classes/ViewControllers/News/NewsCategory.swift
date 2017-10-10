//
//  NewsCategory.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsCategory: Mappable {
    
    var id: Int?
    var image: String?
    var index: NSNumber?
    var name: String?
    
    required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        id <- map["ID"]
        image <- map["Image"]
        name <- map["Name"]
    }

}
