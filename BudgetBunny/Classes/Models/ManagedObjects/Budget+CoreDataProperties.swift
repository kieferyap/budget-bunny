//
//  Budget+CoreDataProperties.swift
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

extension Budget {

    @NSManaged var monthlyBudget: NSNumber?
    @NSManaged var name: String?
    @NSManaged var monthlyRemainingBudget: NSNumber?
    @NSManaged var budgetCategoryId: Category?
    @NSManaged var budgetTransactionId: Transaction?

}
