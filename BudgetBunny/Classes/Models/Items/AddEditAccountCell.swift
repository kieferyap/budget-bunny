//
//  AddEditAccountCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/16/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation
import UIKit

class AddEditAccountCell: BunnyCell {
    
    var field: String = ""
    var placeholder: String = ""
    
    init(fieldKey: String, placeholder: String, cellIdentifier: String, cellSettings: NSDictionary) {
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
        self.field = BunnyUtils.uncommentedLocalizedString(fieldKey)
        self.placeholder = placeholder
    }
    
    func setCellPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}