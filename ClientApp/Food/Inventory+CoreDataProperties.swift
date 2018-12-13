//
//  Inventory+CoreDataProperties.swift
//  Food
//
//  Created by student on 11.12.2018.
//  Copyright © 2018 sfedu. All rights reserved.
//
//

import Foundation
import CoreData


extension Inventory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Inventory> {
        return NSFetchRequest<Inventory>(entityName: "Inventory")
    }

    @NSManaged public var hotcold: Bool
    @NSManaged public var name: String?
    @NSManaged public var amount: Float
    @NSManaged public var type: String?
    @NSManaged public var descr: String?
    @NSManaged public var inventprov: Provider?

}
