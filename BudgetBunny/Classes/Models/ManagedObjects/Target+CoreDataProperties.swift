//
//  Target+CoreDataProperties.swift
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

extension Target {

    @NSManaged var actualAmount: NSNumber?
    @NSManaged var targetAmount: NSNumber?
    @NSManaged var accountId: Account?
    @NSManaged var targetWishitemId: Wishitem?
    @NSManaged var transactionId: Transaction?

}
