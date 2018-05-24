//
//  LCategory+CoreDataProperties.swift
//  LyrixApp
//
//  Created by sachila on 5/20/18.
//  Copyright © 2018 Infinity. All rights reserved.
//
//

import Foundation
import CoreData


extension LCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LCategory> {
        return NSFetchRequest<LCategory>(entityName: "LCategory")
    }

    @NSManaged public var lId: Int16
    @NSManaged public var lName: String?
    @NSManaged public var lDescription: String?
    @NSManaged public var category: LSongs?
    

}

// MARK: Generated accessors for category
extension LCategory {

    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: LSongs)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: LSongs)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)

}
