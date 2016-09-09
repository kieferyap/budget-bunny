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

class AccountCell: DoubleElementCell {

    var isDefault: Bool = false
    var amount: Double = 0.0
    var accountObject: NSManagedObject
    var currencyIdentifier: String = ""
    
    init(
        accountObject: NSManagedObject,
        isDefault: Bool,
        accountName: String,
        currencyIdentifier: String,
        amount: Double
    ) {
        self.isDefault = isDefault
        self.amount = amount
        self.accountObject = accountObject
        self.currencyIdentifier = currencyIdentifier
        super.init(
            alphaElementTitleKey: accountName,
            betaElementTitleKey: BunnyUtils.getFormattedAmount(amount, identifier: currencyIdentifier),
            cellIdentifier: Constants.CellIdentifiers.account,
            cellSettings: [:]
        )
    }
}
