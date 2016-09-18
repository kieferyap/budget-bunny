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
        app.launchEnvironment = ["isTesting": "1", "needsDefaultAccount": "1"]
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
    
    // MARK: BUD-0001 -- Add Budget Test Cases
    
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
        addBudgetScreen.assertTextEqualityOfCategoryAtIndex(0, match:length25)
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
        
    }
    
    // Confirm that decimals are being added properly. (Users cannot key in "1..25")
    func testMultiDecimal() {
        self.proceedToAddBudgetScreen()
        
        let multiDecimal = "1..25"
        let singleDecimal = "1.25"
        
        // Assert that the 22-character limit is enforced in the Account Name
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.tapAmountTextField()
        addBudgetScreen.typeAmountTextField(multiDecimal)
        addBudgetScreen.assertAmountTextFieldEquality(singleDecimal)
    }
    
    // Test duplicate categories
    func testDuplicateCategories() {
        self.proceedToAddBudgetScreen()
        let testCategory = "Test Category"
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.typeCategoryTextField(testCategory)
        addBudgetScreen.typeCategoryTextField(testCategory)
        
        addBudgetScreen.tapErrorAlertOkButton()
    }
    
    // Test adding a blank category
    func testBlankCategories() {
        self.proceedToAddBudgetScreen()
        let testCategory = "      "
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.typeCategoryTextField(testCategory)
        addBudgetScreen.tapErrorAlertOkButton()
    }
    
    // Test missing fields: both and amount
    func testMissingAmount() {
        self.proceedToAddBudgetScreen()
        
        // Test 01: Both are empty
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.tapDoneButton()
        addBudgetScreen.tapErrorAlertOkButton()
        
        // Test 02: Name is empty
        addBudgetScreen.typeAmountTextField("123.45")
        addBudgetScreen.tapDoneButton()
        addBudgetScreen.tapErrorAlertOkButton()
        
    }
    
    // Test missing fields: name, and category
    func testMissingName() {
        self.proceedToAddBudgetScreen()
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.typeBudgetNameTextField("test")
        addBudgetScreen.tapDoneButton()
        addBudgetScreen.tapErrorAlertOkButton()
    }
    
    // TO-DO: Confirm that we can add budgets without categories
    func testNoCategories() {
        self.proceedToAddBudgetScreen()
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.tapBudgetNameTextField()
        addBudgetScreen.typeBudgetNameTextField("Transportation")
        addBudgetScreen.tapAmountTextField()
        addBudgetScreen.typeAmountTextField("1024")
        addBudgetScreen.tapDoneButton()
    }
    
    // Test maximum categories
    func testMaximumCategories() {
        self.proceedToAddBudgetScreen()
        
        let maxCount = 5
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        for i in 0 ..< maxCount {
            addBudgetScreen.typeCategoryTextField(String(i))
        }
        addBudgetScreen.tapDoneButton()
        addBudgetScreen.tapErrorAlertOkButton()
    }
    
    // Test the monthly/weekly/daily selection tabs, and confirm that the amount screen is correct
    func testTabSelection() {
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        
        budgetScreen.tapSegmentedControlMonthly()
        budgetScreen.tapAddBudgetButton()
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.assertAmountStaticTextEquality(
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_MONTHLY_BUDGET)
        )
        addBudgetScreen.tapBackButton()
        
        budgetScreen.tapSegmentedControlWeekly()
        budgetScreen.tapAddBudgetButton()
        addBudgetScreen.assertAmountStaticTextEquality(
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_WEEKLY_BUDGET)
        )
        addBudgetScreen.tapBackButton()
        
        budgetScreen.tapSegmentedControlDaily()
        budgetScreen.tapAddBudgetButton()
        addBudgetScreen.assertAmountStaticTextEquality(
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_DAILY_BUDGET)
        )
        addBudgetScreen.tapBackButton()
    }
    
    // Confirm that the currency displayed is that of the default account
    func testDisplayedCurrency() {
        let accountScreenUITests = AccountScreenUITests()
        accountScreenUITests.addAccountSuccess(
            "test1",
            amount: "100",
            currencyName: "Japan",
            isDefault: true
        )
        accountScreenUITests.addAccountSuccess(
            "test2",
            amount: "100",
            currencyName: "United Kingdom",
            isDefault: false
        )
        self.proceedToBudgetTab()
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapAddBudgetButton()
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.assertAmountStaticTextEquality(
            BunnyUIUtils.uncommentedLocalizedString("¥")
        )
    }
    
    // Confirm that we cannot add two budgets of the same name.
    
    // Confirm that we cannot add more than 5 budgets
    
    // Confirm that we cannot add a new budget if there are no default accounts -- I might need to move this in another class, since this class adds a default account by default to save time.
    
    // MARK: BUD-0002 -- Budget Screen Test Cases
    
    // Confirm that we cannot add two categories of the same name
    
    // Confirm that text field limits are enforced
    
    // Confirm that we cannot add more than 5 categories
    
    // Confirm that we cannot add blank categories
    
    // Confirm that we can add an income category
    
    // For the next two tests, we need to add two categories beforehand: one for swipe-to-x, and the other for tap-to-x
    // Confirm that, when an income category is tapped or swiped left, we can successfully rename.
    
    // Confirm that, when an income category is tapped or swiped left, we can successfully delete.
    
    // Confirm that we cannot rename an income category to a blank string
    
    // Confirm that we cannot rename an income category to an existing income category name
    
    // Confirm that swiping a budget left allows as to successfully delete it.
    
    // Confirm that tapping a budget allows us to edit it: the edit screen should have been prefilled with the budget's information
    
    // MARK: BUD-0003 -- Budget Editing
    
    // Confirm that we can successfully change a budget's name and amount
    
    // Confirm that we cannot change a budget's name to an existing budget's name
    
    // Confirm that we can add new categories (and they will be reflected once we save)
    
    // Confirm that we can successfully delete a budget in the budget editing screen
    
    // MARK: BUD-0005 -- Budget Category Editing
    
    // For the next two tests, we need to add two categories beforehand: one for swipe-to-x, and the other for tap-to-x
    // Confirm that, when a budget category is tapped or swiped left, we can successfully rename.
    
    // Confirm that, when a budget category is tapped or swiped left, we can successfully delete.
    
    // Confirm that we cannot rename a budget category to a blank string
    
    // Confirm that we cannot rename a budget category to an existing budget category name
    
    // The final battle for this set of screens: Add a budget with two categories. Enter said budget and add two more categories. Delete one pre-added category, and delete one newly-added category. Change the name and the amount. Save and check the budget. Everything should be at its place.
    
    // The runthrough for GitHub:
    // - Add two monthly budgets: one with no categories, and the other with three
    // - Monthly/Weekly/Daily
    // - Swipe a budget to delete
    // - Add three categories
    // - Swipe one category to rename
    // - Tap one category to delete
    // - Edit a budget: change its name and amount, swipe a category to rename, tap a category to delete
    
}
