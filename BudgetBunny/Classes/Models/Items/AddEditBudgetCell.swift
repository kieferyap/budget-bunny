//
//  AddEditBudgetCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/24/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation
import UIKit

class AddEditBudgetCell: BunnyCell {

    var field: String = ""
    var placeholder: String = ""
    var isSelected: Bool = false
    
    init(fieldKey: String, placeholderKey: String, cellIdentifier: String, cellSettings: NSDictionary) {
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
        self.field = BunnyUtils.uncommentedLocalizedString(fieldKey)
        self.placeholder = BunnyUtils.uncommentedLocalizedString(placeholderKey)
    }
    
    func setCellPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
    
}
