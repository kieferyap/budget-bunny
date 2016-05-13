//
//  Account+CoreDataProperties.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Account {

    @NSManaged var currency: String?
    @NSManaged var isDefault: NSNumber?
    @NSManaged var name: String?
    @NSManaged var amount: NSNumber?
    @NSManaged var accountBudgetId: Budget?
    @NSManaged var accountRecordId: Record?
    @NSManaged var accountTargetId: Target?
    @NSManaged var accountTransactionId: Transaction?
    @NSManaged var accountTransferTransactionId: Transaction?

}
