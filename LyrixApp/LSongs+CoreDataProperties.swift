//
//  LSongs+CoreDataProperties.swift
//  LyrixApp
//
//  Created by sachila on 5/20/18.
//  Copyright © 2018 Infinity. All rights reserved.
//
//

import Foundation
import CoreData


extension LSongs {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LSongs> {
        return NSFetchRequest<LSongs>(entityName: "LSongs")
    }

    @NSManaged public var lId: Int16
    @NSManaged public var lName: String?
    @NSManaged public var limage: NSData?
    @NSManaged public var lLyrics: String?
    @NSManaged public var lUrl: String?
    @NSManaged public var artist: LArtist?
    @NSManaged public var category: LCategory?

}
