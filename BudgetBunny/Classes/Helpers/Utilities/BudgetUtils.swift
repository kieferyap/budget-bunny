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
        vc: UIViewController,
        tableView: UITableView,
        completion: (textField: UITextField) -> Void
    ) {
        BunnyUtils.showTextFieldAlertWithCancelOK(
            StringConstants.LABEL_RENAME,
            messageKey: StringConstants.LABEL_RENAME_MESSAGE,
            placeholderKey: StringConstants.TEXTFIELD_RENAME_PLACEHOLDER,
            viewController: vc
        ) { (textField) in
            completion(textField: textField)
        }
        tableView.setEditing(false, animated: true)
    }
    
    class func saveIncomeCategoryTextField(
        textField: UITextField,
        model: BunnyCell,
        incomeList: [SingleElementCell],
        vc: UIViewController,
        completion: () -> Void
    ) {
        let categoryModel = model as! IncomeCategoryCell
        let trimmedText = BunnyUtils.trimLeadingTrailingSpaces(textField.text!)
        if trimmedText != (categoryModel.categoryObject.valueForKey(ModelConstants.Category.name) as? String) {
            BunnyUtils.saveSingleField(
                trimmedText,
                parentArray: incomeList,
                maxCount: ScreenConstants.Budget.incomeMaxCount,
                maxLength: ScreenConstants.Budget.incomeNameMaxLength,
                errorMaxLengthKey: StringConstants.ERRORLABEL_INCOME_CATEGORY_NAME_TOO_LONG,
                errorMaxCountKey: StringConstants.ERRORLABEL_TOO_MANY_CATEGORIES,
                errorEmptyNameKey: StringConstants.ERRORLABEL_CATEGORY_NOT_EMPTY,
                errorDuplicateNameKey: StringConstants.ERRORLABEL_DUPLICATE_CATEGORY_NAME,
                viewController: vc,
                isRename: true
            ) { (success, newItem) in
                if success {
                    let activeRecord = ActiveRecord.init(tableName: ModelConstants.Entities.category)
                    
                    // Set the values of the income category and insert it
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
                    completion()
                }
            }
        }
    }
    
    // Displaying category cell actions
    class func displayCategoryCellActions(
        vc: UIViewController,
        tableView: UITableView,
        renameCompletion: () -> Void,
        deleteCompletion: () -> Void
        
    ) {
        let alertController = UIAlertController.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_INCOME_ACTIONS),
            message: "",
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        let renameAction = UIAlertAction.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_RENAME),
            style: UIAlertActionStyle.Default,
            handler: { (UIAlertAction) in
                renameCompletion()
            }
        )
        
        let deleteAction = UIAlertAction.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_DELETE_CATEGORY_TITLE),
            style: UIAlertActionStyle.Destructive,
            handler: { (UIAlertAction) in
                deleteCompletion()
            }
        )
        
        let cancelAction = UIAlertAction.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_CANCEL),
            style: UIAlertActionStyle.Cancel,
            handler: nil
        )
        
        alertController.addAction(renameAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        vc.presentViewController(alertController, animated: true, completion: nil)
    }
}
