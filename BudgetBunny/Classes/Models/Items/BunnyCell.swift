//
//  BunnyCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/2/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation

class BunnyCell: NSObject {
    
    var cellIdentifier: String = ""
    var cellSettings: NSDictionary = [:]
    
    init(cellIdentifier: String, cellSettings: NSDictionary) {
        self.cellIdentifier = cellIdentifier
        self.cellSettings = cellSettings
    }

}
