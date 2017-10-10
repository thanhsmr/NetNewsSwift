//
//  NewsHomeObject.swift
//  NetNews
//
//  Created by Thanhbv on 9/11/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import ObjectMapper

class NewsHomeObject: Mappable {
    
    var header: String?
    var position = -1
    var data: [ArticleObject]?
    
    
    required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        header <- map["Header"]
        position <- map["Position"]
        data <- map["data"]
    }

}
