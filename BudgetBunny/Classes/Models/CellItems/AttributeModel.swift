//
//  AttributeModel.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/20/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class AttributeModel: NSObject {

    var tableName: String
    var format: String
    var context: NSManagedObjectContext
    var value: String
    
    init(tableName: String, format: String, value: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.context = appDelegate.managedObjectContext
        self.tableName = tableName
        self.format = format
        self.value = value
    }
}
