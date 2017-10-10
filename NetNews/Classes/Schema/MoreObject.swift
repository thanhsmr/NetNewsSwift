//
//  MoreObject.swift
//  NetNews
//
//  Created by Thanhbv on 9/1/17.
//  Copyright © 2017 Viettel Media. All rights reserved.
//

import UIKit

enum moreType : Int {
    case categoriesLiked = 0
    case timerShutdown = 1
    case autoDownloadNextArticle = 2
    case darkMode = 3
    case changeTextSize = 4
    case download = 5
    case notification = 6
    case otherApp = 7
    case feedback = 8
    
}

struct MoreObject {
    var image : String!
    var name : String!
    var type : moreType!
    
    
    static func getListMoreObject() -> [MoreObject] {
        var moreObjects = [MoreObject]()
        moreObjects.append(MoreObject.init(image: "ic_more_heart", name: "Chuyên mục yêu thích", type : .categoriesLiked))
        moreObjects.append(MoreObject.init(image: "ic_more_time", name: "Hẹn giờ tắt ứng dụng", type : .timerShutdown))
        moreObjects.append(MoreObject.init(image: "ic_more_auto_dowload", name: "Tự động tải tin kế tiếp", type : .autoDownloadNextArticle))
        moreObjects.append(MoreObject.init(image: "ic_more_night", name: "Chế độ ban đêm", type : .darkMode))
        moreObjects.append(MoreObject.init(image: "ic_more_incrementText", name: "Tăng giảm cỡ chữ", type : .changeTextSize))
        moreObjects.append(MoreObject.init(image: "ic_more_offline", name: "Tải Offline", type : .download))
        moreObjects.append(MoreObject.init(image: "ic_more_alarm", name: "Thông báo", type : .notification))
        moreObjects.append(MoreObject.init(image: "ic_more_app", name: "Ứng dụng khác", type : .otherApp))
        moreObjects.append(MoreObject.init(image: "ic_more_feedback", name: "Phản hồi", type : .feedback))
        return moreObjects
    }
}
