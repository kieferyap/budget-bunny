//
//  Account+CoreDataProperties.swift
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

extension Account {

    @NSManaged var amount: NSNumber?
    @NSManaged var currency: String?
    @NSManaged var isDefault: NSNumber?
    @NSManaged var name: String?
    @NSManaged var accountRecordId: Record?
    @NSManaged var accountTargetId: Target?
    @NSManaged var accountTransactionId: Transaction?
    @NSManaged var accountTransferTransactionId: Transaction?

}
