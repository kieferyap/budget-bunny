//
//  BudgetScreenUITests.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/29/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest
import CoreData

@available(iOS 9.0, *)
class BudgetScreenUITests: XCTestCase {
    
    var app = XCUIApplication();
    
    override func setUp() {
        super.setUp()
        app.launchEnvironment = ["isTesting": "1"]
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: Test functions 
    func proceedToBudgetTab() {
        // Delete accounts core data
        ScreenManager.tapBudgetsTab(self.app)
    }
    
    func proceedToAddBudgetScreen() {
        self.proceedToBudgetTab()
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapAddBudgetButton()
    }
    
    // MARK: BUD-0001 Test Cases
    
    // Test element existence
    func testExistence() {
        self.proceedToAddBudgetScreen()
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.tapBudgetNameTextField()
        addBudgetScreen.typeBudgetNameTextField("Transportation")
        addBudgetScreen.tapAmountTextField()
        addBudgetScreen.typeAmountTextField("1024")
        addBudgetScreen.tapAddCategoryTextField()
        addBudgetScreen.typeCategoryTextField("Trains")
    }
    
    // Confirm that text field length limits are enforced.
    func testTextFieldLengths() {
        self.proceedToAddBudgetScreen()
        
        let length30 = "123456789012345678901234567890"
        let length25 = "1234567890123456789012345"
        let length15 = "123456789012345"
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.tapBudgetNameTextField()
        addBudgetScreen.typeBudgetNameTextField(length30)
        addBudgetScreen.tapAmountTextField()
        addBudgetScreen.typeAmountTextField(length30)
        addBudgetScreen.tapAddCategoryTextField()
        addBudgetScreen.typeCategoryTextField(length30)
        
        addBudgetScreen.assertBudgetNameTextFieldEquality(length25)
        addBudgetScreen.assertAmountTextFieldEquality(length15)
        addBudgetScreen.assertCategoryTextFieldEquality(length25)
    }
    
    // Confirm that new categories are being added into the list.
    func testAddCategories() {
        self.proceedToAddBudgetScreen()
        
        let categoryA = "Breakfast"
        let categoryB = "Lunch"
        let categoryC = "Dinner"
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.typeCategoryTextField(categoryA)
        addBudgetScreen.typeCategoryTextField(categoryB)
        addBudgetScreen.typeCategoryTextField(categoryC)
        
        addBudgetScreen.assertTextEqualityOfCategoryAtIndex(0, match: categoryA)
        addBudgetScreen.assertTextEqualityOfCategoryAtIndex(1, match: categoryB)
        addBudgetScreen.assertTextEqualityOfCategoryAtIndex(2, match: categoryC)
        
        
//        let app = XCUIApplication()
//        app.tabBars.buttons["Budgets"].tap()
//        app.navigationBars["Budgets"].buttons["+"].tap()
//        
//        let tablesQuery = app.tables
//        let addNewCategoryTextField = tablesQuery.cells.textFields["Add New Category"]
//        addNewCategoryTextField.tap()
//        addNewCategoryTextField.tap()
//        tablesQuery.childrenMatchingType(.Cell).elementBoundByIndex(2).childrenMatchingType(.TextField).element
//        app.typeText("\r")
//        addNewCategoryTextField.tap()
//        addNewCategoryTextField.tap()
//        self.app.tables.childrenMatchingType(.Cell).elementBoundByIndex(3).childrenMatchingType(.TextField).element
//        app.typeText("\r")
        
    }
    
    // Confirm that decimals are being added properly. (Users cannot key in "1..25")
    
    // Confirm that the five error scenarios are working. (Missing name, missing amount, maximum categories, duplicate categories, CATEGORIES WITH NOTHING IN IT)
    
}
