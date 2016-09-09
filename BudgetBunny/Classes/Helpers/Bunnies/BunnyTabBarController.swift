//
//  BunnyTabBarController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/6/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class BunnyTabBarController: UITabBarController {
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
        
        for (index, item) in (self.tabBar.items?.enumerate())! {
            item.title = BunnyUtils.uncommentedLocalizedString(Constants.AppKeys.tabBarKeys[index])
        }
    }
    
}
