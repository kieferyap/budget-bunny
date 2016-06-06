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
        self.tapTab(BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ACCOUNT), app: app)
    }
    
    class func tapBudgetsTab(app: XCUIApplication) {
        self.tapTab(BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_BUDGETS), app: app)
    }
    
    class func tapRecordsTab(app: XCUIApplication) {
        self.tapTab(BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_DASHBOARD), app: app)
    }
    
    class func tapDashboardTab(app: XCUIApplication) {
        self.tapTab(BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_RECORDS), app: app)
    }
    
    class func tapTab(tabName: String, app: XCUIApplication) {
        let tabBars = XCUIApplication().tabBars
        tabBars.buttons[tabName].tap()
    }
}
