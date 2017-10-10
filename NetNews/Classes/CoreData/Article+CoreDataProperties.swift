//
//  Article+CoreDataProperties.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var cateevent: String?
    @NSManaged public var category: String?
    @NSManaged public var cid: String?
    @NSManaged public var comment_count: String?
    @NSManaged public var content: String?
    @NSManaged public var date: String?
    @NSManaged public var id: String?
    @NSManaged public var id_story: NSNumber?
    @NSManaged public var image: String?
    @NSManaged public var image169: String?
    @NSManaged public var is_like: NSNumber?
    @NSManaged public var is_listened: NSNumber?
    @NSManaged public var is_playlist: NSNumber?
    @NSManaged public var is_read: NSNumber?
    @NSManaged public var like_count: String?
    @NSManaged public var media_url: String?
    @NSManaged public var number_line_title: NSNumber?
    @NSManaged public var pid: String?
    @NSManaged public var read_count: String?
    @NSManaged public var sapo: String?
    @NSManaged public var title: String?
    @NSManaged public var type: NSNumber?
    @NSManaged public var type_icon: String?
    @NSManaged public var url: String?

}
