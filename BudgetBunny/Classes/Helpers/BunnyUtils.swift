//
//  BunnyUtils.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/26/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class BunnyUtils: NSObject {

    class func uncommentedLocalizedString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    class func addKeyboardDismisserListener(vc: UIViewController) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: vc, action:#selector(BunnyUtils.dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        vc.view.addGestureRecognizer(tapRecognizer)
    }
    
    class func dismissKeyboard() {
    }
    
}
