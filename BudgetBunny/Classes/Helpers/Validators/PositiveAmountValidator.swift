//
//  PositiveAmountValidator.swift
//  BudgetBunny
//
//  Created by Opal Orca on 9/21/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class PositiveAmountValidator: NSObject, ValidatorProtocol {
    
    var objectToValidate: NSObject
    var errorStringKey: String
    
    init(objectToValidate: NSObject, errorStringKey: String) {
        self.objectToValidate = objectToValidate
        self.errorStringKey = errorStringKey
    }
    
    func validateObject() -> Bool {
        let number = self.objectToValidate as! Double
        return number > 0
    }
    
}
