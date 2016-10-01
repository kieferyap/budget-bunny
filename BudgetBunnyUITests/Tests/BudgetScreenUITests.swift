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
    func addNewBudget(
        name: String,
        amount: Double,
        categoryNames: [String]
    ) {
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapAddBudgetButton()
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.typeBudgetNameTextField(name)
        
        let floatFormat: String = rint(amount) == amount ? "%.0f" : "%.2f"
        addBudgetScreen.typeAmountTextField(String(format: floatFormat, amount))
        
        for name in categoryNames {
            addBudgetScreen.typeCategoryTextField(name)
        }
        
        addBudgetScreen.tapDoneButton()
    }
    
    func proceedToBudgetTab() {
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
    
    // Confirm that we can add budgets without categories
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
    
    // Confirm that we cannot add two budgets with the same name.
    func testSimilarlyNamedBudgets() {
        self.proceedToBudgetTab()
        self.addNewBudget("test", amount: 100.0, categoryNames: [])
        self.addNewBudget("test", amount: 150.25, categoryNames: [])
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that we cannot add more than 5 budgets
    func testMaxBudgetCount() {
        self.proceedToBudgetTab()
        
        let maxAmount = 5
        for i in 0 ..< maxAmount {
            self.addNewBudget(String(i), amount: 100, categoryNames: [])
        }
        
        // Tapping the + button must result in an error
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapAddBudgetButton()
        budgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that we cannot add a budget with amount = 0, or negative numbers.
    func testPositiveAmount() {
        self.proceedToAddBudgetScreen()
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.typeBudgetNameTextField("Transportation")
        
        addBudgetScreen.typeAmountTextField("0")
        addBudgetScreen.tapDoneButton()
        addBudgetScreen.tapErrorAlertOkButton()
        
        addBudgetScreen.typeAmountTextField("-10")
        addBudgetScreen.tapDoneButton()
        addBudgetScreen.tapErrorAlertOkButton()
    }
    
    // MARK: BUD-0002 -- Budget Screen Test Cases
    
    // Confirm that we cannot add two categories of the same name
    func testSimilarlyNamedIncomeCategories() {
        self.proceedToBudgetTab()
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.typeNewIncomeCategory("test")
        budgetScreen.typeNewIncomeCategory("test")
        budgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that text field limits are enforced
    func testIncomeFieldLength() {
        self.proceedToBudgetTab()
        let length30 = "123456789012345678901234567890"
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.typeNewIncomeCategory(length30)
        budgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that we cannot add more than 5 categories
    func testMaxIncomeCategoryCount() {
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        
        let maxAmount = 6
        for i in 0 ..< maxAmount {
            budgetScreen.typeNewIncomeCategory(String(i))
        }

        budgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that we cannot add blank categories
    func testBlankIncomeCategory() {
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.typeNewIncomeCategory("      ")
        budgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that we can add an income category (and that it's properly trimmed)
    func testAddIncomeCategory() {
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.typeNewIncomeCategory("   Salary   ")
        budgetScreen.assertIncomeCategoryCellEquality("Salary", index: 0, numberOfBudgetCells: 0)
    }
    
    // For the next two tests, we need to add two categories beforehand: one for swipe-to-x, and the other for tap-to-x
    // Confirm that, when an income category is tapped or swiped left, we can successfully rename.
    func testRenameIncomeCategory() {
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.typeNewIncomeCategory("Stipend")
        
        let newName1 = "Allowance"
        let newName2 = "Salary"
        
        budgetScreen.swipeIncomeCellLeftAndRenameWithIndex(0, numberOfBudgetCells: 0, newName: newName1)
        budgetScreen.assertIncomeCategoryCellEquality(newName1, index: 0, numberOfBudgetCells: 0)
        
        budgetScreen.tapIncomeCellAndRenameWithIndex(0, numberOfBudgetCells: 0, newName: newName2)
        budgetScreen.assertIncomeCategoryCellEquality(newName2, index: 0, numberOfBudgetCells: 0)
    }
    
    // Confirm that, when an income category is tapped or swiped left, we can successfully delete.
    func testDeleteIncomeCategory() {
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        
        budgetScreen.typeNewIncomeCategory("Stipend")
        budgetScreen.typeNewIncomeCategory("Allowance")
        budgetScreen.assertIncomeCellCount(2, numberOfBudgetCells: 0)
        
        budgetScreen.swipeIncomeCellLeftAndDeleteWithIndex(0, numberOfBudgetCells: 0)
        budgetScreen.assertIncomeCellCount(1, numberOfBudgetCells: 0)
        
        budgetScreen.tapIncomeCellAndDeleteWithIndex(0, numberOfBudgetCells: 0)
        budgetScreen.assertIncomeCellCount(0, numberOfBudgetCells: 0)
    }
    
    // Confirm that we cannot rename an income category to a blank string
    func testRenameIncomeCategoryBlank() {
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        
        budgetScreen.typeNewIncomeCategory("Salary")
        budgetScreen.tapIncomeCellAndRenameWithIndex(0, numberOfBudgetCells: 0, newName: "")
        budgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that we cannot rename an income category to an existing income category name
    func testRenameIncomeCategorySameName() {
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        
        budgetScreen.typeNewIncomeCategory("Stipend")
        budgetScreen.typeNewIncomeCategory("Allowance")
        budgetScreen.swipeIncomeCellLeftAndRenameWithIndex(0, numberOfBudgetCells: 0, newName: "Allowance")
        budgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that text field limits still hold up when renaming
    func testRenameIncomeCategoryFieldLength() {
        self.proceedToBudgetTab()
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        let length30 = "123456789012345678901234567890"
        
        budgetScreen.typeNewIncomeCategory("Stipend")
        budgetScreen.swipeIncomeCellLeftAndRenameWithIndex(0, numberOfBudgetCells: 0, newName: length30)
        budgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that tapping a budget allows us to edit it: the edit screen should have been prefilled with the budget's information
    func tapBudgetCell() {
        let budgetName = "Food and Drinks"
        let amount = 800.0
        
        self.proceedToBudgetTab()
        self.addNewBudget(budgetName, amount: amount, categoryNames: [])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.assertBudgetNameTextFieldEquality(budgetName)
        editBudgetScreen.assertAmountTextFieldEquality(String(format: "%.2f", amount))
    }
    
    // MARK: BUD-0003 -- Budget Editing
    
    // Confirm that we can successfully change a budget's name and amount
    func testChangeBudgetNameAmount() {
        let budgetName = "Food and Drinks"
        let newBudgetName = "Groceries"
        let amount = 800.0
        let newAmount = 650.0
        
        self.proceedToBudgetTab()
        self.addNewBudget(budgetName, amount: amount, categoryNames: [])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.deleteAndEnterBudgetNameText(newBudgetName, deleteDuration: 2.0)
        editBudgetScreen.deleteAndEnterBudgetAmountText(String(format: "%.2f", newAmount), deleteDuration: 2.0)
        editBudgetScreen.tapSaveButton()
        
        budgetScreen.assertBudgetExistenceAtIndex(
            0,
            name: newBudgetName,
            remainingAmount: "$ 650.00",
            amount: "$ 650.00"
        )
    }
    
    // Confirm that we cannot change a budget's name to an existing budget's name
    func testChangeBudgetExistingBudget() {
        let budgetNames = ["Budget1", "Budget2"]
        let amounts = [400.0, 100.0]
        
        self.proceedToBudgetTab()
        self.addNewBudget(budgetNames[0], amount: amounts[0], categoryNames: [])
        self.addNewBudget(budgetNames[1], amount: amounts[1], categoryNames: [])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.deleteAndEnterBudgetNameText("Budget2", deleteDuration: 2.0)
        editBudgetScreen.tapSaveButton()
        editBudgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that we can add new categories (and they will be reflected once we save)
    func testAddNewCategories() {
        self.proceedToBudgetTab()
        self.addNewBudget("Budget1", amount: 100.0, categoryNames: ["CategoryA", "CategoryB"])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.typeCategoryTextField("CategoryC")
        editBudgetScreen.typeCategoryTextField("CategoryD")
        editBudgetScreen.tapSaveButton()
        
        budgetScreen.tapBudgetCellAtIndex(0)
        editBudgetScreen.assertCellCount(8)
    }
    
    // Confirm that we can successfully delete a budget in the budget editing screen
    func testDeleteBudgetInEditScreen() {
        self.proceedToBudgetTab()
        self.addNewBudget("Budget1", amount: 100.0, categoryNames: [])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.tapDeleteBudgetButton()
        
        budgetScreen.assertCellCount(6)
    }
    
    // MARK: BUD-0005 -- Budget Category Editing
    
    // For the next two tests, we need to add two categories beforehand: one for swipe-to-x, and the other for tap-to-x
    
    // Confirm that, when a budget category is tapped or swiped left, we can successfully rename.
    func testRenameBudgetCategory() {
        self.proceedToBudgetTab()
        self.addNewBudget("Food", amount: 1.0, categoryNames: ["wwwwwwwwwwwwwwwwwwwwwwwww"])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.tapBudgetCategoryCellAndRenameWithIndex(0, newName: "C")
        editBudgetScreen.swipeBudgetCategoryCellLeftAndRenameWithIndex(0, newName: "D")
    }
    
    // Confirm that, when a budget category is tapped or swiped left, we can successfully delete.
    func testDeleteBudgetCategory() {
        self.proceedToBudgetTab()
        self.addNewBudget("Food", amount: 1.0, categoryNames: ["A", "B"])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.tapBudgetCategoryCellAndDeleteWithIndex(0)
        editBudgetScreen.swipeBudgetCategoryCellLeftAndDeleteWithIndex(0)
    }
    
    // Confirm that we cannot rename a budget category to a blank string
    func testRenameBudgetCategoryBlank() {
        self.proceedToBudgetTab()
        self.addNewBudget("Food", amount: 1.0, categoryNames: ["A", "B"])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.tapBudgetCategoryCellAndRenameWithIndex(0, newName: "     ")
        editBudgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that we cannot rename a budget category to an existing budget category name
    func testRenameBudgetCategorySameName() {
        self.proceedToBudgetTab()
        self.addNewBudget("Food", amount: 1.0, categoryNames: ["A", "B"])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.swipeBudgetCategoryCellLeftAndRenameWithIndex(0, newName: "B")
        editBudgetScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that text field limits still hold up when renaming
    func testRenameBudgetCategoryFieldLength() {
        self.proceedToBudgetTab()
        self.addNewBudget("Food", amount: 1.0, categoryNames: ["A", "B"])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        let length30 = "123456789012345678901234567890"
        
        editBudgetScreen.swipeBudgetCategoryCellLeftAndRenameWithIndex(0, newName: length30)
        editBudgetScreen.tapErrorAlertOkButton()
    }
    
    // The final battle for this set of screens: Add a budget with two categories. Enter said budget and add two more categories. Delete one pre-added category, and delete one newly-added category. Change the name and the amount. Save and check the budget. Everything should be at its place.
    func testFinalBattleBudget() {
        self.proceedToBudgetTab()
        self.addNewBudget("Food", amount: 1.0, categoryNames: ["A", "B"])
        
        let budgetScreen: BudgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.typeCategoryTextField("C")
        editBudgetScreen.typeCategoryTextField("D")
        
        editBudgetScreen.tapBudgetCategoryCellAndDeleteWithIndex(0)
        editBudgetScreen.swipeBudgetCategoryCellLeftAndDeleteWithIndex(2)
        
        let newName = "Groceries"
        let newAmount = "2.0"
        
        editBudgetScreen.deleteAndEnterBudgetNameText(newName, deleteDuration: 3.0)
        editBudgetScreen.deleteAndEnterBudgetAmountText(newAmount, deleteDuration: 3.0)
        editBudgetScreen.tapSaveButton()
        
        budgetScreen.tapBudgetCellAtIndex(0)
        
        editBudgetScreen.assertBudgetNameTextFieldEquality(newName)
        editBudgetScreen.assertAmountTextFieldEquality("2")
        editBudgetScreen.assertBudgetCategoryCellEquality("B", index: 0)
        editBudgetScreen.assertBudgetCategoryCellEquality("C", index: 1)
    }
    
    // The runthrough for GitHub:
    // - Add two monthly budgets: one with no categories, and the other with three
    // - Monthly/Weekly/Daily
    // - Swipe a budget to delete
    // - Add three categories
    // - Swipe one category to rename
    // - Tap one category to delete
    // - Edit a budget: change its name and amount, swipe a category to rename, tap a category to delete
    // - Add two income categories: "Allowance" and "Stocks"
    // - Swipe "Allowance" to left and rename it as "Salary"
    func testRunThrough() {
        self.proceedToBudgetTab()
        self.addNewBudget("Food and Groceries", amount: 600, categoryNames: [])
        
        sleep(5)
        self.addNewBudget("Leisure", amount: 550, categoryNames: ["Gadgets and Tech", "Movies"])
        
        let budgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapSegmentedControlWeekly()
        budgetScreen.tapSegmentedControlDaily()
        budgetScreen.tapSegmentedControlMonthly()
        budgetScreen.tapBudgetCellAtIndex(0)
        
        let editBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        editBudgetScreen.typeCategoryTextField("Video Games")
        editBudgetScreen.swipeBudgetCategoryCellLeftAndRenameWithIndex(1, newName: "DVDs")
        editBudgetScreen.tapBudgetCategoryCellAndDeleteWithIndex(0)
        editBudgetScreen.tapSaveButton()
        
        budgetScreen.typeNewIncomeCategory("Allowance")
        budgetScreen.typeNewIncomeCategory("Stocks")
        budgetScreen.swipeIncomeCellLeftAndRenameWithIndex(0, numberOfBudgetCells: 2, newName: "Salary")
        sleep(5)
    }
    
}
