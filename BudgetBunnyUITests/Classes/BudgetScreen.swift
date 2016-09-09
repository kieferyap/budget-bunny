//
//  BudgetScreen.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/29/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class BudgetScreen: BaseScreen {

    func tapAddBudgetButton() {
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_BUDGETS)
        ].buttons["+"].tap()
    }
    
    func tapSegmentedControlMonthly() {
        self.tapSegmentedControlIndex(TestConstants.Budgets.idxSegmentedControlMonthly)
    }
    
    func tapSegmentedControlWeekly() {
        self.tapSegmentedControlIndex(TestConstants.Budgets.idxSegmentedControlWeekly)
    }
    
    func tapSegmentedControlDaily() {
        self.tapSegmentedControlIndex(TestConstants.Budgets.idxSegmentedControlDaily)
    }
    
    private func tapSegmentedControlIndex(index: UInt) {
        self.app.segmentedControls.buttons.elementAtIndex(index).tap()
    }
}
