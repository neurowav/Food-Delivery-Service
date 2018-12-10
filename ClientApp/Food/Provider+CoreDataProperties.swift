//
//  Provider+CoreDataProperties.swift
//  Food
//
//  Created by Misha on 08/12/2018.
//  Copyright © 2018 sfedu. All rights reserved.
//
//

import Foundation
import CoreData


extension Provider {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Provider> {
        return NSFetchRequest<Provider>(entityName: "Provider")
    }

    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var web_site: String?
    @NSManaged public var rating: String?

}
