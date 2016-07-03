//
//  BudgetCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/3/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BudgetCell: BunnyCell {

    var budgetName: String = ""
    var budgetAmount: Double = 0.0
    var amountRemaining: Double = 0.0
    var budgetObject: NSManagedObject
    
    init(
        budgetObject: NSManagedObject,
        budgetName: String,
        budgetAmount: Double,
        amountRemaining: Double
    ) {
        self.budgetObject = budgetObject
        self.budgetName = budgetName
        self.budgetAmount = budgetAmount
        self.amountRemaining = amountRemaining
        super.init(cellIdentifier: Constants.CellIdentifiers.budget, cellSettings: [:])
    }
    
}
