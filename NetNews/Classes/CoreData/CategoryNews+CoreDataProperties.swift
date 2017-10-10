//
//  CategoryNews+CoreDataProperties.swift
//  Netnews
//
//  Created by Thanhbv on 8/29/17.
//  Copyright © 2017 Viettel. All rights reserved.
//

import Foundation
import CoreData


extension CategoryNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryNews> {
        return NSFetchRequest<CategoryNews>(entityName: "CategoryNews")
    }

    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var index: NSNumber?
    @NSManaged public var name: String?

}
