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
class AccountScreenUITests: XCTestCase {
    
    /*
      *  Important note! Hardware > Keyboard > Connect Hardware Keyboard must be unchecked.
      *  Make sure that Auto Correction is turned off
      *  The device's language must be in English
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
        
        addAccountScreen.tapAmountTextField()
        addAccountScreen.typeAmountTextField(amount)
        
        addAccountScreen.tapCurrencyCell()
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapElementWithCountryName(currencyName)
        currencyPickerScreen.tapBackButtonToAdd()
        
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
        addAccountScreen.tapAmountTextField()
        addAccountScreen.tapCurrencyCell()
        
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapBackButtonToAdd()
        addAccountScreen.tapAllInfoCells()
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
        addAccountScreen.assertAccountNameTextFieldEquality(accountName)
        
        addAccountScreen.tapAmountTextField()
        addAccountScreen.typeAmountTextField(initialAmount)
        addAccountScreen.assertAmountTextFieldEquality(initialAmount)
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
        addAccountScreen.assertAccountNameTextFieldEquality(length25)
    }
    
    // Confirm that the Initial Amount textfield has a 15 character limit.
    func testAmountTextFieldLength() {
        self.proceedToAddAccountScreen()
        
        let length30 = "123456789012345678901234567890"
        let length15 = "123456789012345"
        
        // Assert that the 22-character limit is enforced in the Account Name
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAmountTextField()
        addAccountScreen.typeAmountTextField(length30)
        addAccountScreen.assertAmountTextFieldEquality(length15)
    }
    
    // Confirm that users cannot add two decimal points in the Amount field 
    func testMultiDecimal() {
        self.proceedToAddAccountScreen()
        
        let multiDecimal = "1..25"
        let singleDecimal = "1.25"
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAmountTextField()
        addAccountScreen.typeAmountTextField(multiDecimal)
        addAccountScreen.assertAmountTextFieldEquality(singleDecimal)
    }
    
    // Confirm that a 0 is automatically added in the front.
    func testDecimalFormatting() {
        self.proceedToAddAccountScreen()

        let decimalOnly = ".25"
        let formattedDecimal = "$ 0.25"
        let accountName = "test"
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAmountTextField()
        addAccountScreen.typeAmountTextField(decimalOnly)
        
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
        addAccountScreen.assertCurrencyLabelEquality(usdCurrency)
        addAccountScreen.tapCurrencyCell()
    
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapBackButtonToAdd()
        addAccountScreen.assertCurrencyLabelEquality(usdCurrency)
        
        // Test 02: Tapping the currency cell and changing the currency should change the cell
        addAccountScreen.tapCurrencyCell()
        currencyPickerScreen.tapElementWithCountryName(japanSearchKey)
        currencyPickerScreen.tapBackButtonToAdd()
        addAccountScreen.assertCurrencyLabelEquality(japanCurrency)
        
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
        addAccountScreen.tapAmountTextField()
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
        currencyPickerScreen.tapBackButtonToAdd()
    }
    
    // Confirm that the account name input field is trimmed.
    func testTrim() {
        self.addAccountSuccess("     test1     ", amount: "1024", currencyName: "Japan", isDefault: true)
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.assertCellTextWithIndex(0, textToFind: "test1.")
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
    
    // Confirm that the maximum cell amount check is working.
    func testAccountCount() {
        let maxAmount = 5
        for i in 0 ..< maxAmount {
            self.addAccountSuccess(
                String(i),
                amount: "128",
                currencyName: "Japan",
                isDefault: true
            )
        }
        
        // Tapping the + button must result in an error
        self.proceedToAccountTab()
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapAddAccountButton()
        accountScreen.tapErrorAlertOkButton()
    }
    
    // MARK: ACC-0003 Test Cases
    
    // Executed as a starting test case for all ACC-0003 test cases
    func addTestingAccounts() {
        self.proceedToAccountTab()
        
        self.addAccountSuccess(
            TestConstants.Accounts.account1[TestConstants.Accounts.name] ,
            amount: TestConstants.Accounts.account1[TestConstants.Accounts.amount] ,
            currencyName: TestConstants.Accounts.account1[TestConstants.Accounts.country] ,
            isDefault: true
        )
        self.addAccountSuccess(
            TestConstants.Accounts.account2[TestConstants.Accounts.name],
            amount: TestConstants.Accounts.account2[TestConstants.Accounts.amount],
            currencyName: TestConstants.Accounts.account2[TestConstants.Accounts.country],
            isDefault: false
        )
    }
    
    // Test that editing is possible: when tapping an account, we proceed to the edit screen.
    // Confirm that the currency, account name, and amount are correct (1050 vs 10.50)
    func testEditScreenCorrectFields() {
        self.addTestingAccounts()
        
        // When tapping an account, we proceed to the edit screen.
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxDefault)

        // Assert that the currency, account name, and amount of the default account are correct
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.assertAccountNameTextFieldEquality(TestConstants.Accounts.account1[TestConstants.Accounts.name])
        addAccountScreen.assertAmountTextFieldEquality(TestConstants.Accounts.account1[TestConstants.Accounts.amount])
        addAccountScreen.assertCurrencyLabelEquality(TestConstants.Accounts.account1[TestConstants.Accounts.currencyText])
        addAccountScreen.returnToAccountScreenFromEdit()
        
        // Assert that the currency, account name, and amount of the normal account are correct
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxNormal)
        addAccountScreen.assertAccountNameTextFieldEquality(TestConstants.Accounts.account2[TestConstants.Accounts.name])
        addAccountScreen.assertAmountTextFieldEquality(TestConstants.Accounts.account2[TestConstants.Accounts.amount])
        addAccountScreen.assertCurrencyLabelEquality(TestConstants.Accounts.account2[TestConstants.Accounts.currencyText])
    }
    
    // Test that the buttons are correct: a default account must have two disabled buttons
    // while a non-default account must have two tappable icons.
    func testEditScreenCorrectButtons() {
        self.addTestingAccounts()
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxDefault)
        
        // Assert that a default account must have two disabled buttons
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.assertButtonEnabled(
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_SET_AS_DEFAULT_DISABLED),
            isEnabled: false
        )
        addAccountScreen.assertButtonEnabled(
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT_DISABLED),
            isEnabled: false
        )
        addAccountScreen.returnToAccountScreenFromEdit()
        
        // ...while a non-default account must have two tappable icons.
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxNormal)
        addAccountScreen.assertButtonEnabled(
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_SET_AS_DEFAULT),
            isEnabled: true
        )
        addAccountScreen.assertButtonEnabled(
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT),
            isEnabled: true
        )
    }
    
    // Proceed to the Edit Account Screen and update the account name and initial amount.
    // Change the currency and head back. Assert that the values displayed are correct.
    func testChangeEditScreenFields() {
        self.addTestingAccounts()
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxNormal)
        
        // Proceed to the Edit Account Screen and update the account name and initial amount.
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.deleteAndEnterAccountNameText(
            TestConstants.Accounts.account2New[TestConstants.Accounts.name],
            deleteDuration: 2.5
        )
        addAccountScreen.tapAmountTextField()
        addAccountScreen.deleteAndEnterAmountText(
            TestConstants.Accounts.account2New[TestConstants.Accounts.amount],
            deleteDuration: 2.5
        )
        addAccountScreen.tapCurrencyCell()
        
        // Tap the currency and head back. Assert that the values displayed are correct.
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapElementWithCountryName(TestConstants.Accounts.account2New[TestConstants.Accounts.country])
        currencyPickerScreen.tapBackButtonToEdit()
        addAccountScreen.assertAccountNameTextFieldEquality(TestConstants.Accounts.account2New[TestConstants.Accounts.name])
        addAccountScreen.assertAmountTextFieldEquality(TestConstants.Accounts.account2New[TestConstants.Accounts.amount])
    }
    
    // Proceed to the Edit Account Screen with a non-default account. Tap the delete button.
    // Assert that we pop back to the Accounts Screen with the deleted account removed.
    func testDeleteButton() {
        self.addTestingAccounts()
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxNormal)
        
        // Tap the delete button.
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapDeleteButton()
        sleep(3)
        accountScreen.assertCellCount(1)
    }
    
    // Proceed to the Edit Account Screen with a non-default account. Tap the Set as Default button.
    // Assert that both buttons have their text changed and are now set as disabled.
    // Return to the accounts screen and assert that the default account icon has changed.
    func testSetDefaultButtonSave() {
        self.addTestingAccounts()
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxNormal)
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapSetAsDefaultButton()
        addAccountScreen.tapSaveButton()
        
        accountScreen.assertCellIsDefaultAccount(TestConstants.Accounts.idxNormal)
        accountScreen.assertCellIsNotDefaultAccount(TestConstants.Accounts.idxDefault)
    }
    
    // Essentially the same as testSetDefaultButtonSave, but we use the back button instead
    func testSetDefaultButtonBack() {
        self.addTestingAccounts()
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxNormal)
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapSetAsDefaultButton()
        addAccountScreen.returnToAccountScreenFromEdit()
        
        accountScreen.assertCellIsDefaultAccount(TestConstants.Accounts.idxNormal)
        accountScreen.assertCellIsNotDefaultAccount(TestConstants.Accounts.idxDefault)
    }
    
    // Change the account and hit Save. Assert that the relevant data has been changed.
    func testEditAccountSave() {
        self.addTestingAccounts()
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxNormal)
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.deleteAndEnterAccountNameText(
            TestConstants.Accounts.account2New[TestConstants.Accounts.name],
            deleteDuration: 2.5
        )
        addAccountScreen.tapAmountTextField()
        addAccountScreen.deleteAndEnterAmountText(
            TestConstants.Accounts.account2New[TestConstants.Accounts.amount],
            deleteDuration: 2.5
        )
        addAccountScreen.tapCurrencyCell()
        
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapElementWithCountryName(
            TestConstants.Accounts.account2New[TestConstants.Accounts.country]
        )
        currencyPickerScreen.tapBackButtonToEdit()
        addAccountScreen.tapSetAsDefaultButton()
        addAccountScreen.tapSaveButton()
        sleep(3)
        
        accountScreen.assertCellIsDefaultAccount(TestConstants.Accounts.idxNormal)
        accountScreen.assertCellIsNotDefaultAccount(TestConstants.Accounts.idxDefault)
        accountScreen.assertCellTextWithIndex(
            TestConstants.Accounts.idxNormal,
            textToFind: TestConstants.Accounts.account2New[TestConstants.Accounts.name]
        )
        accountScreen.assertCellTextWithIndex(
            TestConstants.Accounts.idxNormal,
            textToFind: TestConstants.Accounts.account2New[TestConstants.Accounts.processedCurrency]
        )
    }
    
    // Confirm that it is not possible to edit the account and change its name to an existing account name
    func testMultipleAccountNameEdit() {
        self.addTestingAccounts()
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapCellWithIndex(TestConstants.Accounts.idxNormal)
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.deleteAndEnterAccountNameText(
            TestConstants.Accounts.account1[TestConstants.Accounts.name],
            deleteDuration: 2.5
        )
        addAccountScreen.tapSaveButton()
        addAccountScreen.tapErrorAlertOkButton()
    }
    
    func testRunThrough() {
        
        self.addAccountSuccess("My Wallet", amount: "0", currencyName: "United States", isDefault: true)
        self.addAccountSuccess("Bank Account X", amount: "880000", currencyName: "Japan", isDefault: false)
        self.addAccountSuccess("Bank Account Y", amount: "25000", currencyName: "United States", isDefault: false)
        
        // START OF RECORDING! Remove the code in the App Delegate which deletes the Core Data.
        sleep(5)
        self.addAccountSuccess("Coin Purse", amount: "55.25", currencyName: "United States", isDefault: true)
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.swipeCellLeftAndDeleteWithIndex(0)
        accountScreen.tapCellWithIndex(1)
        
        // Proceed to the Edit Account Screen and update the account name and initial amount.
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.deleteAndEnterAccountNameText(
            "Bank Account Z",
            deleteDuration: 2.0
        )
        
        addAccountScreen.tapSaveButton()
        
        accountScreen.swipeCellLeftAndSetAsDefaultWithIndex(1)
        accountScreen.tapCellWithIndex(2)
        addAccountScreen.tapSetAsDefaultButton()
        addAccountScreen.tapSaveButton()
        sleep(5)
    }
    
    // Confirm that we cannot add a new budget if there are no default accounts
    func testAddBudgetNoDefaultAccount() {
        ScreenManager.tapBudgetsTab(self.app)
        
        let budgetScreen = BudgetScreen.screenFromApp(self.app)
        budgetScreen.tapAddBudgetButton()
        budgetScreen.tapErrorAlertOkButton()
    }
}
