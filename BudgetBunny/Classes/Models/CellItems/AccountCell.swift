//
//  AccountCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AccountCell: BunnyCell {

    var isDefault: Bool = false
    var accountName: String = ""
    var currencySymbol: String = ""
    var currencyIdentifier: String = ""
    var amount: Double = 0.0
    var accountObject: NSManagedObject
    
    init(accountObject: NSManagedObject, isDefault: Bool, accountName: String, currencyIdentifier: String, amount: Double) {
        // Set currency
        let currency = Currency()
        currency.setAttributes(currencyIdentifier)
        
        self.isDefault = isDefault
        self.accountName = accountName
        self.amount = amount
        self.accountObject = accountObject
        self.currencyIdentifier = currencyIdentifier
        self.currencySymbol = currency.currencySymbol.stringByAppendingString(" ")
        super.init(cellIdentifier: Constants.CellIdentifiers.account, cellSettings: [:])
    }
}
