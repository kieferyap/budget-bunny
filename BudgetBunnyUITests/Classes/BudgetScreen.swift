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
        ].buttons["Add"].tap()
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
    
    private func enterNewIncomeCategory(
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
    
    func typeNewIncomeCategory(input: String) {
        let addIncomeCategory = BunnyUIUtils.uncommentedLocalizedString(StringConstants.TEXTFIELD_NEW_INCOME)
        self.app.tables.buttons[addIncomeCategory].tap()
        self.enterNewIncomeCategory(
            input,
            alertTitleKey: StringConstants.LABEL_ADD_NEW_INCOME_CATEGORY,
            textFieldPlaceholderKey: StringConstants.TEXTFIELD_ADD_NEW_INCOME_CATEGORY_PLACEHOLDER
        )
    }
    
    func tapNewIncomeCategoryButton() {
        let addIncomeCategory = BunnyUIUtils.uncommentedLocalizedString(StringConstants.TEXTFIELD_NEW_INCOME)
        self.app.tables.buttons[addIncomeCategory].tap()
    }
    
    func assertIncomeCategoryCellEquality(match: String, index: UInt, numberOfBudgetCells: UInt) {
        // "No budgets found" counts as one cell.
        let translatedBudgetCellCount = numberOfBudgetCells == 0 ? 1 : numberOfBudgetCells
        let translatedIndex = index + translatedBudgetCellCount
        self.getTableElementAtIndex(translatedIndex).staticTexts[match].exists
    }
    
    private func swipeIncomeCellLeftAndTapButtonWithIndex(
        index: UInt,
        numberOfBudgetCells: UInt,
        buttonNameKey: String
    ) {
        let translatedBudgetCellCount = numberOfBudgetCells == 0 ? 1 : numberOfBudgetCells
        let translatedIndex = index + translatedBudgetCellCount
        let buttonName = BunnyUIUtils.uncommentedLocalizedString(buttonNameKey)
        self.getTableElementAtIndex(translatedIndex).swipeLeft()
        self.app.tables.buttons[buttonName].tap()
    }
    
    private func tapIncomeCellAndTapButtonWithIndex(
        index: UInt,
        numberOfBudgetCells: UInt,
        buttonNameKey: String
    ) {
        let translatedBudgetCellCount = numberOfBudgetCells == 0 ? 1 : numberOfBudgetCells
        let translatedIndex = index + translatedBudgetCellCount
        let buttonName = BunnyUIUtils.uncommentedLocalizedString(buttonNameKey)
        self.getTableElementAtIndex(translatedIndex).tap()
        
        let alertTitle = BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_INCOME_ACTIONS)
        self.app.sheets[alertTitle].collectionViews.buttons[buttonName].tap()
    }
    
    private func deleteIncomeCategory() {
        let deleteCategory = BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_DELETE_CATEGORY_TITLE)
        let deleteIncomeCategory = BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_DELETE_INCOME_CATEGORY_BUTTON)
        self.app.sheets[deleteCategory].collectionViews.buttons[deleteIncomeCategory].tap()
    }
    
    func swipeIncomeCellLeftAndRenameWithIndex(
        index: UInt,
        numberOfBudgetCells: UInt,
        newName: String
    ) {
        self.swipeIncomeCellLeftAndTapButtonWithIndex(
            index,
            numberOfBudgetCells: numberOfBudgetCells,
            buttonNameKey: StringConstants.LABEL_RENAME
        )
        self.enterNewIncomeCategory(
            newName,
            alertTitleKey: StringConstants.LABEL_RENAME,
            textFieldPlaceholderKey: StringConstants.TEXTFIELD_RENAME_PLACEHOLDER
        )
    }
    
    func swipeIncomeCellLeftAndDeleteWithIndex(index: UInt, numberOfBudgetCells: UInt) {
        self.swipeIncomeCellLeftAndTapButtonWithIndex(
            index,
            numberOfBudgetCells: numberOfBudgetCells,
            buttonNameKey: StringConstants.BUTTON_DELETE
        )
        self.deleteIncomeCategory()
    }
    
    func tapIncomeCellAndRenameWithIndex(
        index: UInt,
        numberOfBudgetCells: UInt,
        newName: String
    ) {
        self.tapIncomeCellAndTapButtonWithIndex(
            index,
            numberOfBudgetCells: numberOfBudgetCells,
            buttonNameKey: StringConstants.LABEL_RENAME
        )
        self.enterNewIncomeCategory(
            newName,
            alertTitleKey: StringConstants.LABEL_RENAME,
            textFieldPlaceholderKey: StringConstants.TEXTFIELD_RENAME_PLACEHOLDER
        )
    }
    
    func tapIncomeCellAndDeleteWithIndex(index: UInt, numberOfBudgetCells: UInt) {
        self.tapIncomeCellAndTapButtonWithIndex(
            index,
            numberOfBudgetCells: numberOfBudgetCells,
            buttonNameKey: StringConstants.LABEL_DELETE_CATEGORY_TITLE
        )
        self.deleteIncomeCategory()
    }
    
    func swipeBudgetCellLeftAndDeleteWithIndex(index: UInt) {
        let buttonName = BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE)
        self.getTableElementAtIndex(index).swipeLeft()
        self.app.tables.buttons[buttonName].tap()
    }
    
    func assertIncomeCellCount(count: UInt, numberOfBudgetCells: UInt) {
        let translatedBudgetCellCount = numberOfBudgetCells == 0 ? 1 : numberOfBudgetCells
        self.assertCellCount(count + translatedBudgetCellCount + 1) // +1: The "Add Income Category" cell
    }
    
    func tapBudgetCellAtIndex(index: UInt) {
        self.getTableElementAtIndex(index).tap()
    }
    
    func assertBudgetExistenceAtIndex(index: UInt, name: String, remainingAmount: String, amount: String) {
        XCTAssertTrue(self.getTableElementAtIndex(index).staticTexts[name].exists)
        XCTAssertTrue(self.getTableElementAtIndex(index).staticTexts[remainingAmount].exists)
        XCTAssertTrue(self.getTableElementAtIndex(index).staticTexts[amount].exists)
    }
}
