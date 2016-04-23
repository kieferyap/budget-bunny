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
            if !key.isEqualToString("") {
                let keyString = (key as! String)
                let firstCharacter = String(keyString[keyString.startIndex])
                
                if self.currencyDictionary.objectForKey(firstCharacter) != nil {
                    self.currencyDictionary.setObject([:], forKey: firstCharacter)
                }
                
                self.currencyDictionary[firstCharacter]?.addObject(unsortedCurrencyList.objectForKey(key)!)
            }
        }
        
        print(self.currencyDictionary["A"])
    }
}