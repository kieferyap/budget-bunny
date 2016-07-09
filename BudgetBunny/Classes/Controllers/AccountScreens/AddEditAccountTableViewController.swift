//
//  AddEditAccountTableViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

protocol AddEditAccountDelegate: class {
    func pushCurrencyViewController()
    func popViewController()
    func setAsDefault()
    func presentViewController(vc: UIViewController)
    func setSelectedCurrencyIdentifier(identifier: String)
}

class AddEditAccountTableViewController: UITableViewController {

    private var selectedCountryIdentifier: String = ""
    var accountInformation: AccountCell?
    private let screenConstants = ScreenConstants.AddEditAccount.self
    @IBOutlet weak private var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareModelData(screenConstants.sectionCount) { 
            var accountNameValue = ""
            var initialAmountValue = ""
            var isAccountDefault = false
            var buttonTitle = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DONE)
            var startingBalanceKey = StringConstants.LABEL_STARTING_BALANCE
            var titleKey = StringConstants.MENULABEL_ADD_ACCOUNT
            self.selectedCountryIdentifier = NSLocale.currentLocale().localeIdentifier
            
            switch self.sourceInformation {
                
            // If we are in editing mode, then we should set the textfields based on the account we are editing.
            case Constants.SourceInformation.accountEditing:
                
                var isKeyEnabled = true
                var defaultButtonText = StringConstants.BUTTON_SET_AS_DEFAULT
                var deleteButtonText = StringConstants.BUTTON_DELETE_ACCOUNT
                var accountObject: NSManagedObject!
                
                buttonTitle = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_SAVE)
                titleKey = StringConstants.MENULABEL_EDIT_ACCOUNT
                
                if self.accountInformation != nil {
                    let amountDouble: Double = (self.accountInformation?.amount)!
                    let floatFormat: String = amountDouble.isInteger ? "%.0f" : "%.2f"
                    
                    accountNameValue = (self.accountInformation?.alphaElementTitle)!
                    initialAmountValue = String.init(format: floatFormat, amountDouble)
                    isAccountDefault = (self.accountInformation?.isDefault)!
                    accountObject = (self.accountInformation?.accountObject)!
                    startingBalanceKey = StringConstants.LABEL_CURRENT_BALANCE
                    
                    self.selectedCountryIdentifier = (self.accountInformation?.currencyIdentifier)!
                }
                
                if isAccountDefault {
                    isKeyEnabled = false
                    defaultButtonText = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_SET_AS_DEFAULT_DISABLED)
                    deleteButtonText = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT_DISABLED)
                }
                
                self.appendCellAtSectionIndex(
                    self.screenConstants.idxAccountActionsSection,
                    idxRow: self.screenConstants.idxDefaultCell,
                    cellData: SingleElementCell(
                        alphaElementTitleKey: defaultButtonText,
                        cellIdentifier: Constants.CellIdentifiers.addAccountAction,
                        cellSettings: [
                            Constants.AppKeys.keySelector: self.screenConstants.selectorSetDefault,
                            Constants.AppKeys.keyEnabled: isKeyEnabled,
                            Constants.AppKeys.keyButtonColor: Constants.Colors.normalGreen,
                            self.screenConstants.keyManagedObject: accountObject
                        ]
                    )
                )
                
                self.appendCellAtSectionIndex(
                    self.screenConstants.idxAccountActionsSection,
                    idxRow: self.screenConstants.idxDeleteCell,
                    cellData: SingleElementCell(
                        alphaElementTitleKey: deleteButtonText,
                        cellIdentifier: Constants.CellIdentifiers.addAccountAction,
                        cellSettings: [
                            Constants.AppKeys.keySelector: self.screenConstants.selectorDelete,
                            Constants.AppKeys.keyEnabled: isKeyEnabled,
                            Constants.AppKeys.keyButtonColor: Constants.Colors.dangerColor,
                            self.screenConstants.keyManagedObject: accountObject
                        ]
                    )
                )
                
            // If we are trying to create a new account, however, all the textfields should remain blank
            case Constants.SourceInformation.accountNew:
                
                self.appendCellAtSectionIndex(
                    self.screenConstants.idxAccountActionsSection,
                    idxRow: self.screenConstants.idxDefaultCell,
                    cellData: TripleElementCell(
                        alphaElementTitleKey: StringConstants.LABEL_IS_DEFAULT_ACCOUNT,
                        betaElementTitleKey: StringConstants.LABEL_IS_DEFAULT_ACCOUNT_DESCRIPTION,
                        gammaElementTitleKey: self.screenConstants.falseString,
                        cellIdentifier: Constants.CellIdentifiers.addAccountSwitch,
                        cellSettings: [
                            self.screenConstants.keyHeight: self.screenConstants.accountCellHeight
                        ]
                    )
                )
                
            default:
                break
            }
            
            self.appendCellAtSectionIndex(
                self.screenConstants.idxAccountInfoSection,
                idxRow: self.screenConstants.idxNameCell,
                cellData: DoubleElementCell(
                    alphaElementTitleKey: StringConstants.LABEL_NAME,
                    betaElementTitleKey: StringConstants.TEXTFIELD_NAME_PLACEHOLDER,
                    cellIdentifier: Constants.CellIdentifiers.addAccountFieldValue,
                    cellSettings: [
                        Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                        Constants.AppKeys.keyMaxLength: self.screenConstants.accountNameMaxLength,
                        Constants.AppKeys.keyTextFieldValue: accountNameValue
                    ]
                )
            )
            
            self.appendCellAtSectionIndex(
                self.screenConstants.idxAccountInfoSection,
                idxRow: self.screenConstants.idxCurrencyCell,
                cellData: DoubleElementCell(
                    alphaElementTitleKey: StringConstants.LABEL_CURRENCY,
                    betaElementTitleKey: self.getCurrencyStringWithIdentifier(),
                    cellIdentifier: Constants.CellIdentifiers.addAccountChevron,
                    cellSettings: [:]
                )
            )
            
            self.appendCellAtSectionIndex(
                self.screenConstants.idxAccountInfoSection,
                idxRow: self.screenConstants.idxAmountCell,
                cellData: DoubleElementCell(
                    alphaElementTitleKey: startingBalanceKey,
                    betaElementTitleKey: StringConstants.TEXTFIELD_STARTING_BALANCE_PLACEHOLDER,
                    cellIdentifier: Constants.CellIdentifiers.addAccountFieldValue,
                    cellSettings: [
                        Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.decimal,
                        Constants.AppKeys.keyMaxLength: self.screenConstants.initialAmountMaxLength,
                        Constants.AppKeys.keyTextFieldValue: initialAmountValue
                    ]
                )
            )
            
            // Set navigation bar elements
            self.doneButton.title = buttonTitle
            self.setTitleLocalizationKey(titleKey)
        }
    }
    
    // This method uses the currently selected currency identifier (en_US) to return its information (United States, USD, etc.)
    private func getCurrencyStringWithIdentifier() -> String {
        let identifier = self.selectedCountryIdentifier
        
        let currency = Currency()
        currency.setAttributes(identifier)
        
        let currencyCountry = currency.country.stringByAppendingString(screenConstants.separatorCountryCode)
        let currencyCode = currency.currencyCode.stringByAppendingString(screenConstants.separatorCodeSymbol)
        let currencySymbol = currency.currencySymbol.stringByAppendingString(screenConstants.separatorSymbol)
        let newCurrencyPlaceholder = currencyCountry.stringByAppendingString(currencyCode.stringByAppendingString(currencySymbol))
        
        return newCurrencyPlaceholder
    }
    
    // Grabs the value for each cell (Account Name: "My Bank Account" --> "My Bank Account"), used for saving the data
    private func getTableViewCellValue(section: Int, row: Int) -> String {
        let indexPath = NSIndexPath.init(forRow: row, inSection: section)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! BunnyTableViewCell
        return cell.getValue()
    }
    
    @IBAction private func doneButtonPressed(sender: UIBarButtonItem) {
        
        // Gather the input values
        let accountName = self.getTableViewCellValue(screenConstants.idxAccountInfoSection, row: screenConstants.idxNameCell).stringByTrimmingCharactersInSet(
                NSCharacterSet.whitespaceAndNewlineCharacterSet()
        )
        
        let accountInitValue = self.getTableViewCellValue(screenConstants.idxAccountInfoSection, row: screenConstants.idxAmountCell)
        var isDefaultAccountBool = false
        let accountInitValueFloat = (accountInitValue as NSString).doubleValue
        var oldName = ""
        
        // If this is a new account, then we should get the isDefault table cell.
        // Edit mode does not have this cell.
        if self.sourceInformation == Constants.SourceInformation.accountNew {
            let isDefaultAccount = self.getTableViewCellValue(screenConstants.idxAccountActionsSection, row: screenConstants.idxDefaultCell)
            isDefaultAccountBool = isDefaultAccount == screenConstants.trueString ? true : false
        }
            
        // If we're editing, however, we should just preserve the current value for isDefaultAccount
        else {
            isDefaultAccountBool = (self.accountInformation?.isDefault)!
            oldName = (self.accountInformation?.alphaElementTitle)!
        }
        
        // Set up the error validators
        let accountNameModel = AttributeModel(
            tableName: ModelConstants.Entities.account,
            key: ModelConstants.Account.name,
            value: accountName
        )
        let emptyNameValidator = EmptyStringValidator(
            objectToValidate: accountName,
            errorStringKey:  StringConstants.ERRORLABEL_NAME_AMOUNT_NOT_EMPTY
        )
        let emptyAmountValidator = EmptyStringValidator(
            objectToValidate: accountInitValue,
            errorStringKey: StringConstants.ERRORLABEL_NAME_AMOUNT_NOT_EMPTY
        )
        let nameUniquenessValidator = AttributeUniquenessValidator(
            objectToValidate: accountNameModel,
            errorStringKey: StringConstants.ERRORLABEL_DUPLICATE_ACCOUNT_NAME,
            oldName: oldName
        )
        
        // Add the error validators
        let validator = Validator(viewController: self)
        validator.addValidator(emptyNameValidator)
        validator.addValidator(emptyAmountValidator)
        validator.addValidator(nameUniquenessValidator)
        
        // Validate the fields
        validator.validate { (success) in
            
            // If there are no errors, save the fields
            if success {
                // Adding a new account
                let activeRecord = BunnyModel.init(tableName: ModelConstants.Entities.account)
                
                // Set all isDefaults to false
                if isDefaultAccountBool {
                    activeRecord.updateAllValues(ModelConstants.Account.isDefault, value: false)
                }
                
                // Set the values of the account and insert it
                var values = NSDictionary.init(
                    objects: [
                        accountName,
                        self.selectedCountryIdentifier,
                        isDefaultAccountBool,
                        accountInitValueFloat
                    ],
                    forKeys: [
                        ModelConstants.Account.name,
                        ModelConstants.Account.currency,
                        ModelConstants.Account.isDefault,
                        ModelConstants.Account.amount
                    ]
                )
                
                // The active record should insert if the account is new, but update if it is being edited
                let model = self.sourceInformation == Constants.SourceInformation.accountNew ?
                    activeRecord.insertObject(values) :
                    activeRecord.updateObjectWithObjectId(
                        (self.accountInformation?.accountObject.objectID)!,
                        updateParameters: values
                    )
                
                // Add a new transaction and save
                activeRecord.changeTableName(ModelConstants.Entities.transaction)
                values = NSDictionary.init(
                    objects: [
                        accountInitValueFloat,
                        NSDate.init(),
                        " ",
                        ModelConstants.TransactionTypes.resetAmount,
                        model
                    ],
                    forKeys: [
                        ModelConstants.Transaction.amount,
                        ModelConstants.Transaction.datetime,
                        ModelConstants.Transaction.notes,
                        ModelConstants.Transaction.type,
                        ModelConstants.Transaction.accountId
                    ]
                )
                activeRecord.insertObject(values)
                activeRecord.save()
                
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.modelData.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelData[section].count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! BunnyTableViewCell
        cell.performAction()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: AddEditAccountCell = self.addAccountTable[indexPath.section][indexPath.row]
        let cellIdentifier: String = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AddEditAccountTableViewCell
        
        cell.setModelObject(cellItem)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellItem: AddEditAccountCell = self.addAccountTable[indexPath.section][indexPath.row]
        var cellHeight: CGFloat = CGFloat(screenConstants.defaultCellHeight)
        BunnyUtils.keyExistsForCellSettings(cellItem, key: screenConstants.keyHeight) { (object) in
            cellHeight = object as! CGFloat
        }
        return cellHeight
    }
}

extension AddEditAccountTableViewController: AddEditAccountDelegate {
    
    func pushCurrencyViewController() {
        let storyboard = UIStoryboard(name: Constants.Storyboards.mainStoryboard, bundle: nil)
        let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(Constants.ViewControllers.currencyPickerTable)
            as! CurrencyPickerTableViewController
        destinationViewController.delegate = self
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    func popViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    func setAsDefault() {
        let idxAccountActionsGroup = screenConstants.idxAccountActionsGroup
        let idxDefaultCell = screenConstants.idxDefaultCell
        let idxDeleteCell = screenConstants.idxDeleteCell
        let indexPathDefault = NSIndexPath.init(forRow: idxDefaultCell, inSection: idxAccountActionsGroup)
        let indexPathDelete = NSIndexPath.init(forRow: idxDeleteCell, inSection: idxAccountActionsGroup)
        
        self.accountInformation?.isDefault = true
        self.selectedCountryIdentifier = BunnyUtils.preserveValue(self.selectedCountryIdentifier) {
            self.viewDidLoad()
        } as! String
        self.tableView.reloadRowsAtIndexPaths(
            [indexPathDefault, indexPathDelete],
            withRowAnimation: UITableViewRowAnimation.Fade
        )
    }
    
    func presentViewController(vc: UIViewController) {
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func setSelectedCurrencyIdentifier(identifier: String) {
        if identifier != "" {
            self.selectedCountryIdentifier = identifier
        }
        let currencyString: String = self.getCurrencyStringWithIdentifier()
        let idxAccountInfoGroup = screenConstants.idxAccountInfoGroup
        let idxCurrencyCell = screenConstants.idxCurrencyCell
        let indexPath = NSIndexPath.init(forRow: idxCurrencyCell, inSection: idxAccountInfoGroup)
        
        (self.addAccountTable[idxAccountInfoGroup][idxCurrencyCell] as AddEditAccountCell)
            .setCellPlaceholder(currencyString)
        
        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
    }
}
