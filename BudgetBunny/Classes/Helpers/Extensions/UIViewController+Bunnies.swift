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
private var modelDataKey: UInt8 = 0

extension UIViewController {
    
    var sourceInformation: Int! {
        get {
            return (objc_getAssociatedObject(self, &sourceInformationKey) as? Int)!
        }
        set (newValue) {
            objc_setAssociatedObject(self, &sourceInformationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var modelData: Array<Array<BunnyCell>>! {
        get {
            return (objc_getAssociatedObject(self, &modelDataKey) as? Array)!
        }
        set (newValue) {
            objc_setAssociatedObject(self, &modelDataKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    func setTitleLocalizationKey(key: String) {
        let title = BunnyUtils.uncommentedLocalizedString(key)
        self.navigationController!.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = title
        self.navigationController?.navigationBar.exclusiveTouch = true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func prepareNextViewController(
        destinationViewController: UIViewController,
        sourceInformation: Int,
        completion: (destinationViewController: UIViewController) -> Void
    ) {
        destinationViewController.hidesBottomBarWhenPushed = true
        destinationViewController.sourceInformation = sourceInformation
        completion(destinationViewController: destinationViewController)
    }
    
    func prepareModelData(sectionCount: Int, completion: () -> Void) {
        self.modelData = Array.init(count: sectionCount, repeatedValue: [])
        completion()
        
        // Keyboard must be dismissed when regions outside of it is tapped
        BunnyUtils.addKeyboardDismisserListener(self)
    }
    
    func appendCellAtSectionIndex(idxSection: Int, idxRow: Int, cellData: BunnyCell) {
        self.modelData[idxSection].insert(cellData, atIndex: idxRow)
    }
    
}
