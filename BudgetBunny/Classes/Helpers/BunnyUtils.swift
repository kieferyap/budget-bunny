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
    
//    class func showAlertWithOKButton(title: String, message: String) {
//        let alertMessage = UIAlertController.init(title: title,
//                                                message: message,
//                                         preferredStyle: UIAlertControllerStyle.Alert)
//        
//        let okAction = UIAlertAction.init(title: "OK", style: <#T##UIAlertActionStyle#>, handler: <#T##((UIAlertAction) -> Void)?##((UIAlertAction) -> Void)?##(UIAlertAction) -> Void#>)
//        
//        
//        //            UIAlertController* alertMessage =
//        //                [UIAlertController alertControllerWithTitle:title
//        //                    message:msg
//        //                    preferredStyle:UIAlertControllerStyleAlert];
//        //
//        //            UIAlertAction* okAction =
//        //                [UIAlertAction actionWithTitle:NSLocalizedString(IDS_LBL_OK, nil)
//        //                    style:UIAlertActionStyleDefault
//        //                    handler:
//        //                    ^(UIAlertAction* _Nonnull action) {
//        //                    if (handler) {
//        //                    handler();
//        //                    }
//        //                    }];
//        //
//        //            [alertMessage addAction:okAction];
//        //            [viewController presentViewController:alertMessage animated:YES completion:nil];
//    }
    
}
