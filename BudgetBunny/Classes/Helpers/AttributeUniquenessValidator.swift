//
//  AttributeUniquenessValidator.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/20/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class AttributeUniquenessValidator: NSObject, ValidatorProtocol {
    
    var objectToValidate: NSObject
    var errorStringKey: String
    
    init(objectToValidate: NSObject, errorStringKey: String) {
        self.objectToValidate = objectToValidate
        self.errorStringKey = errorStringKey
    }
    
    func validateObject() -> Bool {
        let field = self.objectToValidate as! AttributeModel
        var isDuplicateNotFound = false
        
        let model = BunnyModel(tableName: "Account")
        model.selectAllObjectsWithParameters([field.format: field.value]) { (objects) in
            if objects.count == 0 {
                isDuplicateNotFound = true
            }
        }
        
        return isDuplicateNotFound
    }
    
}
