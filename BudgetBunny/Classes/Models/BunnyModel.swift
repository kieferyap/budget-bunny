//
//  BunnyModel.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/25/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class BunnyModel: NSObject {

    var tableName: String = ""
    var appDelegate: AppDelegate!
    var managedContext: NSManagedObjectContext!
    
    init(tableName: String) {
        self.tableName = tableName
        self.appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedContext = appDelegate.managedObjectContext
    }
    
    func selectAllObjects(completion: (fetchedObjects: [NSManagedObject]) -> Void) {
        self.selectAllObjectsWithParameters([:], completion: completion)
    }
    
    func changeTableName(newTableName: String) {
        self.tableName = newTableName
    }
    
    func selectAllObjectsWithParameters(parameters: NSDictionary, completion: (fetchedObjects: [NSManagedObject]) -> Void) {
        let fetchRequest = NSFetchRequest(entityName: self.tableName)
        
        if parameters != [:] {
            var predicateArray = [NSPredicate]()
            for (key, value) in parameters {
                let predicate = NSPredicate(format: key as! String, value as! NSString)
                predicateArray.append(predicate)
            }
            let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: predicateArray)
            fetchRequest.predicate = compoundPredicate
        }
            
        do {
            let fetchedObjects = try self.managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            completion(fetchedObjects: fetchedObjects)
        } catch let error as NSError {
            print("Could not find user: \(error)")
        }
    }
    
    func deleteAllObjects() -> Bool {
        let fetchRequest = NSFetchRequest(entityName: self.tableName)
        
        do {
            let fetchedObjects = try self.managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            for object in fetchedObjects {
                self.managedContext.deleteObject(object)
            }
            try self.managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error)")
            return false
        }
        return true
    }
    
    func deleteObject(object: NSManagedObject, completion: () -> Void) -> Bool {
        self.managedContext.deleteObject(object)
        
        do {
            try managedContext.save()
            
            // What would you like to do once the object has been successfully deleted?
            // (e.g.: Remove the row and update the table view)
            completion()
        } catch let error as NSError {
            print("Error occured while saving: \(error)")
            return false
        }
        
        return true
    }
    
    func insertObject(values: NSDictionary) -> NSManagedObject {
        let entity = NSEntityDescription.entityForName(self.tableName, inManagedObjectContext: self.managedContext)
        let model = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: self.managedContext)
        
        for value in values {
            print(value.value, value.key)
            model.setValue(value.value, forKey: value.key as! String)
        }
        return model
    }
    
    func save() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error occured while saving: \(error)")
        }
    }
    
}
