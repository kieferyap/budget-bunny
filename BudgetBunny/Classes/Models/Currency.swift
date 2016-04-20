//
//  Currency.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class Currency: NSObject {

    var currencyCode: String = ""
    var currencySymbol: String = ""
    var country: String = ""
    var identifier: String = ""
    
    func setAttributes(identifier: String) {
        
        let currencyCode = NSLocale.init(localeIdentifier:identifier).objectForKey(NSLocaleCountryCode) as? String
        let currencySymbol = NSLocale.init(localeIdentifier:identifier).objectForKey(NSLocaleCurrencySymbol) as? String
        let countryName = NSLocale.currentLocale().displayNameForKey(NSLocaleCountryCode, value: identifier)
        
        let isCodeUsable: Bool = currencyCode != nil
        let isSymbolUsable: Bool = currencySymbol != nil
        let isNameUsable: Bool = countryName != nil
        
        if isCodeUsable && isSymbolUsable && isNameUsable {
            self.currencyCode = currencyCode!
            self.currencySymbol = currencySymbol!
            self.country = countryName!
            self.identifier = identifier
        }
    }
}
