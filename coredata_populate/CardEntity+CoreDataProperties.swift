//
//  CardEntity+CoreDataProperties.swift
//  coredata_populate
//
//  Created by Alexey Smirnov on 3/12/20.
//  Copyright © 2020 Alexey Smirnov. All rights reserved.
//
//

import Foundation
import CoreData


extension CardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardEntity> {
        return NSFetchRequest<CardEntity>(entityName: "CardEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var pinyin: String?
    @NSManaged public var translation: String?
    @NSManaged public var wordSimp: String?
    @NSManaged public var wordTrad: String?
    @NSManaged public var list: ListEntity?

}
