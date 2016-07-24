//
//  BudgetUtils.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/22/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class BudgetUtils: NSObject {

    class func showRenameDialog(vc: BudgetViewController, model: BunnyCell) {
        BunnyUtils.showTextFieldAlertWithCancelOK(
            "Rename",
            messageKey: "Enter the new name",
            placeholderKey: "Enter new name",
            viewController: vc)
        { (textField) in
            let activeRecord = BunnyModel.init(tableName: ModelConstants.Entities.category)
            let budgetModel = model as! CategoryCell
            
            if textField.text != (budgetModel.categoryObject.valueForKey(ModelConstants.Category.name) as? String) {
                // Set the values of the account and insert it
                let values = NSDictionary.init(
                    objects: [
                        textField.text!,
                        true,
                        budgetModel.categoryObject.valueForKey(ModelConstants.Category.monthlyAmount) as! Double
                    ],
                    forKeys: [
                        ModelConstants.Category.name,
                        ModelConstants.Category.isIncome,
                        ModelConstants.Category.monthlyAmount
                    ]
                )
                
                activeRecord.updateObjectWithObjectId(
                    budgetModel.categoryObject.objectID,
                    updateParameters: values
                )
                
                activeRecord.save()
                vc.updateIncomeSection()
            }
        }
    }
    
    class func showDeleteDialog() {
        let alertController = UIAlertController.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_WARNING_DELETE_ACCOUNT_TITLE),
            message: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_WARNING_DELETE_ACCOUNT_MESSAGE),
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        let deleteAction = UIAlertAction.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT),
            style: UIAlertActionStyle.Destructive,
            handler: { (UIAlertAction) in
                // completion()
            }
        )
        let cancelAction = UIAlertAction.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_CANCEL),
            style: UIAlertActionStyle.Cancel,
            handler: nil
        )
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        // return alertController
    }
}
