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
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ACCOUNT)
        ].buttons["+"].tap()
    }
    
    func swipeCellLeftWithIndex(index: UInt) {
        self.getTableElementAtIndex(index).swipeLeft()
    }
    
    func swipeCellLeftAndSetAsDefaultWithIndex(index: UInt){
        self.swipeCellLeftWithIndex(index)
        self.app.tables.buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_SET_DEFAULT)
                .stringByReplacingOccurrencesOfString("\n", withString: " ")
        ].tap()
    }
    
    func swipeCellLeftAndViewWithIndex(index: UInt){
        self.swipeCellLeftWithIndex(index)
        self.app.tables.buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_EDIT)
        ].tap()
    }
    
    func swipeCellLeftAndDeleteWithIndex(index: UInt){
        self.swipeCellLeftWithIndex(index)
        self.app.tables.buttons[BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE)].tap()
        self.app.sheets[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_WARNING_DELETE_ACCOUNT_TITLE)
        ].collectionViews.buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT)
        ].tap()
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
        self.assertCellTextWithIndex(
            index,
            textToFind: BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_DEFAULT)
        )
    }
    
    func assertCellIsNotDefaultAccount(index: UInt) {
        self.assertCellTextInexistenceWithIndex(
            index,
            textToFind: BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_DEFAULT)
        )
    }
    
    func tapCellWithIndex(index: UInt) {
        self.getTableElementAtIndex(index).tap()
    }
    
    private func getTableElementAtIndex(index: UInt) -> XCUIElement {
        return self.app.tables.cells.elementAtIndex(index)
    }

}
