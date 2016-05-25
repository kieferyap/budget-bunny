//
//  AccountScreen.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/7/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class AccountScreen: BaseScreen {
        
    func tapAddAccountButton() {
        self.app.navigationBars["Account"].buttons["+"].tap()
    }
    
    func swipeCellLeftWithIndex(index: UInt) {
        self.getTableElementAtIndex(index).swipeLeft()
    }
    
    func assertCellTextWithIndex(index: UInt, textToFind: String) {
        XCTAssertTrue(self.getTableElementAtIndex(index).staticTexts[textToFind].exists)
    }
    
    func assertCellTextInexistenceWithIndex(index: UInt, textToFind: String) {
        XCTAssertFalse(self.getTableElementAtIndex(index).staticTexts[textToFind].exists)
    }
    
    func assertCellIsDefaultAccount(index: UInt) {
        self.assertCellTextWithIndex(index, textToFind: "DEFAULT")
    }
    
    func assertCellIsNotDefaultAccount(index: UInt) {
        self.assertCellTextInexistenceWithIndex(index, textToFind: "DEFAULT")
    }
    
    func tapCellWithIndex(index: UInt) {
        self.getTableElementAtIndex(index).tap()
    }
    
    private func getTableElementAtIndex(index: UInt) -> XCUIElement {
        return XCUIApplication().tables.cells.elementAtIndex(index)
    }

}
