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
        self.app.buttons[BunnyUIUtils.uncommentedLocalizedString(StringConstants.BUTTON_CANCEL)].tap()
    }
    
    func tapSearchBarClearText() {
        self.app.searchFields.element.buttons["Clear text"].tap()
    }
    
    func tapBackButtonToEdit() {
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_CURRENCY_PICKER)
        ].buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_EDIT_ACCOUNT)
        ].tap()
    }
    
    func tapBackButtonToAdd() {
        self.app.navigationBars[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_CURRENCY_PICKER)
        ].buttons[
            BunnyUIUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ADD_ACCOUNT)
        ].tap()
    }
    
    func tapElementWithCountryName(countryName: String) {
        self.app.tables.cells.staticTexts[countryName].tap()
    }
    
    func typeSearchBar(query: String) {
        self.app.searchFields.element.typeText(query)
    }
    
}
