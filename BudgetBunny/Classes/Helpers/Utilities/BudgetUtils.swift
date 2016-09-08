//
//  BudgetUtils.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/22/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class BudgetUtils: NSObject {

    class func showRenameDialog(
        vc: BudgetViewController,
        model: BunnyCell,
        incomeList: [SingleElementCell]) {
        BunnyUtils.showTextFieldAlertWithCancelOK(
            StringConstants.LABEL_RENAME,
            messageKey: StringConstants.LABEL_RENAME_MESSAGE,
            placeholderKey: StringConstants.TEXTFIELD_RENAME_PLACEHOLDER,
            viewController: vc)
        { (textField) in
            let categoryModel = model as! CategoryCell
            let trimmedText = BunnyUtils.trimLeadingTrailingSpaces(textField.text!)
            if trimmedText != (categoryModel.categoryObject.valueForKey(ModelConstants.Category.name) as? String) {
                BunnyUtils.saveSingleField(
                    trimmedText,
                    parentArray: incomeList,
                    maxCount: ScreenConstants.Budget.incomeMaxCount,
                    errorMaxCountKey: StringConstants.ERRORLABEL_TOO_MANY_CATEGORIES,
                    errorEmptyNameKey: StringConstants.ERRORLABEL_CATEGORY_NOT_EMPTY,
                    errorDuplicateNameKey: StringConstants.ERRORLABEL_DUPLICATE_CATEGORY_NAME,
                    viewController: vc,
                    isRename: true
                ) { (success, newItem) in
                    if success {
                        let activeRecord = BunnyModel.init(tableName: ModelConstants.Entities.category)
                        
                        // Set the values of the account and insert it
                        let values = NSDictionary.init(
                            objects: [
                                newItem,
                                true,
                                categoryModel.categoryObject.valueForKey(ModelConstants.Category.monthlyAmount) as! Double
                            ],
                            forKeys: [
                                ModelConstants.Category.name,
                                ModelConstants.Category.isIncome,
                                ModelConstants.Category.monthlyAmount
                            ]
                        )
                        
                        activeRecord.updateObjectWithObjectId(
                            categoryModel.categoryObject.objectID,
                            updateParameters: values
                        )
                        
                        activeRecord.save()
                        vc.updateIncomeSection()
                    }
                }
            }
        }
        vc.budgetTableView.setEditing(false, animated: true)
    }
    
    class func showDeleteDialog(vc: BudgetViewController, model: BunnyCell) {
        let categoryModel = model as! CategoryCell
        let alertController = UIAlertController.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_WARNING_DELETE_ACCOUNT_TITLE),
            message: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_WARNING_DELETE_ACCOUNT_MESSAGE),
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        // TO-DO: Change localization of "DELETE_ACCOUNT"
        alertController.addAction(
            UIAlertAction.init(
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT),
                style: UIAlertActionStyle.Destructive,
                handler: { (UIAlertAction) in
                    let activeRecord = BunnyModel.init(tableName: ModelConstants.Entities.account)
                    activeRecord.deleteObject(
                        categoryModel.categoryObject,
                        completion: {
                            vc.updateIncomeSection()
                        }
                    )
                }
            )
        )
        alertController.addAction(
            UIAlertAction.init(
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_CANCEL),
                style: UIAlertActionStyle.Cancel,
                handler: nil
            )
        )
        vc.presentViewController(
            alertController,
            animated: true,
            completion: nil
        )
        vc.budgetTableView.setEditing(false, animated: true)
    }
}
