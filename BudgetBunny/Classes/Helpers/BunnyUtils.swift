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
    
    class func addKeyboardDismisserListener(viewController: UIViewController) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: viewController, action:#selector(BunnyUtils.dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        viewController.view.addGestureRecognizer(tapRecognizer)
    }
    
    class func dismissKeyboard() {
    }
    
    class func isKeyExistingForAddEditAccountCell(cell: AddEditAccountCell, key: String) -> Bool {
        return cell.cellSettings[key] != nil
    }
    
    class func showAlertWithOKButton(viewController: UIViewController, title: String, message: String) {
        let okMessage = BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_OK)
        
        let alertController = UIAlertController.init(title: title,
                                                message: message,
                                         preferredStyle: UIAlertControllerStyle.Alert)

        let okAction = UIAlertAction.init(title: okMessage, style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(okAction)
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
}
