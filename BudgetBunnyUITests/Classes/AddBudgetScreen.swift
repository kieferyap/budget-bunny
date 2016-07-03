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
        self.tapTextFieldAtElement(TestConstants.AddBudget.idxBudgetNameCell)
    }
    
    func tapAmountTextField() {
        self.tapTextFieldAtElement(TestConstants.AddBudget.idxAmountCell)
    }
    
    func tapAddCategoryTextField() {
        self.app.tables.textFields["Add New Category"].tap()
    }
    
    func typeBudgetNameTextField(input: String) {
        self.tapBudgetNameTextField()
        self.typeTextFieldAtElement(TestConstants.AddBudget.idxBudgetNameCell, input: input)
    }
    
    func typeAmountTextField(input: String) {
        self.tapAmountTextField()
        self.typeTextFieldAtElement(TestConstants.AddBudget.idxAmountCell, input: input)
    }
    
    func typeCategoryTextField(input: String) {
        self.tapAddCategoryTextField()
        self.app.tables.textFields["Add New Category"].typeText(input)
        self.app.keyboards.buttons["Done"].tap()
    }
    
    func assertBudgetNameTextFieldEquality(match: String) {
        self.assertTextFieldEquality(TestConstants.AddBudget.idxBudgetNameCell, match: match)
    }
    
    func assertAmountTextFieldEquality(match: String) {
        self.assertTextFieldEquality(TestConstants.AddBudget.idxAmountCell, match: match)
    }
    
    func assertTextEqualityOfCategoryAtIndex(index: UInt, match: String) {
        let translatedIndex = (index + TestConstants.AddBudget.categoryIndexOffset)
        self.app.tables.cells.elementAtIndex(translatedIndex).staticTexts[match].exists
    }
    
    func assertAmountStaticTextEquality(match: String) {
        self.app.tables.cells
            .elementAtIndex(TestConstants.AddBudget.idxAmountCell)
            .staticTexts[match].exists
    }
    
    func tapDoneButton() {
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ADD_BUDGET)
        ].buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DONE)
        ].tap()
    }
    
    func tapBackButton() {
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ADD_BUDGET)
        ].buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_BUDGETS)
        ].tap()
    }
    
    private func assertTextFieldEquality(index: UInt, match: String) {
        let textFieldValue = self.app.tables.textFields.elementAtIndex(index).value as! String
        XCTAssertEqual(textFieldValue, match)
    }
    
    private func tapTextFieldAtElement(index: UInt) {
        self.app.tables.textFields.elementAtIndex(index).tap()
    }
    
    private func typeTextFieldAtElement(index: UInt, input: String) {
        self.app.tables.textFields.elementAtIndex(index).typeText(input)
    }
}
