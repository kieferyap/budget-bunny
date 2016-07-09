//
//  TripleElementCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/9/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation

class TripleElementCell: DoubleElementCell {

    var gammaElementTitle: String = ""
    
    init(
        alphaElementTitleKey: String,
        betaElementTitleKey: String,
        gammaElementTitleKey: String,
        cellIdentifier: String,
        cellSettings: NSDictionary
    ) {
        super.init(
            alphaElementTitleKey: BunnyUtils.uncommentedLocalizedString(alphaElementTitleKey),
            betaElementTitleKey: BunnyUtils.uncommentedLocalizedString(betaElementTitleKey),
            cellIdentifier: cellIdentifier,
            cellSettings: cellSettings
        )
        self.gammaElementTitle = BunnyUtils.uncommentedLocalizedString(gammaElementTitleKey)
    }
    
}
