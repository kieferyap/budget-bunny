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
    
    func swipeCellLeftAndSetAsDefaultWithIndex(index: UInt){
        self.swipeCellLeftWithIndex(index)
        self.app.tables.buttons["Set Default"].tap()
    }
    
    func swipeCellLeftAndViewWithIndex(index: UInt){
        self.swipeCellLeftWithIndex(index)
        self.app.tables.buttons["View"].tap()
    }
    
    func swipeCellLeftAndDeleteWithIndex(index: UInt){
        self.swipeCellLeftWithIndex(index)
        self.app.tables.buttons["Delete"].tap()
        self.app.sheets["Warning: This action cannot be undone."].collectionViews.buttons["Delete Account"].tap()
    }
    
    func assertCellCount(count: UInt) {
        XCTAssertEqual(self.app.tables.cells.count, count)
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
        return self.app.tables.cells.elementAtIndex(index)
    }

}
