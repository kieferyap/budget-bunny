//
//  AccountScreen.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/7/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import XCTest

@available(iOS 9.0, *)
class CurrencyPickerScreen: BaseScreen {
    
    func tapSearchBar() {
        self.app.searchFields.element.tap()
    }
    
    func tapSearchBarCancel() {
        self.app.buttons["Cancel"].tap()
    }
    
    func tapSearchBarClearText() {
        self.app.searchFields.element.buttons["Clear text"].tap()
    }
    
    func tapBackButton() {
        self.app.navigationBars["Currency"].buttons["Add New Account"].tap()
    }
    
    func tapElementWithCountryName(countryName: String) {
        self.app.tables.cells.staticTexts[countryName].tap()
    }
    
    func tapFirstElement() {
        self.app.childrenMatchingType(.Window).elementBoundByIndex(0).tap()
    }
    
    func typeSearchBar(query: String) {
        self.app.searchFields.element.typeText(query)
    }
    
}
