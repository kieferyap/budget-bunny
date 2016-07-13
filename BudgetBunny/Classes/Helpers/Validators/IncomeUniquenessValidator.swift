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
    var parentArray: [DoubleElementCell]
    
    init(objectToValidate: NSObject, errorStringKey: String, parentArray: [DoubleElementCell]) {
        self.objectToValidate = objectToValidate
        self.errorStringKey = errorStringKey
        self.parentArray = parentArray
    }
    
    func validateObject() -> Bool {
        let object = self.objectToValidate as! DoubleElementCell
        for item in parentArray {
            if item.alphaElementTitle == object.alphaElementTitle {
                return false
            }
        }
        return true
    }
}