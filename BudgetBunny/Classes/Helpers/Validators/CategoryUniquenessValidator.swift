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
    var parentArray: [SingleElementCell]
    
    init(objectToValidate: NSObject, errorStringKey: String, parentArray: [SingleElementCell]) {
        self.objectToValidate = objectToValidate
        self.errorStringKey = errorStringKey
        self.parentArray = parentArray
    }
    
    func validateObject() -> Bool {
        let object = self.objectToValidate as! SingleElementCell
        for item in parentArray {
            if item.alphaElementTitle == object.alphaElementTitle {
                return false
            }
        }
        return true
    }        
    
}
