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
    var amount: String = ""
    var accountObject: NSManagedObject
    
    init?(accountObject: NSManagedObject, isDefault: Bool, accountName: String, amount: String, cellIdentifier: String, cellSettings: NSDictionary) {
        self.isDefault = isDefault
        self.accountName = accountName
        self.amount = amount
        self.accountObject = accountObject
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
    }
    
}
