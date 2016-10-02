//
//  ActiveRecord.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/25/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class ActiveRecord: NSObject {

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
                let predicate = NSPredicate(format: key as! String, value as! NSObject)
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
    
    func deleteAllObjects(completion: () -> Void) -> Bool {
        return self.deleteAllObjectsWithParameters([:], completion: completion)
    }
    
    func deleteAllObjectsWithParameters(parameters: NSDictionary, completion: () -> Void) -> Bool {
        let fetchRequest = NSFetchRequest(entityName: self.tableName)
        
        if parameters != [:] {
            var predicateArray = [NSPredicate]()
            for (key, value) in parameters {
                let predicate = NSPredicate(format: key as! String, value as! NSObject)
                predicateArray.append(predicate)
            }
            let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: predicateArray)
            fetchRequest.predicate = compoundPredicate
        }
        
        do {
            let fetchedObjects = try self.managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            for object in fetchedObjects {
                self.managedContext.deleteObject(object)
            }
            try self.managedContext.save()
            completion()
        } catch let error as NSError {
            print("Could not find user: \(error)")
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
        
        let request = NSFetchRequest()
        request.entity = NSEntityDescription.entityForName(self.tableName, inManagedObjectContext: self.managedContext)
        
        for value in values {
            model.setValue(value.value, forKey: value.key as! String)
        }
        return model
    }
    
    func updateObjectWithObjectId(objectId: NSManagedObjectID, updateParameters: NSDictionary) -> NSManagedObject {
        do {
            let returnObject = try self.managedContext.existingObjectWithID(objectId)
            for (key, value) in updateParameters {
                returnObject.setValue(value, forKey: key as! String)
            }
            return returnObject
        } catch let error as NSError {
            print("Error occured: \(error)")
        }
        return NSManagedObject.init()

    }
    
    func updateAllValues(key: String, value: NSObject) {
        let request = NSFetchRequest()
        request.entity = NSEntityDescription.entityForName(self.tableName, inManagedObjectContext: self.managedContext)
        
        do {
            let objects = try self.managedContext.executeFetchRequest(request) as! [NSManagedObject]
            for object in objects {
                object.setValue(value, forKey: key)
            }
        } catch let error as NSError {
            print("Error: \(error)")
        }
    }
    
    func save() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error occured while saving: \(error)")
        }
    }
    
}
