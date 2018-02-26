//
//  Fooddetaills+CoreDataProperties.swift
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

extension Fooddetaills {

    @NSManaged var hours: String?
    @NSManaged var item: String?
    @NSManaged var itemstring: String?
    @NSManaged var mins: String?
    @NSManaged var phoneno: String?
    @NSManaged var qty: String?
    @NSManaged var qtystring: String?
    @NSManaged var serves: String?
    @NSManaged var vnonveg: String?
    @NSManaged var currentdate: String!

}
