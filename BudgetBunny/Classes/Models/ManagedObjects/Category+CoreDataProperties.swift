//
//  Category+CoreDataProperties.swift
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

extension Category {

    @NSManaged var name: String?
    @NSManaged var isIncome: NSNumber?
    @NSManaged var monthlyAmount: NSNumber?
    @NSManaged var budgetId: Budget?
    @NSManaged var categoryTransactionId: Transaction?

}
