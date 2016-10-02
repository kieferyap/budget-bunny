//
//  PositiveAmountValidator.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 9/24/16.
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
        return (self.objectToValidate as! Double) > 0
    }
}
