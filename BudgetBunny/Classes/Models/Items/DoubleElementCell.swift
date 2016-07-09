//
//  DoubleElementCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/9/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
import Foundation

class DoubleElementCell: SingleElementCell {
    
    var betaElementTitle: String = ""
    
    init(
        alphaElementTitleKey: String,
        betaElementTitleKey: String,
        cellIdentifier: String,
        cellSettings: NSDictionary
    ) {
        super.init(
            alphaElementTitleKey: BunnyUtils.uncommentedLocalizedString(alphaElementTitleKey),
            cellIdentifier: cellIdentifier,
            cellSettings: cellSettings
        )
        self.betaElementTitle = BunnyUtils.uncommentedLocalizedString(betaElementTitleKey)
    }
    
}
