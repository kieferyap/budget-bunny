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
    var currencyIdentifier: String = ""
    
    init(
        budgetObject: NSManagedObject,
        budgetName: String,
        budgetAmount: Double,
        amountRemaining: Double,
        currencyIdentifier: String
    ) {
        self.budgetObject = budgetObject
        self.budgetName = budgetName
        self.budgetAmount = budgetAmount
        self.amountRemaining = amountRemaining
        self.currencyIdentifier = currencyIdentifier
        super.init(cellIdentifier: Constants.CellIdentifiers.budget, cellSettings: [:])
    }
    
    func getFormattedBudgetAmount() -> String {
        return self.getFormattedAmount(self.budgetAmount)
    }
    
    func getFormattedAmountRemaining() -> String {
        return self.getFormattedAmount(self.amountRemaining)
    }
    
    private func getFormattedAmount(input: Double) -> String {
        let inputString = String(format: "%.2f", input)
        let currency = BunnyUtils.getCurrencyObjectFromIdentifier(self.currencyIdentifier)
        return currency.currencySymbol
            .stringByAppendingString(" ")
            .stringByAppendingString(inputString)
    }
    
}
