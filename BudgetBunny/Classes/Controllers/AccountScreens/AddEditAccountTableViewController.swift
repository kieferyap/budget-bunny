//
//  AddEditAccountTableViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class AddEditAccountTableViewController: UITableViewController, UITextFieldDelegate {

    var addAccountTable:[[AddEditAccountCell]] = [[]]
    var selectedCountryIdentifier: String = ""
    var accountInformation: AccountCell?
    let screenConstants = ScreenConstants.AddEditAccount.self
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleLocalizationKey(StringConstants.MENULABEL_ADD_ACCOUNT)
        
        var accountNameValue: String = ""
        var initialAmountValue: String = ""
        self.selectedCountryIdentifier = NSLocale.currentLocale().localeIdentifier
        self.addAccountTable = Array.init(count: 2, repeatedValue: [])
        
        switch self.sourceInformation {
        
        // If we are in editing mode, then we should set the textfields based on the account we are editing.
        case Constants.SourceInformation.accountEditing:
            if self.accountInformation != nil {
                accountNameValue = (self.accountInformation?.accountName)!
                initialAmountValue = (self.accountInformation?.amount)!.isInteger ? "%.0f" : "%.2f"
                self.selectedCountryIdentifier = NSLocale.currentLocale().localeIdentifier //TO-DO in ACC-0003
            }
            
            // In editing mode, the second section has two actions: Set as Default, and Delete Account
            let setDefaultAccountCell = AddEditAccountCell(
                fieldKey: StringConstants.BUTTON_SET_AS_DEFAULT,
                placeholder: "",
                cellIdentifier: Constants.CellIdentifiers.addAccountAction,
                cellSettings: [screenConstants.keySelector: screenConstants.selectorSetDefault])
            
            let deleteAccountCell = AddEditAccountCell(
                fieldKey: StringConstants.BUTTON_DELETE_ACCOUNT,
                placeholder: "",
                cellIdentifier: Constants.CellIdentifiers.addAccountAction,
                cellSettings: [screenConstants.keySelector: screenConstants.selectorDelete])
            
            self.addAccountTable[screenConstants.idxAccountActionsGroup]
                .insert(setDefaultAccountCell, atIndex: screenConstants.idxDefaultCell)
            self.addAccountTable[screenConstants.idxAccountActionsGroup]
                .insert(deleteAccountCell, atIndex: screenConstants.idxDeleteCell)
            
        // If we are trying to create a new account, however, all the textfields should remain blank
        case Constants.SourceInformation.accountNew:
            
            // In Add Account mode, the second section instead contains a Set Default switch
            let defaultAccountCell = AddEditAccountCell(
                fieldKey: StringConstants.LABEL_IS_DEFAULT_ACCOUNT,
                placeholder: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_IS_DEFAULT_ACCOUNT_DESCRIPTION),
                cellIdentifier: Constants.CellIdentifiers.addAccountSwitch,
                cellSettings: [screenConstants.keyHeight: screenConstants.accountCellHeight])
            
            self.addAccountTable[screenConstants.idxAccountActionsGroup].insert(defaultAccountCell, atIndex: screenConstants.idxDefaultCell)
        default:
            break
        }
        
        // Cell information
        let nameCell = AddEditAccountCell(
            fieldKey: StringConstants.LABEL_NAME,
            placeholder: BunnyUtils.uncommentedLocalizedString(StringConstants.TEXTFIELD_NAME_PLACEHOLDER),
            cellIdentifier: Constants.CellIdentifiers.addAccountFieldValue,
            cellSettings: [
                screenConstants.keyMaxLength: screenConstants.accountNameMaxLength,
                screenConstants.keyTextFieldValue: accountNameValue
            ]
        )
        let currencyCell = AddEditAccountCell(
            fieldKey: StringConstants.LABEL_CURRENCY,
            placeholder: self.getCurrencyStringWithIdentifier(),
            cellIdentifier: Constants.CellIdentifiers.addAccountChevron,
            cellSettings: [:]
        )
        let initialAmountCell = AddEditAccountCell(
            fieldKey: StringConstants.LABEL_STARTING_BALANCE,
            placeholder: BunnyUtils.uncommentedLocalizedString(StringConstants.TEXTFIELD_STARTING_BALANCE_PLACEHOLDER),
            cellIdentifier: Constants.CellIdentifiers.addAccountFieldValue,
            cellSettings: [
                screenConstants.keyIsNumpad: true,
                screenConstants.keyMaxLength: screenConstants.initialAmountMaxLength,
                screenConstants.keyTextFieldValue: initialAmountValue
            ]
        )
        
        // Information group
        self.addAccountTable[screenConstants.idxAccountInfoGroup].insert(nameCell, atIndex: screenConstants.idxNameCell)
        self.addAccountTable[screenConstants.idxAccountInfoGroup].insert(currencyCell, atIndex: screenConstants.idxCurrencyCell)
        self.addAccountTable[screenConstants.idxAccountInfoGroup].insert(initialAmountCell, atIndex: screenConstants.idxAmountCell)
        
        // Keyboard must be dismissed when regions outside of it is tapped
        BunnyUtils.addKeyboardDismisserListener(self)
        
        // Done button
        self.doneButton.title = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DONE)
    }
    
    // This method uses the currently selected currency identifier (en_US) to return its information (United States, USD, etc.)
    func getCurrencyStringWithIdentifier() -> String {
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
    func getTableViewCellValue(section: Int, row: Int) -> String {
        let indexPath = NSIndexPath.init(forRow: row, inSection: section)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! AddEditAccountTableViewCell
        return cell.getValue()
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        // Gather the input values
        let accountName = self.getTableViewCellValue(screenConstants.idxAccountInfoGroup, row: screenConstants.idxNameCell)
        let accountInitValue = self.getTableViewCellValue(screenConstants.idxAccountInfoGroup, row: screenConstants.idxAmountCell)
        var isDefaultAccountBool = false
        let accountInitValueFloat = (accountInitValue as NSString).doubleValue
        
        // If this is a new account, then we should get the isDefault table cell.
        // Edit mode does not have this cell, so. yeah.
        if self.sourceInformation == Constants.SourceInformation.accountNew {
            let isDefaultAccount = self.getTableViewCellValue(screenConstants.idxAccountActionsGroup, row: screenConstants.idxDefaultCell)
            isDefaultAccountBool = isDefaultAccount == "1" ? true : false
        }
        
        // Set up the error validators
        let accountNameModel = AttributeModel(tableName: "Account", format: "name == %@", value: accountName)
        let emptyAccountValidator = EmptyStringValidator(
                    objectToValidate: accountName,
                      errorStringKey:  StringConstants.ERRORLABEL_NAME_CURRENCY_NOT_EMPTY)
        let emptyCurrencyValidator = EmptyStringValidator(
                      objectToValidate: accountInitValue,
                        errorStringKey: StringConstants.ERRORLABEL_NAME_CURRENCY_NOT_EMPTY)
        let accountnameUniquenessValidator = AttributeUniquenessValidator(
                objectToValidate: accountNameModel,
                  errorStringKey: StringConstants.ERRORLABEL_DUPLICATE_ACCOUNT_NAME)
        
        // Add the error validators
        let validator = Validator()
        validator.addValidator(emptyAccountValidator)
        validator.addValidator(emptyCurrencyValidator)
        validator.addValidator(accountnameUniquenessValidator)
        
        // Validate the fields
        validator.validate { (errorMessage) in
            
            // If there is an error message, display it and don't do anything else.
            if errorMessage != "" {
                let title = BunnyUtils.uncommentedLocalizedString(StringConstants.ERRORLABEL_ERROR_TITLE)
                BunnyUtils.showAlertWithOKButton(self, title: title, message: errorMessage)
            }
                
            // If there are no errors, save the fields
            else {
                
                // Adding a new account
                let activeRecord = BunnyModel.init(tableName: "Account")
                
                // Set all isDefaults to false
                if isDefaultAccountBool {
                    BunnyUtils.setAllValues("Account", managedContext: activeRecord.managedContext, key: "isDefault", value: false)
                }
                
                // Set the values of the account and insert it
                var values = NSDictionary.init(
                    objects: [accountName, self.selectedCountryIdentifier, isDefaultAccountBool, accountInitValueFloat],
                    forKeys: ["name", "currency", "isDefault", "amount"]
                )
                let model = activeRecord.insertObject(values)
                
                // Add a new transaction and save
                activeRecord.changeTableName("Transaction")
                values = NSDictionary.init(
                    objects: [accountInitValueFloat, NSDate.init(), " ", ModelConstants.TransactionTypes.resetAmount, model],
                    forKeys: ["amount", "datetime", "notes", "type", "accountId"])
                activeRecord.insertObject(values)
                activeRecord.save()
                
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.addAccountTable.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addAccountTable[section].count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AddEditAccountTableViewCell
        cell.performAction()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: AddEditAccountCell = self.addAccountTable[indexPath.section][indexPath.row]
        let cellIdentifier: String = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AddEditAccountTableViewCell
        
        cell.setAccountModel(cellItem)
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

// Just a heads up: this assumes that the only type of screen to be pushed after the current screen is the
// currency selection view controller; which holds true, for now. TO-DO: Move to UIViewController+Bunnies?
extension AddEditAccountTableViewController: PushViewControllerDelegate {
    func pushCurrencyViewController() {
        let storyboard = UIStoryboard(name: Constants.Storyboards.mainStoryboard, bundle: nil)
        let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(Constants.ViewControllers.currencyPickerTable)
            as! CurrencyPickerTableViewController
        destinationViewController.delegate = self
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension AddEditAccountTableViewController: CurrencySelectionDelegate {
    func setSelectedCurrencyIdentifier(identifier: String) {
        if identifier != "" {
            self.selectedCountryIdentifier = identifier
        }
        let currencyString: String = self.getCurrencyStringWithIdentifier()

        (self.addAccountTable[screenConstants.idxAccountInfoGroup][screenConstants.idxCurrencyCell] as AddEditAccountCell).setCellPlaceholder(currencyString)
        self.tableView.reloadData()
    }
}