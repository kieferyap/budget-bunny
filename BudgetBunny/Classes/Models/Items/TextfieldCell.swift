//
//  LabelFieldCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/8/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TextFieldCell: BunnyCell {

    var textFieldPlaceholder: String = ""
    
    init(placeholderKey: String, cellIdentifier: String, cellSettings: NSDictionary) {
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
        self.textFieldPlaceholder = BunnyUtils.uncommentedLocalizedString(placeholderKey)
    }

}
