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
    
    func tapErrorAlertOkButton() {
        self.app.alerts[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.ERRORLABEL_ERROR_TITLE)
            ].collectionViews.buttons[
                BunnyUIUtils.uncommentedLocalizedString(StringConstants.LABEL_OK)
            ].tap()
    }
    
    func getTableElementAtIndex(index: UInt) -> XCUIElement {
        return self.app.tables.cells.elementAtIndex(index)
    }
    
    func assertCellCount(count: UInt) {
        XCTAssertEqual(self.app.tables.cells.count, count)
    }    
}
