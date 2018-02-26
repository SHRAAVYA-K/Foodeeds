//
//  User+CoreDataProperties.swift
//  foodeeds
//
//  Created by Shashank on 16/02/17.
//  Copyright © 2017 SJBIT. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var phoneno: String?
    @NSManaged var signupbit: NSNumber?
    @NSManaged var username: String?

}
