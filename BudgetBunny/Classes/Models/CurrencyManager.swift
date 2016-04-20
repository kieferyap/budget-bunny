//
//  CurrencyManager.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class CurrencyManager: NSObject {

    var currencyDictionary: NSMutableDictionary = [:]
    var currencyNames: NSMutableArray = []
    
    func setCurrencyList() {
        let countries: NSArray = NSLocale.availableLocaleIdentifiers()
        
        for country in (countries as! [String]) {
            let currency = Currency()
            currency.setAttributes(country)
            
            if self.currencyDictionary.objectForKey(currency.name) == nil {
                self.currencyDictionary.setObject(currency, forKey: currency.name)
                self.currencyNames.addObject(currency.name)
            }
        }
    }
}