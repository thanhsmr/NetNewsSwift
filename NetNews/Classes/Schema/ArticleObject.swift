//
//  ArticleObject.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit
import ObjectMapper

class ArticleObject: Mappable {
    
    var cateevent: String?
    var category: String?
    var cid = 0
    var comment_count: String?
    var content: String?
    var date: String?
    var id = 0
    var id_story: NSNumber?
    var image: String?
    var image169: String?
    var is_like: NSNumber?
    var is_listened: NSNumber?
    var is_playlist: NSNumber?
    var is_read: NSNumber?
    var like_count: String?
    var media_url: String?
    var number_line_title: NSNumber?
    var pid = 0
    var read_count: Int?
    var sapo: String?
    var title: String?
    var type: NSNumber?
    var type_icon: String?
    var url: String?
    var sourceName: String?
    var poster: String?
    var duration: String?
    var timeStamp: Double?
    var isNghe: NSNumber?
    
    //3 first content of page
    var bodies : [BodyDetailArticle]?
    
    

    required init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        cateevent <- map["cateevent"]
        category <- map["Category"]
        cid <- map["Cid"]
        comment_count <- map["Comment"]
        content <- map["Content"]
        date <- map["DatePub"]
        id <- map["ID"]
        id_story <- map["idStory"]
        image <- map["Image"]
        image169 <- map["Image169"]
        like_count <- map["Like"]
        media_url <- map["Media_url"]
        number_line_title <- map["number_line_title"]
        pid <- map["Pid"]
        read_count <- map["Reads"]
        sapo <- map["Shapo"]
        title <- map["Title"]
        type <- map["type"]
        type_icon <- map["type_icon"]
        url <- map["Url"]
        sourceName <- map["SourceName"]
        bodies <- map["Body"]
        duration <- map["Duration"]
        timeStamp <- map["Timestamp"]
        isNghe <- map["is_nghe"]
        is_read <- map["isRead"]
        poster <- map["Poster"]
    }
}
