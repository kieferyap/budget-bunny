//
//  AddAccountUITests.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/7/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest
import CoreData

@available(iOS 9.0, *)
class AddAccountUITests: XCTestCase {
    
    /*
      *  Important note! Hardware > Keyboard > Connect Hardware Keyboard must be unchecked.
      *  Make sure that Auto Correction is turned off
    */
    
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
    
    func proceedToAddAccountScreen() {
        self.proceedToAccountTab()
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapAddAccountButton()
    }
    
    func proceedToAccountTab() {
        // Delete accounts core data
        ScreenManager.tapAccountsTab(self.app)
    }
    
    // Successfully adds an account given the parameters
    func addAccountSuccess(name: String, amount: String, currencyName: String, isDefault: Bool) {
        self.proceedToAddAccountScreen()
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.typeAccountNameTextField(name)
        
        addAccountScreen.tapOutside()
        addAccountScreen.tapAmountTextFieldAdding()
        addAccountScreen.typeAmountTextField(amount)
        
        addAccountScreen.tapCurrencyCell()
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapElementWithCountryName(currencyName)
        currencyPickerScreen.tapBackButton()
        
        if isDefault {
            addAccountScreen.tapIsDefaultSwitch()
        }
        addAccountScreen.tapDoneButton()

    }
    
    // MARK: ACC-0001 Test Cases
    
    // Tap each cell to execute its functions.
    func testCellExistence() {
        self.proceedToAddAccountScreen()
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.tapAmountTextFieldAdding()
        addAccountScreen.tapCurrencyCell()
        
        // TO-DO: Tap the cell, instead of the textfields
    }
    
    // Type anything on both the Account Name, and Initial Amount Textfields. 
    // Then, tap outside. Both textfields must contain the whatever has been typed.
    func testAddAccountTextFields() {
        self.proceedToAddAccountScreen()
        
        let accountName: String = "My bank account"
        let initialAmount: String = "450"
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.typeAccountNameTextField(accountName)
        addAccountScreen.assertTextFieldEquality(accountName)
        
        addAccountScreen.tapOutside()
        addAccountScreen.tapAmountTextFieldAdding()
        addAccountScreen.typeAmountTextField(initialAmount)
        addAccountScreen.assertTextFieldEquality(initialAmount)
    
    }
    
    // Confirm that the Account Name textfield has a 25 character limit
    func testAddAccountTextFieldLength() {
        self.proceedToAddAccountScreen()
        
        let length30 = "123456789012345678901234567890"
        let length25 = "1234567890123456789012345"
        
        // Assert that the 25-character limit is enforced in the Account Name
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.typeAccountNameTextField(length30)
        addAccountScreen.assertTextFieldEquality(length25)
    }
    
    // Confirm that the Initial Amount textfield has a 22 character limit.
    func testAmountTextFieldLength() {
        self.proceedToAddAccountScreen()
        
        let length30 = "123456789012345678901234567890"
        let length15 = "123456789012345"
        
        // Assert that the 22-character limit is enforced in the Account Name
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAmountTextFieldAdding()
        addAccountScreen.typeAmountTextField(length30)
        addAccountScreen.assertTextFieldEquality(length15)
    }
    
    // Confirm that users cannot add two decimal points in the Amount field 
    func testMultiDecimal() {
        self.proceedToAddAccountScreen()
        
        let multiDecimal = "1..25"
        let singleDecimal = "1.25"
        
        // Assert that the 22-character limit is enforced in the Account Name
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAmountTextFieldAdding()
        addAccountScreen.typeAmountTextField(multiDecimal)
        addAccountScreen.assertTextFieldEquality(singleDecimal)
    }
    
    // Confirm that a 0 is automatically added in the front.
    func testDecimalFormatting() {
        self.proceedToAddAccountScreen()

        let decimalOnly = ".25"
        let formattedDecimal = "$ 0.25"
        let accountName = "test"
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAmountTextFieldAdding()
        addAccountScreen.typeAmountTextField(decimalOnly)
        
        addAccountScreen.tapOutside()
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.typeAccountNameTextField(accountName)
        addAccountScreen.tapDoneButton()
        
        // Assert that the decimal is saved properly
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.assertCellTextWithIndex(0, textToFind: formattedDecimal)
    }
    
    
    // From the Add Account Screen, tap the Currency Cell, and return. The currency cell must still contain the default currency.
    // From the Add Account Screen, tap the Currency Cell, and search for USD. Tap it and return. The currency cell must contain the currency in USD
    func testCurrencyCell() {
        self.proceedToAddAccountScreen()
        
        let usdCurrency = "United States: USD ($)"
        let japanCurrency = "Japan: JPY (¥)"
        let japanSearchKey = "Japan"
        
        // Test 01: Tapping the currency cell and returning should not change the current cell
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.assertStaticTextEquality(usdCurrency)
        addAccountScreen.tapCurrencyCell()
    
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapBackButton()
        addAccountScreen.assertStaticTextEquality(usdCurrency)
        
        // Test 02: Tapping the currency cell and changing the currency should change the cell
        addAccountScreen.tapCurrencyCell()
        currencyPickerScreen.tapElementWithCountryName(japanSearchKey)
        currencyPickerScreen.tapBackButton()
        addAccountScreen.assertStaticTextEquality(japanCurrency)
        
        // TO-DO: I can't get the type-search-bar-tap-first-element to work because it apparently couldn't find the element after searching. I'll look into this in depth next time.
    }
    
    // For the next two tests: 
    // An error should appear when the Account Name or the Initial Amount is empty, and the Done button was pressed.
    func testErrorScenario01() {
        self.proceedToAddAccountScreen()
        
        // Test 01: Both are empty
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapDoneButton()
        addAccountScreen.tapErrorAlertOkButton()
        
        // Test 02: Currency is empty
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.typeAccountNameTextField("test")
        addAccountScreen.tapDoneButton()
        addAccountScreen.tapErrorAlertOkButton()
    }
    
    func testErrorScenario02() {
        self.proceedToAddAccountScreen()
        
        // Test 01: Account name is empty
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAmountTextFieldAdding()
        addAccountScreen.typeAmountTextField("120")
        addAccountScreen.tapDoneButton()
        addAccountScreen.tapErrorAlertOkButton()
    }
    
    // Confirm that we are able to successfully add a new account
    func testSuccess() {
        // Successfully add a non-default account
        self.addAccountSuccess("test", amount: "120", currencyName: "Japan", isDefault: false)
        self.addAccountSuccess("test2", amount: "65536", currencyName: "United States", isDefault: true)
        
        // Assert, in the Account List screen, that test2 is marked as default, while test is not
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.assertCellIsNotDefaultAccount(0)
        accountScreen.assertCellIsDefaultAccount(1)
    }
    
    // Confirm that an error occurs if we add two accounts of the same name
    func testExistingAccountError() {
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        self.addAccountSuccess("test", amount: "123456789012.34", currencyName: "Japan", isDefault: false)
        self.addAccountSuccess("test", amount: "32768", currencyName: "Philippines", isDefault: false)
        addAccountScreen.tapErrorAlertOkButton()
    }
    
    // Add a default account. Add another default account.
    // Confirm that the only default account is the LATEST ACCOUNT that the user specifies as default.
    func testDoubleDefaultAccount() {
        self.addAccountSuccess("test1", amount: "1024", currencyName: "Japan", isDefault: true)
        self.addAccountSuccess("test2", amount: "2048", currencyName: "United Kingdom", isDefault: true)
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.assertCellIsNotDefaultAccount(0)
        accountScreen.assertCellIsDefaultAccount(1)
    }
    
    // Confirm that the currency search bar works
    func testSearchBar() {
        self.proceedToAddAccountScreen()
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapCurrencyCell()
        
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapElementWithCountryName("Japan")
        currencyPickerScreen.tapSearchBar()
        currencyPickerScreen.typeSearchBar("Test")
        currencyPickerScreen.tapSearchBarClearText()
        currencyPickerScreen.tapSearchBar()
        currencyPickerScreen.tapSearchBarCancel()
        currencyPickerScreen.tapBackButton()
    }

    // MARK: ACC-0002 Test Cases
    
    // Confirm that all the swipe features in the Add Account Screen works
    func testAllAddAccountFeatures() {
        self.addAccountSuccess("test1", amount: "256", currencyName: "Japan", isDefault: false)
        self.addAccountSuccess("test2", amount: "512", currencyName: "United Kingdom", isDefault: false)
        self.addAccountSuccess("test3", amount: "1024", currencyName: "United States", isDefault: false)
        self.addAccountSuccess("test4", amount: "2048", currencyName: "France", isDefault: true)
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.swipeCellLeftAndSetAsDefaultWithIndex(1)
        accountScreen.swipeCellLeftAndDeleteWithIndex(3)
        accountScreen.swipeCellLeftAndViewWithIndex(1)
    }
    
    // Confirm that tapping an account is possible.
    func testTapAccount() {
        self.addAccountSuccess("test1", amount: "128", currencyName: "Japan", isDefault: false)
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(0)
    }
    
    // MARK: ACC-0003 Test Cases
    
    // Test that editing is possible, and that the button functionality is correct.
    func testEditScreenCorrectFields() {
        let account1 = ["test1", "1050", "Japan", "Japan: JPY (¥)"]
        let account2 = ["test2", "10.50", "United States", "United States: USD ($)"]
        let account2New = ["test3", "2010", "United Kingdom"]
        let name = 0, amount = 1, country = 2, currencyText = 3
        let idxDefault: UInt = 0, idxNormal: UInt = 1
        
        self.addAccountSuccess(
            account1[name] ,
            amount: account1[amount] ,
            currencyName: account1[country] ,
            isDefault: true
        )
        self.addAccountSuccess(
            account2[name],
            amount: account2[amount],
            currencyName: account2[country],
            isDefault: false
        )
        
        // When tapping an account, we proceed to the edit screen.
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(idxDefault)

        // Assert that the currency, account name, and amount of the default account are correct
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.assertTextFieldEquality(account1[name])
        addAccountScreen.assertTextFieldEquality(account1[amount])
        addAccountScreen.assertStaticTextEquality(account1[currencyText])

        // Assert that a default account must have two disabled buttons
        addAccountScreen.assertButtonEnabled("This is the default account.", isEnabled: false)
        addAccountScreen.assertButtonEnabled("Default accounts cannot be deleted.", isEnabled: false)
        addAccountScreen.returnToAccountScreen()
        
        // Assert that the currency, account name, and amount of the normal account are correct
        accountScreen.tapCellWithIndex(idxNormal)
        addAccountScreen.assertTextFieldEquality(account2[name])
        addAccountScreen.assertTextFieldEquality(account2[amount])
        addAccountScreen.assertStaticTextEquality(account2[currencyText])
        
        // ...while a non-default account must have two tappable icons.
        addAccountScreen.assertButtonEnabled("Set as Default", isEnabled: true)
        addAccountScreen.assertButtonEnabled("Delete account", isEnabled: true)
        
        // Proceed to the Edit Account Screen and update the account name and initial amount.
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.clearAndEnterText(account2[name], newText: account2New[name])
        addAccountScreen.tapAmountTextFieldEditing()
        addAccountScreen.clearAndEnterText(account2[amount], newText: account2New[amount])
        addAccountScreen.tapCurrencyCell()
        
        // Tap the currency and head back. Assert that the values displayed are correct.
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapElementWithCountryName(account2New[country])
        currencyPickerScreen.tapBackButton()
        addAccountScreen.assertStaticTextEquality(account2New[name])
        addAccountScreen.assertStaticTextEquality(account2New[amount])
        
        // Tap the delete button.
        addAccountScreen.tapDeleteButton()
        accountScreen.assertCellCount(1)        
    }
    
    // Proceed to the Edit Account Screen with a non-default account. Tap the Set as Default button.
    // Assert that both buttons have their text changed and are now set as disabled.
    // Return to the accounts screen and assert that the default account icon has changed.
    
    // Change the account and hit Save. Assert that the relevant data has been changed.
}
