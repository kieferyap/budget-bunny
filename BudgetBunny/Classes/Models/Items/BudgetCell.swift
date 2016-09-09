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

class BudgetCell: TripleElementCell {

    var budgetAmount: Double = 0.0
    var remainingAmount: Double = 0.0
    var budgetObject: NSManagedObject
    var currencyIdentifier: String = ""
    
    init(
        budgetObject: NSManagedObject,
        budgetName: String,
        budgetAmount: Double,
        remainingAmount: Double,
        currencyIdentifier: String
    ) {
        self.budgetObject = budgetObject
        self.budgetAmount = budgetAmount
        self.remainingAmount = remainingAmount
        self.currencyIdentifier = currencyIdentifier
        super.init(
            alphaElementTitleKey: budgetName,
            betaElementTitleKey: BunnyUtils.getFormattedAmount(remainingAmount, identifier: currencyIdentifier),
            gammaElementTitleKey: BunnyUtils.getFormattedAmount(budgetAmount, identifier: currencyIdentifier),
            cellIdentifier: Constants.CellIdentifiers.budget,
            cellSettings: [:]
        )
    }
    
}
