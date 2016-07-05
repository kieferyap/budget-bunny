//
//  IncomeCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/3/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class IncomeCell: BunnyCell {

    var field: String = ""
    var value: String = ""
    var placeholder: String = ""
    
    init(fieldKey: String, valueKey: String, placeholderKey: String, cellIdentifier: String, cellSettings: NSDictionary) {
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
        self.field = BunnyUtils.uncommentedLocalizedString(fieldKey)
        self.value = BunnyUtils.uncommentedLocalizedString(valueKey)
        self.placeholder = BunnyUtils.uncommentedLocalizedString(placeholderKey)
    }
}
