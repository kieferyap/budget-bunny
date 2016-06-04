//
//  AccountScreen.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/7/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class AddAccountScreen: BaseScreen {
    
    func tapDoneButton() {
        self.app.navigationBars["Add New Account"].buttons["Done"].tap()
    }
    
    func tapSaveButton() {
        self.app.navigationBars["Add New Account"].buttons["Save"].tap()
    }
    
    func tapErrorAlertOkButton() {
        self.app.alerts["Error"].collectionViews.buttons["OK"].tap()
    }
    
    func tapAccountNameTextField() {
        self.app.tables.staticTexts["Account Name"].tap()
    }
    
    func tapAmountTextFieldAdding() {
        self.app.tables.staticTexts["Starting Balance"].tap()
    }
    
    func tapAmountTextFieldEditing() {
        self.app.tables.staticTexts["Starting Balance"].tap()
    }
    
    func tapIsDefaultSwitch() {
        self.app.tables.cells.switches["Default Account, The default account to use for everyday transactions"].tap()
    }
    
    func tapCurrencyCell() {
        self.app.tables.cells.elementAtIndex(2).tap()
    }
    
    func typeAccountNameTextField(input: String) {
        self.app.tables.textFields["My Wallet"].typeText(input)
    }
    
    func typeAmountTextField(input: String) {
        self.app.tables.textFields.elementAtIndex(1).typeText(input)
    }
    
    func assertTextFieldEquality(key: String) {
        XCTAssertTrue(self.app.tables.textFields[key].exists)
    }
    
    func assertStaticTextEquality(key: String) {
        XCTAssertTrue(self.app.staticTexts[key].exists)
    }
    
    func returnToAccountScreen() {
        self.app.navigationBars["Add New Account"].buttons["Account"].tap()
    }
    
    func assertButtonEnabled(buttonName: String, isEnabled: Bool) {
        XCTAssertEqual(self.app.tables.buttons[buttonName].enabled, isEnabled)
    }
    
    func tapDeleteButton() {
        self.tapButton("Delete account")
        XCUIApplication().sheets["Warning: This action cannot be undone."].collectionViews.buttons["Delete account"].tap()
    }
    
    func tapButton(buttonName: String) {
        self.app.tables.buttons[buttonName].tap()
    }
    
    func deleteAndEnterDecimalText(newText: String, deleteDuration: Double) {
        XCUIApplication().keys["Delete"].pressForDuration(deleteDuration)
        self.app.tables.textFields.elementAtIndex(1).typeText(newText)
    }
    
    func deleteAndEnterAlphanumericText(newText: String, deleteDuration: Double) {
        XCUIApplication().keys["delete"].pressForDuration(deleteDuration)
        self.app.tables.textFields.elementAtIndex(0).typeText(newText)
    }
    
    func tapOutside() {
        self.app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Table).element.tap()
    }
    
    func tapAllInfoCells() {
        self.app.tables.cells.elementAtIndex(0).tap()
        self.app.tables.cells.elementAtIndex(2).tap()
        self.app.tables.cells.elementAtIndex(1).tap()
    }
    
}
