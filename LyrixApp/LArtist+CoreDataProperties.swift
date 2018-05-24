//
//  LArtist+CoreDataProperties.swift
//  LyrixApp
//
//  Created by sachila on 5/20/18.
//  Copyright © 2018 Infinity. All rights reserved.
//
//

import Foundation
import CoreData


extension LArtist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LArtist> {
        return NSFetchRequest<LArtist>(entityName: "LArtist")
    }

    @NSManaged public var lId: Int32
    @NSManaged public var lName: String?
    @NSManaged public var lImage: NSData?
    @NSManaged public var songs: LSongs?

}

// MARK: Generated accessors for songs
extension LArtist {

    @objc(addSongsObject:)
    @NSManaged public func addToSongs(_ value: LSongs)

    @objc(removeSongsObject:)
    @NSManaged public func removeFromSongs(_ value: LSongs)

    @objc(addSongs:)
    @NSManaged public func addToSongs(_ values: NSSet)

    @objc(removeSongs:)
    @NSManaged public func removeFromSongs(_ values: NSSet)

}
