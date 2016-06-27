//
//  Record+CoreDataProperties.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/27/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Record {

    @NSManaged var amount: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var accountId: Account?

}
