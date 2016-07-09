//
//  NoBudgetCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/9/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation

class NoBudgetCell: BunnyCell {
    
    var noBudgetString: String = ""
    
    init(noBudgetStringKey: String, cellIdentifier: String, cellSettings: NSDictionary) {
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
        self.noBudgetString = BunnyUtils.uncommentedLocalizedString(noBudgetStringKey)
    }
}
