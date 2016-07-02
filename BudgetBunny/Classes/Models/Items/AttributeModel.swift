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
    var value: NSObject
    
    init(tableName: String, key: String, value: NSObject) {
        self.tableName = tableName
        let formattedString = String.init(format: "%@ == ", key)
        self.format = formattedString.stringByAppendingString("%@")
        self.value = value
    }
}
