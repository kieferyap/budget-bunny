//
//  AccountCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation
import UIKit

class AccountCell: BunnyCell {

    var isDefault: Bool = false
    var accountName: String = ""
    var currencySymbol: String = ""
    var amount: String = ""
    
    init?(isDefault: Bool, accountName: String, currencySymbol: String, amount: String, cellIdentifier: String, cellSettings: NSDictionary) {
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
        self.isDefault = isDefault
        self.accountName = accountName
        self.currencySymbol = currencySymbol
        self.amount = amount
    }
    
}
