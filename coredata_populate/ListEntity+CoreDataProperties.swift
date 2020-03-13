//
//  ListEntity+CoreDataProperties.swift
//  coredata_populate
//
//  Created by Alexey Smirnov on 3/12/20.
//  Copyright © 2020 Alexey Smirnov. All rights reserved.
//
//

import Foundation
import CoreData


extension ListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListEntity> {
        return NSFetchRequest<ListEntity>(entityName: "ListEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var wordCount: Int32
    @NSManaged public var cards: NSSet?

}

// MARK: Generated accessors for cards
extension ListEntity {

    @objc(addCardsObject:)
    @NSManaged public func addToCards(_ value: CardEntity)

    @objc(removeCardsObject:)
    @NSManaged public func removeFromCards(_ value: CardEntity)

    @objc(addCards:)
    @NSManaged public func addToCards(_ values: NSSet)

    @objc(removeCards:)
    @NSManaged public func removeFromCards(_ values: NSSet)

}
