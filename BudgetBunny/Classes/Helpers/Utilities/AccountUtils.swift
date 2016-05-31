//
//  AccountUtils.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/31/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class AccountUtils: NSObject {
    
    // Summons the account deletion popup. This sort of popup will be used twice, both in account deletion. This is because deleting an account causes a ripple effect, where transactions and other information are also deleted, so caution must be taken when deleting an account.
    class func accountDeletionPopup(completion: () -> Void) -> UIAlertController {
        let alertController = UIAlertController.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_WARNING_DELETE_ACCOUNT_TITLE),
            message: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_WARNING_DELETE_ACCOUNT_MESSAGE),
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        let deleteAction = UIAlertAction.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT),
            style: UIAlertActionStyle.Destructive,
            handler: { (UIAlertAction) in
                completion()
            }
        )
        let cancelAction = UIAlertAction.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_CANCEL),
            style: UIAlertActionStyle.Cancel,
            handler: nil
        )
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        return alertController
    }

}