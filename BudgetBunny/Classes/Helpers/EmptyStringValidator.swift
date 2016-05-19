//
//  EmptyStringValidator.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class EmptyStringValidator: NSObject, ValidatorProtocol {

    var objectToValidate: NSObject
    var errorStringKey: String
    
    init(objectToValidate: NSObject, errorStringKey: String) {
        self.objectToValidate = objectToValidate
        self.errorStringKey = errorStringKey
    }
    
    func validateObject() -> Bool {
        let field = self.objectToValidate as! String
        return field != ""
    }
    
}
