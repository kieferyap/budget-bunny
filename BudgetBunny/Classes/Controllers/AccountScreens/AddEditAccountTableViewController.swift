//
//  AddEditAccountTableViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

let IDX_ACCOUNT_INFO_GROUP = 0
let IDX_NAME_CELL = 0
let IDX_CURRENCY_CELL = 1
let IDX_AMOUNT_CELL = 2

let IDX_ACCOUNT_DETAILS_GROUP = 1
let IDX_DEFAULT_CELL = 0

let DEFAULT_CELL_HEIGHT: CGFloat = 44.0
let ACCOUNT_CELL_HEIGHT: CGFloat = 60.0
let KEY_HEIGHT = "height"
let KEY_ANIMATED = "animated"
let KEY_IS_NUMPAD = "isKeyboardNumpad"
let KEY_MAX_LENGTH = "maxLength"

let SEPARATOR_COUNTRY_CODE = ": "
let SEPARATOR_CODE_SYMBOL = " ("
let SEPARATOR_SYMBOL = ")"

class AddEditAccountTableViewController: UITableViewController, UITextFieldDelegate {

    var addAccountTable:[[AddEditAccountCell]] = [[]]
    var selectedCountryIdentifier: String = ""
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = BunnyUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ADD_ACCOUNT)
        
        // Cell information
        self.selectedCountryIdentifier = NSLocale.currentLocale().localeIdentifier
        let nameCell = AddEditAccountCell(field: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_NAME),
                                    placeholder: BunnyUtils.uncommentedLocalizedString(StringConstants.TEXTFIELD_NAME_PLACEHOLDER),
                                 cellIdentifier: Constants.CellIdentifiers.AddAccountFieldValue,
                                   cellSettings: [KEY_MAX_LENGTH: 50])
        let currencyCell = AddEditAccountCell(field: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_CURRENCY),
                                        placeholder: self.getCurrencyStringWithIdentifier(),
                                     cellIdentifier: Constants.CellIdentifiers.AddAccountChevron,
                                       cellSettings: [KEY_ANIMATED: true])
        let initialAmountCell = AddEditAccountCell(field: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_STARTING_BALANCE),
                                             placeholder: BunnyUtils.uncommentedLocalizedString(StringConstants.TEXTFIELD_STARTING_BALANCE_PLACEHOLDER),
                                          cellIdentifier: Constants.CellIdentifiers.AddAccountFieldValue,
                                            cellSettings: [KEY_IS_NUMPAD: true])
        let defaultAccountCell = AddEditAccountCell(field: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_IS_DEFAULT_ACCOUNT),
                                                    placeholder: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_IS_DEFAULT_ACCOUNT_DESCRIPTION),
                                                    cellIdentifier: Constants.CellIdentifiers.AddAccountSwitch,
                                                    cellSettings: [KEY_HEIGHT:ACCOUNT_CELL_HEIGHT])
        
        // Information group
        self.addAccountTable.append([])
        self.addAccountTable[IDX_ACCOUNT_INFO_GROUP].insert(nameCell!, atIndex: IDX_NAME_CELL)
        self.addAccountTable[IDX_ACCOUNT_INFO_GROUP].insert(currencyCell!, atIndex: IDX_CURRENCY_CELL)
        self.addAccountTable[IDX_ACCOUNT_INFO_GROUP].insert(initialAmountCell!, atIndex: IDX_AMOUNT_CELL)
        
        // Account details group
        self.addAccountTable.append([])
        self.addAccountTable[IDX_ACCOUNT_DETAILS_GROUP].insert(defaultAccountCell!, atIndex: IDX_DEFAULT_CELL)
        
        // Keyboard must be dismissed when regions outside of it is tapped
        BunnyUtils.addKeyboardDismisserListener(self)
        
        // Done button
        self.doneButton.title = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DONE)
    }

    // TO-DO: Prevent duplication of this snippet of code
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getCurrencyStringWithIdentifier() -> String {
        let identifier = self.selectedCountryIdentifier
        
        let currency = Currency()
        currency.setAttributes(identifier)
        
        let currencyCountry = currency.country.stringByAppendingString(SEPARATOR_COUNTRY_CODE)
        let currencyCode = currency.currencyCode.stringByAppendingString(SEPARATOR_CODE_SYMBOL)
        let currencySymbol = currency.currencySymbol.stringByAppendingString(SEPARATOR_SYMBOL)
        let newCurrencyPlaceholder = currencyCountry.stringByAppendingString(currencyCode.stringByAppendingString(currencySymbol))
        
        return newCurrencyPlaceholder
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getTableViewCellValue(section: Int, row: Int) -> String {
        let indexPath = NSIndexPath.init(forRow: row, inSection: section)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! AddEditAccountTableViewCell
        return cell.getValue()
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        let accountName = self.getTableViewCellValue(IDX_ACCOUNT_INFO_GROUP, row: IDX_NAME_CELL)
        let accountCurrency = self.selectedCountryIdentifier
        let accountInitValue = self.getTableViewCellValue(IDX_ACCOUNT_INFO_GROUP, row: IDX_AMOUNT_CELL)
        let isDefaultAccount = self.getTableViewCellValue(IDX_ACCOUNT_DETAILS_GROUP, row: IDX_DEFAULT_CELL)
        
        let accountInitValueFloat = (accountInitValue as NSString).floatValue
        let isDefaultAccountBool = isDefaultAccount == "1" ? true : false
        
        // If at least one string is null, do not save
        if accountName == "" || accountInitValue == "" {
            let title = BunnyUtils.uncommentedLocalizedString(StringConstants.ERRORLABEL_ERROR_TITLE)
            let message = BunnyUtils.uncommentedLocalizedString(StringConstants.ERRORLABEL_NAME_CURRENCY_NOT_EMPTY)
            
            BunnyUtils.showAlertWithOKButton(self, title: title, message: message)
            return
        }
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let accountEntity = NSEntityDescription.entityForName("Account", inManagedObjectContext: managedContext)
        let accountModel = NSManagedObject(entity: accountEntity!, insertIntoManagedObjectContext: managedContext)
        
        let transactionEntity = NSEntityDescription.entityForName("Transaction", inManagedObjectContext: managedContext)
        let transactionModel = NSManagedObject(entity: transactionEntity!, insertIntoManagedObjectContext: managedContext)
        
        accountModel.setValue(accountName, forKey:"name")
        accountModel.setValue(accountCurrency, forKey:"currency")
        accountModel.setValue(isDefaultAccountBool, forKey:"isDefault")
        
        transactionModel.setValue(accountInitValueFloat, forKey: "amount")
        transactionModel.setValue(NSDate.init(), forKey: "datetime")
        transactionModel.setValue("", forKey: "notes")
        transactionModel.setValue(3, forKey: "type")
        transactionModel.setValue(accountModel, forKey: "accountId")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error occured while saving: \(error), \(error.userInfo)")
        }
        
        self.navigationController?.popViewControllerAnimated(true)
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
        
        var isAnimated = false
        if BunnyUtils.isKeyExistingForAddEditAccountCell(cell.model, key: KEY_ANIMATED) {
            isAnimated = true
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: isAnimated)
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
        if BunnyUtils.isKeyExistingForAddEditAccountCell(cellItem, key: KEY_HEIGHT) {
            let height: CGFloat? = CGFloat(cellItem.cellSettings[KEY_HEIGHT]!.floatValue)
            return height!
        }
        return DEFAULT_CELL_HEIGHT
    }
}

extension AddEditAccountTableViewController: PushViewControllerDelegate {
    func pushCurrencyViewController() {
        let storyboard = UIStoryboard(name: Constants.Storyboards.MainStoryboard, bundle: nil)
        let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(Constants.ViewControllers.CurrencyPickerTable)
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
        
        (self.addAccountTable[IDX_ACCOUNT_INFO_GROUP][IDX_CURRENCY_CELL] as AddEditAccountCell).setCellPlaceholder(currencyString)
        self.tableView.reloadData()
    }
}