//
//  VideoObject.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import ObjectMapper

class VideoObject: Mappable {

    var cid = -1
    var id = -1
    var image: String?
    var media_url: String?
    var pid = -1
    var title: String?
    var url: String?

    
    required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        cid <- map["Cid"]
        id <- map["ID"]
        image <- map["Image"]
        media_url <- map["Media_url"]
        pid <- map["Pid"]
        title <- map["Title"]
        url <- map["Url"]
    }
    
}
