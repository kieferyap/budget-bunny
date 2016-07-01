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
        self.app.tables.cells.elementAtIndex(TestConstants.AddAccount.idxAmountCell).tap()
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
        self.app.tables.cells.elementAtIndex(TestConstants.AddAccount.idxCurrencyCell).tap()
    }
    
    func typeAccountNameTextField(input: String) {
        self.app.tables.textFields.elementAtIndex(TestConstants.AddAccount.idxAccountNameTextField).typeText(input)
    }
    
    func typeAmountTextField(input: String) {
        self.app.tables.textFields.elementAtIndex(TestConstants.AddAccount.idxAmountTextField).typeText(input)
    }
    
    func assertAccountNameTextFieldEquality(desiredValue: String) {
        self.assertTextFieldEquality(TestConstants.AddAccount.idxAccountNameTextField, desiredValue: desiredValue)
    }
    
    func assertAmountTextFieldEquality(desiredValue: String) {
        self.assertTextFieldEquality(TestConstants.AddAccount.idxAmountTextField, desiredValue: desiredValue)
    }
    
    func assertCurrencyLabelEquality(desiredValue: String) {
        self.app.tables.cells.elementAtIndex(TestConstants.AddAccount.idxCurrencyCell).staticTexts[desiredValue].exists
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
    
    func deleteAndEnterAmountText(newText: String, deleteDuration: Double) {
        self.app.keys["Delete"].pressForDuration(deleteDuration)
        self.app.tables.textFields.elementAtIndex(TestConstants.AddAccount.idxAmountTextField).typeText(newText)
    }
    
    func deleteAndEnterAccountNameText(newText: String, deleteDuration: Double) {
        self.app.keys["delete"].pressForDuration(deleteDuration)
        self.app.tables.textFields.elementAtIndex(TestConstants.AddAccount.idxAccountNameTextField).typeText(newText)
    }
    
    func tapOutside() {
        self.app.childrenMatchingType(.Window).elementBoundByIndex(0).childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Table).element.tap()
    }
    
    func tapAllInfoCells() {
        self.app.tables.cells.elementAtIndex(TestConstants.AddAccount.idxAccountNameCell).tap()
        self.app.tables.cells.elementAtIndex(TestConstants.AddAccount.idxCurrencyCell).tap()
        self.app.tables.cells.elementAtIndex(TestConstants.AddAccount.idxAmountCell).tap()
    }
    
    private func assertTextFieldEquality(index: UInt, desiredValue: String) {
        let textFieldValue = self.app.tables.textFields.elementAtIndex(index).value as! String
        XCTAssertEqual(textFieldValue, desiredValue)
    }
}
