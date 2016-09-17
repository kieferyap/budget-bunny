//
//  IncomeCategoryCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/23/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class IncomeCategoryCell: DoubleElementCell {

    var categoryObject: NSManagedObject
    
    init(
        categoryObject: NSManagedObject,
        alphaElementTitleKey: String,
        betaElementTitleKey: String,
        cellIdentifier: String,
        cellSettings: NSDictionary)
    {
        self.categoryObject = categoryObject
        super.init(
            alphaElementTitleKey: alphaElementTitleKey,
            betaElementTitleKey: betaElementTitleKey,
            cellIdentifier: cellIdentifier,
            cellSettings: cellSettings
        )
    }
}
