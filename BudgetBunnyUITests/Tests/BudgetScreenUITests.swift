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
    
    func testTing() {
        self.proceedToAddBudgetScreen()
        
        let addBudgetScreen: AddBudgetScreen = AddBudgetScreen.screenFromApp(self.app)
        addBudgetScreen.tapBudgetNameTextField()
        addBudgetScreen.tapAmountTextField()
        addBudgetScreen.tapAddCategoryTextField()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
