//
//  UIViewController+Bunnies.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/4/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import ObjectiveC

extension UIViewController {
    
    func setTitleLocalizationKey(key: String) {
        let title = BunnyUtils.uncommentedLocalizedString(key)
        self.navigationItem.title = title
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
