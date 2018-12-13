//
//  Provider+CoreDataProperties.swift
//  Food
//
//  Created by student on 11.12.2018.
//  Copyright © 2018 sfedu. All rights reserved.
//
//

import Foundation
import CoreData


extension Provider {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Provider> {
        return NSFetchRequest<Provider>(entityName: "Provider")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var site: String?
    @NSManaged public var provcomment: NSSet?

}

// MARK: Generated accessors for provcomment
extension Provider {

    @objc(addProvcommentObject:)
    @NSManaged public func addToProvcomment(_ value: Comment)

    @objc(removeProvcommentObject:)
    @NSManaged public func removeFromProvcomment(_ value: Comment)

    @objc(addProvcomment:)
    @NSManaged public func addToProvcomment(_ values: NSSet)

    @objc(removeProvcomment:)
    @NSManaged public func removeFromProvcomment(_ values: NSSet)

}
