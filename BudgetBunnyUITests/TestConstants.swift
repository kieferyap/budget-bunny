//
//  Constants.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/3/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation

struct TestConstants {
    struct Accounts {
        static let account1 = ["test1", "1050", "Japan", "Japan: JPY (¥)", "¥ 1050"]
        static let account2 = ["test2", "10.50", "United States", "United States: USD ($)", "$ 10.50"]
        static let account2New = ["test3", "18.5", "United Kingdom", "United Kingdom: GBP (£)", "£ 18.50"]
        static let name = 0, amount = 1, country = 2, currencyText = 3, processedCurrency = 4
        static let idxDefault: UInt = 0, idxNormal: UInt = 1
    }
}