//
//  AddEditAccountCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/16/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation


class AddEditAccountCell: NSObject {
    var field: String = ""
    var placeholder: String = ""
    var cellIdentifier: String = ""
    var cellSettings: NSDictionary = [:]
    
    init(field: String, placeholder: String, cellIdentifier: String, cellSettings: NSDictionary) {
        self.field = field
        self.placeholder = placeholder
        self.cellIdentifier = cellIdentifier
        self.cellSettings = cellSettings
    }
    
    override init() {
        self.field = ""
        self.placeholder = ""
        self.cellIdentifier = ""
        self.cellSettings = [:]
    }
    
    func setCellPlaceholder(placeholder: String) {
        self.placeholder = placeholder
    }
}