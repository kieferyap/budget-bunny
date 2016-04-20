//
//  Currency.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class Currency: NSObject {

    var code: String = ""
    var symbol: String = ""
    var name: String = ""
    
    func setAttributes(identifier: String) {
        
        let currencyCode = NSLocale.init(localeIdentifier:identifier).objectForKey(NSLocaleCountryCode) as? String
        let currencySymbol = NSLocale.init(localeIdentifier:identifier).objectForKey(NSLocaleCurrencySymbol) as? String
        let countryName = NSLocale.currentLocale().displayNameForKey(NSLocaleCountryCode, value: identifier)
        
        let isCodeUsable: Bool = currencyCode != nil
        let isSymbolUsable: Bool = currencySymbol != nil
        let isNameUsable: Bool = countryName != nil
        
        if isCodeUsable && isSymbolUsable && isNameUsable {
            self.code = currencyCode!
            self.symbol = currencySymbol!
            self.name = countryName!
        }
    }
}
