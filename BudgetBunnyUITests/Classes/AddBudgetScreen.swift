//
//  AddBudgetScreen.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/29/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class AddBudgetScreen: BaseScreen {
    
    func tapBudgetNameTextField() {
        self.app.tables.textFields.elementAtIndex(0).tap()
    }
    
    func tapAmountTextField() {
        self.app.tables.textFields.elementAtIndex(1).tap()
    }
    
    func tapAddCategoryTextField() {
        self.app.tables.textFields.elementAtIndex(2).tap()
    }
}
