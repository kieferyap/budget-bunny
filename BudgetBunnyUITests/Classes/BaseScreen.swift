//
//  AccountScreen.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/7/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class BaseScreen: NSObject {
    
    var app = XCUIApplication()
    
    required init(app: XCUIApplication) {
        self.app = app
    }
    
    class func screenFromApp(app: XCUIApplication) -> Self {
        return self.init(app: app)
    }
    
}
