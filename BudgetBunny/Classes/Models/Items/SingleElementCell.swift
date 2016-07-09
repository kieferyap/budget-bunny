//
//  SingleElementCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/9/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation

class SingleElementCell: BunnyCell {

    var alphaElementTitle: String = ""
    
    init(
        alphaElementTitleKey: String,
        cellIdentifier: String,
        cellSettings: NSDictionary
    ) {
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
        self.alphaElementTitle = BunnyUtils.uncommentedLocalizedString(alphaElementTitleKey)
    }
    
}
