//
//  AccountViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

let SECTION_COUNT = 1

class AccountsTableViewController: UITableViewController {
    
    var accountTable: [AccountCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = BunnyUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ACCOUNT)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
        self.tableView.reloadData()
    }
    
    func loadData() {
        self.accountTable = []
        
        let model = BunnyModel(tableName: "Account")
        model.selectAllObjects { (fetchedObjects) in
            for account in fetchedObjects {
                let isDefault: Bool = account.valueForKey("isDefault") as! Bool
                let currencyIdentifier: String = account.valueForKey("currency") as! String
                let accountName: String = account.valueForKey("name") as! String
                
                let currency = Currency()
                currency.setAttributes(currencyIdentifier)
                let currencySymbol = currency.currencySymbol.stringByAppendingString(" ")
                
                let amount: Double = account.valueForKey("amount") as! Double
                
                let accountItem: AccountCell = AccountCell(accountObject: account, isDefault: isDefault, accountName: accountName, currencySymbol: currencySymbol, amount: amount)
                
                self.accountTable.append(accountItem)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let deleteButtonTitle = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE)
        let setDefaultButtonTitle = "Set\nDefault"
        
        let row = indexPath.row
        let account: AccountCell = self.accountTable[row]
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let view = UITableViewRowAction(style: .Normal, title: "View") { (action, indexPath) in
            self.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        }
        
        var returnArray = [view]
        
        // If the account is not a default account
        if !account.isDefault {
            
            // Set the delete button
            let delete = UITableViewRowAction(style: .Destructive, title: deleteButtonTitle) { (action, indexPath) in
                
                let model = BunnyModel.init(tableName: "Account")
                model.deleteObject(account.accountObject, completion: {
                    self.accountTable.removeAtIndex(row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                })
                
                //TO-DO: Remove all transactions that are involved with the account
            }
            
            // Set the "Set Default" button
            let setDefault = UITableViewRowAction(style: .Default, title: setDefaultButtonTitle) { (action, indexPath) in
            
                let request = NSFetchRequest()
                var refreshingIndexPath: NSIndexPath!
                request.entity = NSEntityDescription.entityForName("Account", inManagedObjectContext: managedContext)
            
                do {
                    let objects = try managedContext.executeFetchRequest(request) as! [NSManagedObject]
                    for (index, element) in objects.enumerate() {
                        let object = element
                        if object == account.accountObject {
                            object.setValue(true, forKey: "isDefault")
                        }
                        else {
                            if object.valueForKey("isDefault") as! Bool == true {
                                refreshingIndexPath = NSIndexPath.init(forRow: index, inSection: 0)
                            }
                            object.setValue(false, forKey: "isDefault")
                        }
                    }
                    try managedContext.save()
                } catch let error as NSError {
                    print("Error: \(error)")
                }
            
                self.loadData()
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)
                
                if refreshingIndexPath != nil {
                    self.tableView.reloadRowsAtIndexPaths([refreshingIndexPath], withRowAnimation: UITableViewRowAnimation.None)
                }
            }
            
            delete.backgroundColor = Constants.Colors.DangerColor
            setDefault.backgroundColor = Constants.Colors.NormalGreen
            
            returnArray = [delete, setDefault]
        }
        
        return returnArray
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SECTION_COUNT
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BunnyUtils.tableRowsWithLoadingTitle(StringConstants.LABEL_NO_ACCOUNTS, tableModel: self.accountTable, tableView: self.tableView) { () -> Int in
            return self.accountTable.count
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: NSInteger) -> CGFloat {
        return CGFloat.min
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell: AccountCell = self.accountTable[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.Storyboards.MainStoryboard, bundle: nil)
        let destinationViewController = storyboard.instantiateViewControllerWithIdentifier(Constants.ViewControllers.AddEditTable)
            as! AddEditAccountTableViewController
        
        destinationViewController.sourceInformation = Constants.SourceInformation.AccountEditing
        destinationViewController.accountInformation = cell
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: AccountCell = self.accountTable[indexPath.row]
        let cellIdentifier: String = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AccountsTableViewCell
        
        cell.setAccountModel(cellItem)
        return cell
    }
    
    
    // MARK: - Navigation
    // Activated when + is tapped
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.sourceInformation = Constants.SourceInformation.AccountNew
        (segue.destinationViewController as! AddEditAccountTableViewController).accountInformation = nil
    }
 

}
