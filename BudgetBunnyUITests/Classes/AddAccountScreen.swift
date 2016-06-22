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
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ADD_ACCOUNT)
        ].buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DONE)
        ].tap()
    }
    
    func tapSaveButton() {
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_EDIT_ACCOUNT)
        ].buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_SAVE)
        ].tap()
    }
    
    func tapAccountNameTextField() {
        self.app.tables.staticTexts[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_NAME)
        ].tap()
    }
    
    func tapAmountTextField() {
        self.app.tables.cells.elementAtIndex(2).tap()
    }
    
    func tapIsDefaultSwitch() {
        self.app.tables.cells.switches[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_IS_DEFAULT_ACCOUNT)
                .stringByAppendingString(", ")
                .stringByAppendingString(
                    BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_IS_DEFAULT_ACCOUNT_DESCRIPTION
                    )
            )
        ].tap()
    }
    
    func tapCurrencyCell() {
        self.app.tables.cells.elementAtIndex(1).tap()
    }
    
    func typeAccountNameTextField(input: String) {
        self.app.tables.textFields.elementAtIndex(0).typeText(input)
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
    
    func returnToAccountScreenFromAdd() {
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ADD_ACCOUNT)
        ].buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ACCOUNT)
        ].tap()
    }
    
    func returnToAccountScreenFromEdit() {
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_EDIT_ACCOUNT)
        ].buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ACCOUNT)
        ].tap()
    }
    
    func assertButtonEnabled(buttonName: String, isEnabled: Bool) {
        XCTAssertEqual(self.app.tables.buttons[buttonName].enabled, isEnabled)
    }
    
    func tapDeleteButton() {
        self.tapButton(BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT))
        
        XCUIApplication().sheets[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_WARNING_DELETE_ACCOUNT_TITLE)
        ].collectionViews.buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT)
        ].tap()
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
