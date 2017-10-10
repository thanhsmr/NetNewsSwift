//
//  TopNowObject.swift
//  NetNews
//
//  Created by Thanhbv on 9/12/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import ObjectMapper

class TopNowObject: Mappable {
    
    var categoryId = -1
    var categoryName : String?
    var color : String?
    var icon : String?
    var articles: [ArticleObject]?
    
    required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        categoryId <- map["CategoryID"]
        categoryName <- map["CategoryName"]
        color <- map["Color"]
        icon <- map["Icon"]
        articles <- map["data"]
    }

}
