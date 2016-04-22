//
//  CurrencyManager.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class CurrencyManager: NSObject {

    var currencyDictionary: NSMutableArray = []
    
    func setCurrencyList() {
        let countries: NSArray = NSLocale.availableLocaleIdentifiers()
        let unsortedCurrencyList: NSMutableDictionary = [:]
        
        for country in (countries as! [String]) {
            let currency = Currency()
            currency.setAttributes(country)
            unsortedCurrencyList.setObject(currency, forKey: currency.country)
        }
        
        let sortedKeys = (unsortedCurrencyList.allKeys as NSArray).sortedArrayUsingSelector(#selector(NSString.localizedCaseInsensitiveCompare(_:)))
        
        for key in sortedKeys {
            self.currencyDictionary.addObject(unsortedCurrencyList.objectForKey(key)!)
        }
    }
}