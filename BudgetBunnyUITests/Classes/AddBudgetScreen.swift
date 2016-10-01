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
        self.getTableElementAtIndex(translatedIndex).staticTexts[match].exists
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
    
    func tapSaveButton() {
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_EDIT_BUDGET)
        ].buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_SAVE)
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
    
    func deleteAndEnterBudgetNameText(newText: String, deleteDuration: Double) {
        self.tapBudgetNameTextField()
        self.app.keys["delete"].pressForDuration(deleteDuration)
        self.app.tables.textFields.elementAtIndex(TestConstants.AddBudget.idxBudgetNameCell).typeText(newText)
    }
    
    func deleteAndEnterBudgetAmountText(newText: String, deleteDuration: Double) {
        self.tapAmountTextField()
        self.app.keys["Delete"].pressForDuration(deleteDuration)
        self.app.tables.textFields.elementAtIndex(TestConstants.AddBudget.idxAmountCell).typeText(newText)
    }
    
    func tapDeleteBudgetButton() {
        let buttonName = BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_BUDGET)
        self.app.tables.buttons[buttonName].tap()
        
        XCUIApplication().sheets[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_DELETE_BUDGET_TITLE)
            ].collectionViews.buttons[
                BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_BUDGET)
            ].tap()
    }
    
    // MARK: Edit Budget Cell
    
    private func enterNewBudgetCategory(
        input: String,
        alertTitleKey: String,
        textFieldPlaceholderKey: String
    ) {
        let alertTitle = BunnyUIUtils.uncommentedLocalizedString(alertTitleKey)
        let textFieldPlaceholder = BunnyUIUtils.uncommentedLocalizedString(textFieldPlaceholderKey)
        let okButton = BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_OK)
        
        let collectionViewsQuery = self.app.alerts[alertTitle].collectionViews
        collectionViewsQuery.textFields[textFieldPlaceholder].typeText(input)
        collectionViewsQuery.buttons[okButton].tap()
    }
    
    func assertBudgetCategoryTextFieldEquality(match: String, index: UInt) {
        // "No budgets found" counts as one cell.
        let translatedIndex = index + TestConstants.AddBudget.categoryIndexOffset
        self.getTableElementAtIndex(translatedIndex).staticTexts[match].exists
    }
    
    private func swipeBudgetCategoryCellLeftAndTapButtonWithIndex(index: UInt, buttonNameKey: String) {
        let translatedIndex = index + TestConstants.AddBudget.categoryIndexOffset
        let buttonName = BunnyUIUtils.uncommentedLocalizedString(buttonNameKey)
        self.getTableElementAtIndex(translatedIndex).swipeLeft()
        self.app.tables.buttons[buttonName].tap()
    }
    
    private func tapBudgetCategoryCellAndTapButtonWithIndex(
        index: UInt,
        buttonNameKey: String
    ) {
        let translatedIndex = index + TestConstants.AddBudget.categoryIndexOffset
        let buttonName = BunnyUIUtils.uncommentedLocalizedString(buttonNameKey)
        self.getTableElementAtIndex(translatedIndex).tap()
        
        let alertTitle = BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_BUDGET_CATEGORY_ACTIONS)
        self.app.sheets[alertTitle].collectionViews.buttons[buttonName].tap()
    }
    
    private func deleteBudgetCategory() {
        let deleteCategory = BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_DELETE_CATEGORY_TITLE)
        let deleteBudgetCategory = BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_BUDGET_CATEGORY)
        self.app.sheets[deleteCategory].collectionViews.buttons[deleteBudgetCategory].tap()
    }
    
    func swipeBudgetCategoryCellLeftAndRenameWithIndex(index: UInt, newName: String) {
        self.swipeBudgetCategoryCellLeftAndTapButtonWithIndex(
            index,
            buttonNameKey: StringConstants.LABEL_RENAME
        )
        self.enterNewBudgetCategory(
            newName,
            alertTitleKey: StringConstants.LABEL_RENAME,
            textFieldPlaceholderKey: StringConstants.TEXTFIELD_RENAME_PLACEHOLDER
        )
    }
    
    func swipeBudgetCategoryCellLeftAndDeleteWithIndex(index: UInt) {
        self.swipeBudgetCategoryCellLeftAndTapButtonWithIndex(
            index,
            buttonNameKey: StringConstants.BUTTON_DELETE
        )
        self.deleteBudgetCategory()
    }
    
    func tapBudgetCategoryCellAndRenameWithIndex(index: UInt,newName: String) {
        self.tapBudgetCategoryCellAndTapButtonWithIndex(
            index,
            buttonNameKey: StringConstants.LABEL_RENAME
        )
        self.enterNewBudgetCategory(
            newName,
            alertTitleKey: StringConstants.LABEL_RENAME,
            textFieldPlaceholderKey: StringConstants.TEXTFIELD_RENAME_PLACEHOLDER
        )
    }
    
    func tapBudgetCategoryCellAndDeleteWithIndex(index: UInt) {
        self.tapBudgetCategoryCellAndTapButtonWithIndex(
            index,
            buttonNameKey: StringConstants.LABEL_DELETE_CATEGORY_TITLE
        )
        self.deleteBudgetCategory()
    }
    
    func assertBudgetCategoryCellEquality(match: String, index: UInt) {
        let translatedIndex = index + TestConstants.AddBudget.categoryIndexOffset
        self.getTableElementAtIndex(translatedIndex).staticTexts[match].exists
    }

}
