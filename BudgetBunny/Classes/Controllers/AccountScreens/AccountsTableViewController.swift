//
//  AccountViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class AccountsTableViewController: UITableViewController {
    
    private var accountTable: [AccountCell] = []
    private let constants = ScreenConstants.Account.self
    private var isAccountCountMax = false
    
    // Set the title in the navigation bar
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleLocalizationKey(StringConstants.MENULABEL_ACCOUNT)
    }
    
    // Load the table data
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
        self.tableView.reloadData()
    }
    
    // Fetch from the core data, and append each element into the table
    private func loadData() {
        self.accountTable = []
        
        let model = ActiveRecord(tableName: ModelConstants.Entities.account)
        model.selectAllObjects { (fetchedObjects) in
            for account in fetchedObjects {
                
                // Set account cell
                let accountItem: AccountCell = AccountCell(
                    accountObject: account,
                    isDefault: account.valueForKey(ModelConstants.Account.isDefault) as! Bool,
                    accountName: account.valueForKey(ModelConstants.Account.name) as! String,
                    currencyIdentifier: account.valueForKey(ModelConstants.Account.currency) as! String,
                    amount: account.valueForKey(ModelConstants.Account.amount) as! Double
                )
                
                self.accountTable.append(accountItem)
            }
        }
    }
    
    // MARK: - Table view data source
    
    // Needed for the swipe functionality
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // Set the swipe buttons
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteButtonTitle = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE)
        let setDefaultButtonTitle = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_SET_DEFAULT)
        let viewTitle = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_EDIT)
        
        let row = indexPath.row
        
        guard row >= 0 && row < self.accountTable.count else {
            print("This guard exists because an index out of range error literally happened to me ONCE. The row was -1 for some reason. I can't replicate it anymore. TTwTT")
            return []
        }
        
        let account: AccountCell = self.accountTable[row]
        var returnArray: [UITableViewRowAction]
        
        // If the account is not a default account
        if !account.isDefault {
            
            // Set the delete button
            let delete = UITableViewRowAction(style: .Destructive, title: deleteButtonTitle) { (action, indexPath) in
                BunnyUtils.showDeleteDialog(
                    self,
                    managedObject: account.accountObject,
                    deleteTitleKey: StringConstants.LABEL_WARNING_DELETE_ACCOUNT_TITLE,
                    deleteMessegeKey: StringConstants.LABEL_WARNING_DELETE_ACCOUNT_MESSAGE,
                    deleteActionKey: StringConstants.BUTTON_DELETE_ACCOUNT,
                    tableName: ModelConstants.Entities.account,
                    tableView: self.tableView,
                    completion: {
                        self.accountTable.removeAtIndex(row)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    }
                    // TO-DO: Remove all transactions that are involved with the account
                )
                
            }
            
            // Set the "Set Default" button
            let setDefault = UITableViewRowAction(style: .Default, title: setDefaultButtonTitle) { (action, indexPath) in
            
                var refreshingIndexPath: NSIndexPath!
                let model = ActiveRecord.init(tableName: ModelConstants.Entities.account)
                
                // TO-DO: Reset all budgets when the default account has been reset IF the currency is different than the original.
                
                model.selectAllObjects({ (fetchedObjects) -> Void in
                    // For each element
                    for (index, element) in fetchedObjects.enumerate() {
                        let object = element
                        
                        // If the element is the currently selected element, set isDefault to true.
                        if object == account.accountObject {
                            object.setValue(true, forKey: ModelConstants.Account.isDefault)
                        }
                            
                        // Else, if the element is the previously default account, set isDefault to false.
                        else if object.valueForKey(ModelConstants.Account.isDefault) as! Bool == true {
                            refreshingIndexPath = NSIndexPath.init(forRow: index, inSection: ScreenConstants.Account.idxAccountSection)
                            object.setValue(false, forKey: ModelConstants.Account.isDefault)
                        }
                    }
                    
                    // Save the model, reload the data, etc.
                    model.save()
                    self.loadData()
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                    
                    if refreshingIndexPath != nil {
                        self.tableView.reloadRowsAtIndexPaths([refreshingIndexPath], withRowAnimation: UITableViewRowAnimation.Fade) // For some reason, the animation is still not what I'd expect of a "None."
                    }
                })
            }
            
            delete.backgroundColor = Constants.Colors.dangerColor
            setDefault.backgroundColor = Constants.Colors.normalGreen
            
            returnArray = [delete, setDefault]
        }
        
        // If the account is a default account
        else {
            let view = UITableViewRowAction(style: .Normal, title: viewTitle) { (action, indexPath) in
                self.tableView(tableView, didSelectRowAtIndexPath: indexPath)
            }
            
            returnArray = [view]
        }
        
        return returnArray
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return constants.sectionCount
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BunnyUtils.tableRowsWithLoadingTitle(
            StringConstants.GUIDELABEL_NO_ACCOUNTS,
            tableModel: self.accountTable,
            tableView: self.tableView
        ) { () -> Int in
            return self.accountTable.count
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: NSInteger) -> CGFloat {
        return CGFloat.min
    }

    // On selection, set the values of the destination view controller and push it into the view controller stack
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell: AccountCell = self.accountTable[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.Storyboards.mainStoryboard, bundle: nil)
        var vc: AddEditAccountTableViewController!
        
        let newNavigationController = storyboard.instantiateViewControllerWithIdentifier(Constants.ViewControllers.addAccountNavigation) as! UINavigationController
        let topViewController = newNavigationController.topViewController
        
        self.prepareNextViewController(
            topViewController!,
            sourceInformation: Constants.SourceInformation.accountEditing
        ) { (destinationViewController) in
            vc = destinationViewController as! AddEditAccountTableViewController
            vc.accountInformation = cell
        }
        
        self.presentViewController(newNavigationController, animated: true) {}
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: AccountCell = self.accountTable[indexPath.row]
        let cellIdentifier: String = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AccountsTableViewCell
        
        cell.prepareTableViewCell(cellItem)
        return cell
    }
    
    
    // MARK: - Navigation
    // Activated when + is tapped
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard self.accountTable.count < ScreenConstants.Account.accountMaxCount else {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: StringConstants.ERRORLABEL_TOO_MANY_ACCOUNTS
            )
            return
        }
        
        let newNavigationController = segue.destinationViewController as! UINavigationController
        let topViewController = newNavigationController.topViewController
        
        self.prepareNextViewController(
            topViewController!,
            sourceInformation: Constants.SourceInformation.accountNew
        ) { (destinationViewController) in
            let vc = destinationViewController as! AddEditAccountTableViewController
            vc.accountInformation = nil
        }
    }
 
}
