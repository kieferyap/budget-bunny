//
//  Currency.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class Currency: NSObject {

    var name: String = ""
    var code: String = ""
    var symbol: String = ""
    
    func setAttributes(identifier: String) {
        let country: NSLocale = NSLocale(localeIdentifier: identifier)
        let countryCode = String(country.objectForKey(NSLocaleCountryCode))
        let currentLocale = NSLocale.currentLocale()
        
        self.name = currentLocale.displayNameForKey(NSLocaleCountryCode, value: countryCode)!
        self.symbol = String(country.objectForKey(NSLocaleCurrencySymbol))
        self.code = String(country.objectForKey(NSLocaleCurrencyCode))
    }
}
