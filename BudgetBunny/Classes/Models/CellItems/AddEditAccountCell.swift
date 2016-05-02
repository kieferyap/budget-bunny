//
//  AddEditAccountCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/16/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation

class AddEditAccountCell: BunnyCell {
    
    var field: String = ""
    var placeholder: String = ""
    
    init(field: String, placeholder: String, cellIdentifier: String, cellSettings: NSDictionary) {
        self.field = field
        self.placeholder = placeholder
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
    }
    
    override init(){
        super.init()
    }
    
    func setCellPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}