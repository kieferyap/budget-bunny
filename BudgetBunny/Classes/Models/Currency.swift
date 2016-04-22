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
        let localeIdentifier = NSLocale.init(localeIdentifier:identifier)
        
        let currencyCode = localeIdentifier.objectForKey(NSLocaleCurrencyCode) as? String
        let currencySymbol = localeIdentifier.objectForKey(NSLocaleCurrencySymbol) as? String
        let countryCode = localeIdentifier.objectForKey(NSLocaleCountryCode) as? String
        
        let isCodeUsable: Bool = currencyCode != nil
        let isSymbolUsable: Bool = currencySymbol != nil
        let isNameUsable: Bool = countryCode != nil
        
        if isNameUsable && isCodeUsable && isSymbolUsable {
            self.currencyCode = currencyCode!
            self.currencySymbol = currencySymbol!
            self.country = NSLocale.currentLocale().displayNameForKey(NSLocaleCountryCode, value: countryCode!)!
        }
    }
}
