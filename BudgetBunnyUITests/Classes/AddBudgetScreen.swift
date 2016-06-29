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
        self.tapTextFieldAtElement(0)
    }
    
    func tapAmountTextField() {
        self.tapTextFieldAtElement(1)
    }
    
    func tapAddCategoryTextField() {
        self.tapTextFieldAtElement(2)
    }
    
    func typeBudgetNameTextField(input: String) {
        self.tapBudgetNameTextField()
        self.typeTextFieldAtElement(0, input: input)
    }
    
    func typeAmountTextField(input: String) {
        self.tapAmountTextField()
        self.typeTextFieldAtElement(1, input: input)
    }
    
    func typeCategoryTextField(input: String) {
        self.tapAddCategoryTextField()
        self.typeTextFieldAtElement(2, input: input)
    }
    
    func assertBudgetNameTextFieldEquality(desiredValue: String) {
        self.assertTextFieldEquality(0, desiredValue: desiredValue)
    }
    
    func assertAmountTextFieldEquality(desiredValue: String) {
        self.assertTextFieldEquality(1, desiredValue: desiredValue)
    }
    
    func assertCategoryTextFieldEquality(desiredValue: String) {
        self.assertTextFieldEquality(2, desiredValue: desiredValue)
    }
    
    private func assertTextFieldEquality(index: Int, desiredValue: String) {
        let textFieldValue = self.app.tables.textFields.elementAtIndex(0).value as! String
        XCTAssertEqual(textFieldValue, desiredValue)
    }
    
    private func tapTextFieldAtElement(index: UInt) {
        self.app.tables.textFields.elementAtIndex(index).tap()
    }
    
    private func typeTextFieldAtElement(index: UInt, input: String) {
        self.app.tables.textFields.elementAtIndex(index).typeText(input)
    }
}
