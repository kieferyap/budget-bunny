//
//  ValidatorProtocol.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

protocol ValidatorProtocol: class {
    var objectToValidate: NSObject {get set}
    var errorStringKey: String {get set}
    func validateObject() -> Bool
}
