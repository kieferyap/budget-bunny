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
    var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func addValidator(validator: ValidatorProtocol) {
        self.validators.append(validator)
    }
    
    func validate(completion: (success: Bool) -> Void) {
        for validator in self.validators {
            if !validator.validateObject() {
                
                // If there is an error, display it.
                BunnyUtils.showAlertWithOKButton(
                    self.viewController,
                    titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                    messageKey: validator.errorStringKey
                )
                completion(success: false)
                return
            }
        }
        completion(success: true)
    }
    
}
