//
//  UIViewController+Bunnies.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/4/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import ObjectiveC

private var backButtonTitleKey: UInt8 = 0
private var navigationTitleKey: UInt8 = 0

extension UIViewController {
    
    var backButtonTitle: String! {
        get {
            return (objc_getAssociatedObject(self, &backButtonTitleKey) as? String)!
        }
        set (newValue) {
            objc_setAssociatedObject(self, &backButtonTitleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var navigationTitle: String! {
        get {
            return (objc_getAssociatedObject(self, &navigationTitleKey) as? String)!
        }
        set (newValue) {
            objc_setAssociatedObject(self, &navigationTitleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func setTitleLocalizationKey(key: String) {
        let title = BunnyUtils.uncommentedLocalizedString(key)
        self.backButtonTitle = title
        self.navigationTitle = title
        self.navigationItem.title = title
        
    }
    
    func prepareBackButton() {
        self.navigationItem.title = self.backButtonTitle
    }
    
    func restoreBackButton() {
        self.navigationItem.title = self.navigationTitle
    }
}
