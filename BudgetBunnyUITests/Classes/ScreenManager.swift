//
//  ScreenManager.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/7/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import XCTest

@available(iOS 9.0, *)
class ScreenManager: NSObject {
    
    class func tapAccountsTab(app: XCUIApplication) {
        self.tapTab("accounts", app: app)
    }
    
    class func tapBudgetsTab(app: XCUIApplication) {
        self.tapTab("budgets", app: app)
    }
    
    class func tapRecordsTab(app: XCUIApplication) {
        self.tapTab("records", app: app)
    }
    
    class func tapDashboardTab(app: XCUIApplication) {
        self.tapTab("dashboard", app: app)
    }
    
    class func tapTab(tabName: String, app: XCUIApplication) {
        let tabBars = XCUIApplication().tabBars
        tabBars.buttons[tabName].tap()
    }
}
