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
        self.loadData()
        self.tableView.reloadData()
    }
    
    func loadData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Account")
        var accounts = [NSManagedObject]()
        
        self.accountTable = []
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            accounts = results as! [NSManagedObject]
            
            for account in accounts {
                let isDefault: Bool = account.valueForKey("isDefault") as! Bool
                let currencyIdentifier: String = account.valueForKey("currency") as! String
                let accountName: String = account.valueForKey("name") as! String
                
                let currency = Currency()
                currency.setAttributes(currencyIdentifier)
                let currencySymbol = currency.currencySymbol.stringByAppendingString(" ")
                
                let amount: Double = account.valueForKey("amount") as! Double                
                let cellIdentifier = Constants.CellIdentifiers.Account
                let cellSettings = [:]
                
                let accountItem: AccountCell = AccountCell(accountObject: account, isDefault: isDefault, accountName: accountName, currencySymbol: currencySymbol, amount: amount, cellIdentifier: cellIdentifier, cellSettings: cellSettings)!

                self.accountTable.append(accountItem)
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
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
        let delete = UITableViewRowAction(style: .Destructive, title: deleteButtonTitle) { (action, indexPath) in
            
            let row = indexPath.row
            let account: AccountCell = self.accountTable[row]
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            
            managedContext.deleteObject(account.accountObject)
            self.accountTable.removeAtIndex(row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error occured while saving: \(error), \(error.userInfo)")
            }
            
            //TO-DO: Remove all transactions that are involved with the account
        }
        
        delete.backgroundColor = Constants.Colors.DangerColor
        
        return [delete]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return SECTION_COUNT
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.accountTable.count
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.sourceInformation = Constants.SourceInformation.AccountNew
        (segue.destinationViewController as! AddEditAccountTableViewController).accountInformation = nil
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
