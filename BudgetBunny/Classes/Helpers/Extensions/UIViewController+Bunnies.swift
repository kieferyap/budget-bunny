//
//  UIViewController+Bunnies.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/4/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import ObjectiveC

private var sourceInformationKey: UInt8 = 0

extension UIViewController {
    
    var sourceInformation: Int! {
        get {
            return (objc_getAssociatedObject(self, &sourceInformationKey) as? Int)!
        }
        set (newValue) {
            objc_setAssociatedObject(self, &sourceInformationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func setTitleLocalizationKey(key: String) {
        let title = BunnyUtils.uncommentedLocalizedString(key)
        self.navigationController!.view.backgroundColor = UIColor.whiteColor()
        //self.navigationController?.navigationBar.translucent = false
        self.navigationItem.title = title
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
