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
        
        let request = NSFetchRequest()
        request.entity = NSEntityDescription.entityForName(field.tableName, inManagedObjectContext: field.context)
        request.predicate = NSPredicate(format: field.format, field.value)
        
        do {
            let objects = try field.context.executeFetchRequest(request) as! [NSObject]
            if objects.count > 0 {
                return false
            }
        } catch let error as NSError {
            print("Could not find user: \(error), \(error.userInfo)")
            return false
        }
        return true
    }
    
}
