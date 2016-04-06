//
//  Wishitem+CoreDataProperties.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/6/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Wishitem {

    @NSManaged var isBought: NSNumber?
    @NSManaged var name: String?
    @NSManaged var targetId: Target?

}
