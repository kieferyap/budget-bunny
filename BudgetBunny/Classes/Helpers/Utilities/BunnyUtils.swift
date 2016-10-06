//
//  BunnyUtils.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/26/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class BunnyUtils: NSObject {

    // Returns an uncommented localized string, given the key. The comments are normally used for your localization team, but, well...)
    class func uncommentedLocalizedString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    // When called, this method adds a listener in the view controller which dismisses the keyboard whenever places other than the keyboard (or the textarea/textfield) have been tapped. Pretty handy, huh?
    class func addKeyboardDismisserListener(viewController: UIViewController) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: viewController, action:#selector(UIViewController.dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        viewController.view.addGestureRecognizer(tapRecognizer)
    }
    
    // The table cells can be customized by slapping on a special NSDictionary. This method simply checks if the cells' dictionary possess the specified key, and executes a completion handler if it does.
    class func keyExistsForCellSettings(cell: BunnyCell, key: String, completion: (object: AnyObject) -> Void) {
        if cell.cellSettings[key] != nil {
            completion(object: cell.cellSettings[key]!)
        }
    }
    
    // Method name is self-explanatory. I'm not a huge fan of the whole Copy-Paste Design Pattern, so this factory method will have to do. When summoned, this method will deal 65536 damage to all your enemies.
    class func showAlertWithOKButton(viewController: UIViewController, titleKey: String, messageKey: String) {
        let okMessage = BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_OK)
        
        let alertController = UIAlertController.init(
            title: BunnyUtils.uncommentedLocalizedString(titleKey),
            message: BunnyUtils.uncommentedLocalizedString(messageKey),
            preferredStyle: UIAlertControllerStyle.Alert
        )

        let okAction = UIAlertAction.init(title: okMessage, style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(okAction)
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // This is one of my favorite methods. It basically checks if the table has anything in it. If it doesn't, it tells the table view to display a certain text. (Think, "No files found.") Else, it returns the number of table rows.
    class func tableRowsWithLoadingTitle(titleKey: String, tableModel: NSArray, tableView: UITableView, completion: () -> Int) -> Int {
        
        let emptyTableLabel = UILabel.init(frame: CGRectMake(0, 0, tableView.bounds.size.height, tableView.bounds.size.width))
        var labelString: String = BunnyUtils.uncommentedLocalizedString(titleKey)
        var rows: Int = 0
        var separatorStyle = UITableViewCellSeparatorStyle.None
        var isTableScrollable = false
        
        if tableModel.count > 0 {
            labelString = ""
            separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            isTableScrollable = true
            
            rows = completion()
        }
        
        // Set empty table label
        emptyTableLabel.text = labelString
        emptyTableLabel.textAlignment = NSTextAlignment.Center
        emptyTableLabel.sizeToFit()
        emptyTableLabel.numberOfLines = 0
        emptyTableLabel.textColor = UIColor.lightGrayColor()
        
        // Add table label to table view's background view
        tableView.backgroundView = emptyTableLabel
        tableView.separatorStyle = separatorStyle
        tableView.scrollEnabled = isTableScrollable
        
        return rows
    }
    
    // This is used to preserve the value of an object which may be changed over the course of the code
    class func preserveValue(value: NSObject, completion: () -> Void) -> NSObject {
        let temporaryValue = value
        completion()
        return temporaryValue
    }
    
    // Prepares the textfield. Assumes that each text field has a maxLength, keyboardType, and textValue. Used whenever there is a text field. Returns true if the textfield has been successfully prepared. False, if otherwise.
    // TO-DO: I should be able to customize the Enter key. ("Done", "Continue", etc.)
    class func prepareTextField(
        textField: BunnyTextField,
        placeholderText: String,
        textColor: UIColor,
        model: BunnyCell
    ) -> Bool {
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: nil)
        textField.textColor = textColor
        
        guard let maxLength = model.cellSettings[Constants.AppKeys.keyMaxLength] else {
            return false
        }
        guard let keyboardType = model.cellSettings[Constants.AppKeys.keyKeyboardType] else {
            return false
        }
        guard let textValue = model.cellSettings[Constants.AppKeys.keyTextFieldValue] else {
            return false
        }
        
        var processedTextValue = textValue as! String
        if processedTextValue == "" {
            processedTextValue = textField.text!
        }
        textField.setKeyboardProperties(
            keyboardType as! Int,
            maxLength: maxLength as! Int,
            text: processedTextValue
        )
        return true
    }
    
    // Prepares a segmented control
    class func prepareSegmentedControl(
        segmentedControl: UISegmentedControl,
        model: BunnyCell
    ) {
        guard let rawArray = model.cellSettings[Constants.AppKeys.keySegmentedControlText] else {
            return
        }
        guard let tintColor = model.cellSettings[Constants.AppKeys.keyTint] else {
            return
        }
        let segmentedControlArray = rawArray as! NSArray
        segmentedControl.tintColor = tintColor as! UIColor
        for item in segmentedControlArray {
            segmentedControl.setTitle(item as? String, forSegmentAtIndex: segmentedControlArray.indexOfObject(item))
        }
    }
    
    // Prepares the button, returns true if the preparation is successful. False if otherwise.
    class func prepareButton(
        button: UIButton,
        text: String,
        model: BunnyCell,
        target: NSObject
    ) -> Bool {
        // Set the button's text.
        button.setTitle(text, forState: UIControlState.Normal)
        
        // Make it so that once a button is held, the user can't tap any other button.
        // If not, two buttons may be pressed AT THE SAME TIME.
        button.exclusiveTouch = true
        
        // The following three guards are mostly for me, the programmer.
        // Make sure that the button has a button color property.
        guard let buttonColor = model.cellSettings[Constants.AppKeys.keyButtonColor] else {
            return false
        }
        
        // Make sure that the button has an isEnabled property.
        guard let isButtonEnabled = model.cellSettings[Constants.AppKeys.keyEnabled] else {
            return false
        }
        
        // Make sure that the button has a selector once clicked.
        guard let selectorName = model.cellSettings[Constants.AppKeys.keySelector] else {
            return false
        }
        
        // Set the button color and the isEnabled
        button.tintColor = buttonColor as! UIColor
        button.enabled = isButtonEnabled as! Bool
        
        // Set the selelector action if the button is enabled.
        if button.enabled {
            button.addTarget(
                target,
                action: Selector(selectorName as! String),
                forControlEvents: UIControlEvents.TouchUpInside
            )
        }
        return true
    }
    
    // Given an identifier (e.g. "en_us"), retrieve its currency object
    class func getCurrencyObjectFromIdentifier(identifier: String) -> Currency {
        let currency = Currency()
        currency.setAttributes(identifier)
        return currency
    }
    
    class func getCurrencyObjectOfDefaultAccount() -> Currency {
        let activeRecord = ActiveRecord.init(tableName: ModelConstants.Entities.account)
        let currency = Currency()
        currency.setAttributes(NSLocale.currentLocale().localeIdentifier)
        
        let accountModel = AttributeModel(
            tableName: ModelConstants.Entities.account,
            key: ModelConstants.Account.isDefault,
            value: true
        )
        
        let group = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_async(group, queue) {
            // This runs in a separate thread.
            activeRecord.selectAllObjectsWithParameters([accountModel.format: accountModel.value]) { (fetchedObjects) in
                if fetchedObjects.count > 0 {
                    let defaultAccount = fetchedObjects[0] as! Account
                    currency.setAttributes(
                        defaultAccount.valueForKey(ModelConstants.Account.currency) as! String
                    )
                }
            }
        }

        // Wait for the thread to finish before returning
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        return currency
    }
    
    class func isDefaultAccountExisting() -> Bool {
        let activeRecord = ActiveRecord.init(tableName: ModelConstants.Entities.account)
        let accountModel = AttributeModel(
            tableName: ModelConstants.Entities.account,
            key: ModelConstants.Account.isDefault,
            value: true
        )
        
        var returnValue = false
        let group = dispatch_group_create()
        let queue = dispatch_queue_create("", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_group_async(group, queue) {
            // This runs in a separate thread.
            activeRecord.selectAllObjectsWithParameters([accountModel.format: accountModel.value]) { (fetchedObjects) in
                if fetchedObjects.count > 0 {
                    returnValue = true
                }
            }
        }
        
        // Wait for the thread to finish before returning
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
        return returnValue
        
    }
    
    // 200.0 + "en_us" = $200.00
    class func getFormattedAmount(input: Double, identifier: String) -> String {
        let inputString = String(format: "%.2f", input)
        let currency = BunnyUtils.getCurrencyObjectFromIdentifier(identifier)
        return "\(currency.currencySymbol) \(inputString)"
    }
    
    // Presents an alert with a text field, and the options OK and Cancel
    class func showTextFieldAlertWithCancelOK(
        titleKey: String,
        messageKey: String,
        placeholderKey: String,
        viewController: UIViewController,
        completion: (textField: UITextField) -> Void
    ) {
        // Set alert's title and message
        let alertController = UIAlertController(
            title: BunnyUtils.uncommentedLocalizedString(titleKey),
            message: BunnyUtils.uncommentedLocalizedString(messageKey),
            preferredStyle: UIAlertControllerStyle.Alert
        )
        
        // Cancel button
        alertController.addAction(
            UIAlertAction(
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_CANCEL),
                style:UIAlertActionStyle.Default,
                handler:nil
            )
        )
        
        // OK button
        alertController.addAction(
            UIAlertAction(
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_OK),
                style:UIAlertActionStyle.Default,
                handler: { (action) -> Void in
                    viewController.dismissKeyboard()
                    completion(textField: alertController.textFields![0])
                }
            )
        )
        
        // Set text field's placeholder text
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) in
            textField.placeholder = BunnyUtils.uncommentedLocalizedString(placeholderKey)
        }
        
        // Present the alert controller
        viewController.presentViewController(
            alertController,
            animated: true,
            completion: nil
        )
    }
    
    // Trims leading and trailing spaces of a string
    class func trimLeadingTrailingSpaces(inputString: String) -> String {
        return inputString.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
    }
    
    // Checks a string and saves it in the core data.
    class func saveSingleField(
        inputName: String,
        parentArray: [SingleElementCell],
        maxCount: Int,
        maxLength: Int,
        errorMaxLengthKey: String,
        errorMaxCountKey: String,
        errorEmptyNameKey: String,
        errorDuplicateNameKey: String,
        viewController: UIViewController,
        isRename: Bool,
        completion: (success: Bool, newItem: String) -> Void
    ) {
        // Trim the string
        let trimmedName = BunnyUtils.trimLeadingTrailingSpaces(inputName)
        
        // If we're renaming instead of inserting, 
        // we don't have to check for the number of elements in the parent array
        let parentCountCheck = isRename ? true : parentArray.count < maxCount
        
        // Make sure that the number of elements in the parent array is still alright.
        guard parentCountCheck else {
            BunnyUtils.showAlertWithOKButton(
                viewController,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: errorMaxCountKey
            )
            completion(success: false, newItem: "")
            return
        }
        
        // Make sure that the length of the string doesn't exceed a certain length
        guard trimmedName.characters.count <= maxLength else {
            BunnyUtils.showAlertWithOKButton(
                viewController,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: errorMaxLengthKey
            )
            completion(success: false, newItem: "")
            return
        }
        
        // Make sure that we're not inserting an empty string
        guard trimmedName != "" else {
            BunnyUtils.showAlertWithOKButton(
                viewController,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: errorEmptyNameKey
            )
            completion(success: false, newItem: "")
            return
        }
        
        // Check if name already exists
        let newCell = SingleElementCell(
            alphaElementTitleKey: trimmedName,
            cellIdentifier: Constants.CellIdentifiers.anyCellIdentifier,
            cellSettings: [:]
        )
        
        // Uniqueness validator
        let uniquenessValidator = SingleElementUniquenessValidator(
            objectToValidate: newCell,
            errorStringKey: errorDuplicateNameKey,
            parentArray: parentArray
        )
        
        let validator = Validator(viewController: viewController)
        validator.addValidator(uniquenessValidator)
        validator.validate { (success) in
            completion(success: success, newItem: trimmedName)
        }
    }
    
    // Presents a confirmation dialog to the user when they choose to delete something
    class func showDeleteDialog(
        vc: UIViewController,
        managedObject: NSManagedObject,
        deleteTitleKey: String,
        deleteMessegeKey: String,
        deleteActionKey: String,
        tableName: String,
        tableView: UITableView?,
        completion: () -> Void
    ) {
        let alertController = UIAlertController.init(
            title: BunnyUtils.uncommentedLocalizedString(deleteTitleKey),
            message: BunnyUtils.uncommentedLocalizedString(deleteMessegeKey),
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        // "Delete X"
        alertController.addAction(
            UIAlertAction.init(
                title: BunnyUtils.uncommentedLocalizedString(deleteActionKey),
                style: UIAlertActionStyle.Destructive,
                handler: { (UIAlertAction) in
                    // Delete from the core data
                    let activeRecord = ActiveRecord.init(tableName: tableName)
                    activeRecord.deleteObject(
                        managedObject,
                        completion: completion
                    )
                }
            )
        )
        
        // Cancel button
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
        
        if (tableView != nil) {
            // If any cell in the table is swiped left, then it will return to its normal position
            tableView?.setEditing(false, animated: true)
        }
    }
}
