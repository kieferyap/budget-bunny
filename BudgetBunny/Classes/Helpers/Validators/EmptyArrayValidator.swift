//
//  EmptyArrayValidator.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/1/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class EmptyArrayValidator: NSObject, ValidatorProtocol {

    var objectToValidate: NSObject
    var errorStringKey: String
    
    init(objectToValidate: NSObject, errorStringKey: String) {
        self.objectToValidate = objectToValidate
        self.errorStringKey = errorStringKey
    }
    
    func validateObject() -> Bool {
        let validate = self.objectToValidate as! NSArray
        return validate.count != 0
    }
    
}
