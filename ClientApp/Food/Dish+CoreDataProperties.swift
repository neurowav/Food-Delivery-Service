//
//  Dish+CoreDataProperties.swift
//  Food
//
//  Created by Misha on 08/12/2018.
//  Copyright © 2018 sfedu. All rights reserved.
//
//

import Foundation
import CoreData


extension Dish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dish> {
        return NSFetchRequest<Dish>(entityName: "Dish")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var hot_cold: String?
    @NSManaged public var type: String?

}
