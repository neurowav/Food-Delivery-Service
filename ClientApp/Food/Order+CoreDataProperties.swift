//
//  Order+CoreDataProperties.swift
//  Food
//
//  Created by student on 11.12.2018.
//  Copyright © 2018 sfedu. All rights reserved.
//
//

import Foundation
import CoreData


extension Order {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Order> {
        return NSFetchRequest<Order>(entityName: "Order")
    }

    @NSManaged public var status: String?
    @NSManaged public var orderdish: NSSet?

}

// MARK: Generated accessors for orderdish
extension Order {

    @objc(addOrderdishObject:)
    @NSManaged public func addToOrderdish(_ value: Inventory)

    @objc(removeOrderdishObject:)
    @NSManaged public func removeFromOrderdish(_ value: Inventory)

    @objc(addOrderdish:)
    @NSManaged public func addToOrderdish(_ values: NSSet)

    @objc(removeOrderdish:)
    @NSManaged public func removeFromOrderdish(_ values: NSSet)

}
