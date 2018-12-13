//
//  Comment+CoreDataProperties.swift
//  Food
//
//  Created by student on 11.12.2018.
//  Copyright © 2018 sfedu. All rights reserved.
//
//

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var info: String?

}
