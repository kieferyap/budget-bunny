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
    
    lazy var field: String = {return ""}()
    lazy var placeholder: String = {return ""}()
    
    init?(field: String, placeholder: String, cellIdentifier: String, cellSettings: NSDictionary) {
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
        self.field = field
        self.placeholder = placeholder
    }
    
    
    
    func setCellPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}