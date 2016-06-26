//
//  CategoryUniquenessValidator.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/26/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class CategoryUniquenessValidator: NSObject, ValidatorProtocol {
        
    var objectToValidate: NSObject
    var errorStringKey: String
    var parentArray: [AddEditBudgetCell]
    
    init(objectToValidate: NSObject, errorStringKey: String, parentArray: [AddEditBudgetCell]) {
        self.objectToValidate = objectToValidate
        self.errorStringKey = errorStringKey
        self.parentArray = parentArray
    }
    
    func validateObject() -> Bool {
        let object = self.objectToValidate as! AddEditBudgetCell
        for item in parentArray {
            if item.field == object.field {
                return false
            }
        }
        return true
    }        
    
}
