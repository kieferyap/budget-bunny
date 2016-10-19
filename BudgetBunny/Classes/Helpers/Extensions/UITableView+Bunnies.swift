//
//  UITableView+Bunnies.swift
//  BudgetBunny
//
//  Created by Opal Orca on 10/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

extension UITableView {
    func reloadSectionIndex(sectionIdx: Int, rowAnimation: UITableViewRowAnimation) {
        let reloadSection = NSIndexSet.init(index: sectionIdx)
        self.reloadSections(reloadSection, withRowAnimation: rowAnimation)
    }
}
