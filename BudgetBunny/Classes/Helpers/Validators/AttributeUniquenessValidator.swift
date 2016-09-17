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
    var oldName: String
    
    init(objectToValidate: NSObject, errorStringKey: String, oldName: String) {
        self.objectToValidate = objectToValidate
        self.errorStringKey = errorStringKey
        self.oldName = oldName
    }
    
    func validateObject() -> Bool {
        let field = self.objectToValidate as! AttributeModel
        var isDuplicateNotFound = false
        let oldName = self.oldName
        
        let model = ActiveRecord(tableName: field.tableName)
        model.selectAllObjectsWithParameters([field.format: field.value]) { (objects) in
            var conditions = false
            
            // New account? Just check if we didn't retrieve any duplicates.
            if oldName == "" {
                conditions = objects.count == 0
            }
                
            // Editing account? We're good if:
            //  - We didn't retrieve any duplicates OR
            //  - We retrieved a duplicate, but it's actually the same as the old name, which means that the name wasn't edited.
            else {
                conditions = (objects.count == 1 && objects[0].valueForKey(ModelConstants.Account.name) as! String == oldName) || (objects.count == 0)
            }
            
            isDuplicateNotFound = conditions
        }
        
        return isDuplicateNotFound
    }
    
}
