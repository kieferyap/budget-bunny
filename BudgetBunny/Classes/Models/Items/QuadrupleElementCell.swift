//
//  QuadrupleElementCell.swift
//  BudgetBunny
//
//  Created by Opal Orca on 10/12/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class QuadrupleElementCell: TripleElementCell {

    var deltaElementTitle: String = ""
    
    init(
        alphaElementTitleKey: String,
        betaElementTitleKey: String,
        gammaElementTitleKey: String,
        deltaElementTitleKey: String,
        cellIdentifier: String,
        cellSettings: NSDictionary
    ) {
        super.init(
            alphaElementTitleKey: BunnyUtils.uncommentedLocalizedString(alphaElementTitleKey),
            betaElementTitleKey: BunnyUtils.uncommentedLocalizedString(betaElementTitleKey),
            gammaElementTitleKey: BunnyUtils.uncommentedLocalizedString(gammaElementTitleKey),
            cellIdentifier: cellIdentifier,
            cellSettings: cellSettings
        )
        self.deltaElementTitle = BunnyUtils.uncommentedLocalizedString(deltaElementTitleKey)
    }
}
