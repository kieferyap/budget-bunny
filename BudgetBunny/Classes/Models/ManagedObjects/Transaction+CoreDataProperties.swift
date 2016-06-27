//
//  Transaction+CoreDataProperties.swift
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

extension Transaction {

    @NSManaged var amount: NSNumber?
    @NSManaged var datetime: NSDate?
    @NSManaged var notes: String?
    @NSManaged var type: NSNumber?
    @NSManaged var accountId: Account?
    @NSManaged var budgetId: Budget?
    @NSManaged var categoryId: Category?
    @NSManaged var transactionTargetId: Target?
    @NSManaged var transferAccountId: Account?

}
