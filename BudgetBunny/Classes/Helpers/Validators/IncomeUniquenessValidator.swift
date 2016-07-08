//
//  IncomeUniquenessValidator.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/6/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class IncomeUniquenessValidator: NSObject, ValidatorProtocol {
    
    var objectToValidate: NSObject
    var errorStringKey: String
    var parentArray: [DoubleLabelCell]
    
    init(objectToValidate: NSObject, errorStringKey: String, parentArray: [DoubleLabelCell]) {
        self.objectToValidate = objectToValidate
        self.errorStringKey = errorStringKey
        self.parentArray = parentArray
    }
    
    func validateObject() -> Bool {
        let object = self.objectToValidate as! DoubleLabelCell
        for item in parentArray {
            if item.labelTitle == object.labelTitle {
                return false
            }
        }
        return true
    }
    
}