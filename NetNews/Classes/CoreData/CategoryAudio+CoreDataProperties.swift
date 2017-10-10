//
//  CategoryAudio+CoreDataProperties.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import Foundation
import CoreData


extension CategoryAudio {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryAudio> {
        return NSFetchRequest<CategoryAudio>(entityName: "CategoryAudio")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var index: NSNumber?
    @NSManaged public var name: String?

}
