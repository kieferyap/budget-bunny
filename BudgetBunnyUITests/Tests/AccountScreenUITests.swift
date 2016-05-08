//
//  AddAccountUITests.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/7/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class AddAccountUITests: XCTestCase {
        
    var app = XCUIApplication();
    
    override func setUp() {
        super.setUp()
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: ACC-0001 Test Cases
    
    func proceedToAddAccountScreen() {
        ScreenManager.tapAccountsTab(self.app)
        
        let accountScreen: AccountScreen = AccountScreen.screenFromApp(self.app)
        accountScreen.tapAddAccountButton()
    }
    
    func testCellExistence() {
        self.proceedToAddAccountScreen()
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.tapAmountTextField()
        addAccountScreen.tapIsDefaultSwitch()
        addAccountScreen.tapCurrencyCell()
        
        let currencyPickerScreen: CurrencyPickerScreen = CurrencyPickerScreen.screenFromApp(self.app)
        currencyPickerScreen.tapFirstElement()
        currencyPickerScreen.tapSearchBar()
        currencyPickerScreen.typeSearchBar("Test")
        currencyPickerScreen.tapSearchBarClearText()
        currencyPickerScreen.tapSearchBar()
        currencyPickerScreen.tapSearchBarCancel()
        currencyPickerScreen.tapBackButton()
    }
    
    func testAddAccountTextFields() {
        self.proceedToAddAccountScreen()
        
        let accountName: String = "My bank account"
        let initialAmount: String = "450"
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.typeAccountNameTextField(accountName)
        addAccountScreen.assertAmountTextFieldEquality(accountName)
        
        addAccountScreen.tapAmountTextField()
        addAccountScreen.typeAmountTextField(initialAmount)
        addAccountScreen.assertAmountTextFieldEquality(initialAmount)
    
    }
    
    func testAddAccountTextFieldLength() {
        self.proceedToAddAccountScreen()
        
        let length30 = "123456789012345678901234567890"
        let length25 = "1234567890123456789012345"
        let length22 = "1234567890123456789012"
        
        let addAccountScreen: AddAccountScreen = AddAccountScreen.screenFromApp(self.app)
        addAccountScreen.tapAccountNameTextField()
        addAccountScreen.typeAccountNameTextField(length30)
        addAccountScreen.assertAccountTextFieldEquality(length25)
        
        addAccountScreen.tapAmountTextField()
        addAccountScreen.typeAmountTextField(length30)
        addAccountScreen.assertAmountTextFieldEquality(length22)
    }
    
    func testCurrencyCell() {
        self.proceedToAddAccountScreen()
    }
        
    
}
