//
//  IncomeCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/8/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation

class IncomeCell: DoubleLabelCell {

    var incomeValue: Double = 0.0
    var currencyIdentifier: String = ""
    
    init(incomeValue: Double, labelTitleKey: String, labelValueKey: String, cellIdentifier: String, cellSettings: NSDictionary) {
        self.incomeValue = incomeValue
        super.init(
            labelTitleKey: labelTitleKey,
            labelValueKey: labelValueKey,
            cellIdentifier: cellIdentifier,
            cellSettings: cellSettings
        )
    }
    
}
