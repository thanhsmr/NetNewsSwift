//
//  BodyDetailArticle.swift
//  NetNews
//
//  Created by Thanhbv on 9/6/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import ObjectMapper

class BodyDetailArticle: Mappable {

    var height = 0
    var type = 0
    var width = 0
    var category = 0
    var poster: String?
    var content: String?
    var media: String?
    var contentAtributeString: NSAttributedString?
    
    required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        height <- map["Height"]
        type <- map["Type"]
        width <- map["Width"]
        poster <- map["Poster"]
        content <- map["Content"]
        media <- map["Media"]
        
        DispatchQueue.global().async {
            // type text
            if self.type == 1 {
                self.contentAtributeString = self.content?.htmlToAttributedString
            }
        }

    }
}
