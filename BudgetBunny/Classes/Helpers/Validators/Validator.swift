//
//  Validator.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class Validator: NSObject {

    var validators = [ValidatorProtocol]()
    
    func addValidator(validator: ValidatorProtocol) {
        self.validators.append(validator)
    }
    
    func validate(completion: (errorMessage: String) -> Void) {
        for validator in self.validators {
            if !validator.validateObject() {
                let message = BunnyUtils.uncommentedLocalizedString(validator.errorStringKey)
                completion(errorMessage: message)
                return
            }
        }
        completion(errorMessage: "")
    }
    
}
