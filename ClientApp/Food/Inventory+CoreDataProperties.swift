//
//  Inventory+CoreDataProperties.swift
//  Food
//
//  Created by student on 18.12.2018.
//  Copyright © 2018 sfedu. All rights reserved.
//
//

import Foundation
import CoreData


extension Inventory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Inventory> {
        return NSFetchRequest<Inventory>(entityName: "Inventory")
    }

    @NSManaged public var amount: Float
    @NSManaged public var detail: String?
    @NSManaged public var hotcold: Bool
    @NSManaged public var name: String?
    @NSManaged public var type: String?
    @NSManaged public var photo: String?
    @NSManaged public var id: Int64

}
