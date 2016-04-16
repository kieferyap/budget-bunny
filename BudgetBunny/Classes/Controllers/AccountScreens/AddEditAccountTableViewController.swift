//
//  AddEditAccountTableViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

let ACCOUNT_INFO_GROUP = 0
let ACCOUNT_DETAILS_GROUP = 1

class AddEditAccountTableViewController: UITableViewController {

    var addAccountTable:[[AddEditAccountCell]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameCell = AddEditAccountCell(key: "nameId", placeholder: "myWalletId", cellIdentifier: "addAccountFieldValueCell", cellSettings: [:])
        let currencyCell = AddEditAccountCell(key: "currencyId", placeholder: "dollarId", cellIdentifier: "addAccountChevronCell", cellSettings: [:])
        let initialAmountCell = AddEditAccountCell(key: "Currency", placeholder: "500id", cellIdentifier: "addAccountFieldValueCell", cellSettings: [:])
        let defaultAccountCell = AddEditAccountCell(key: "Currency", placeholder: "trueId", cellIdentifier: "addAccountSwitchCell", cellSettings: [:])
        
        addAccountTable.append([])
        addAccountTable.append([])
        
        addAccountTable[ACCOUNT_INFO_GROUP].append(nameCell)
        addAccountTable[ACCOUNT_INFO_GROUP].append(currencyCell)
        addAccountTable[ACCOUNT_INFO_GROUP].append(initialAmountCell)
        addAccountTable[ACCOUNT_DETAILS_GROUP].append(defaultAccountCell)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return addAccountTable.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addAccountTable[section].count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = addAccountTable[indexPath.section][indexPath.row].cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        // cell.frame.size.height = 120.0
        return cell
     }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     // Delete the row from the data source
     tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
     } else if editingStyle == .Insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}
