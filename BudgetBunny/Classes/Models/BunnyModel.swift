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
        let fetchRequest = NSFetchRequest(entityName: self.tableName)
        do {
            let fetchedObjects = try self.managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            completion(fetchedObjects: fetchedObjects)
        } catch let error as NSError {
            print("Could not find user: \(error), \(error.userInfo)")
        }
    }
    
    func selectAllObjectsWithParameters(parameters: NSDictionary, completion: (fetchedObjects: [NSManagedObject]) -> Void) {
        let fetchRequest = NSFetchRequest(entityName: self.tableName)
        var predicateArray = [NSPredicate]()
        for (key, value) in parameters {
            let predicate = NSPredicate(format: key as! String, value as! NSString)
            predicateArray.append(predicate)
        }
        let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: predicateArray)
        fetchRequest.predicate = compoundPredicate
        
        do {
            let fetchedObjects = try self.managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
            completion(fetchedObjects: fetchedObjects)
        } catch let error as NSError {
            print("Could not find user: \(error), \(error.userInfo)")
        }
    }
    
}
