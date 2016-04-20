//
//  AddEditAccountTableViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

let IDX_ACCOUNT_INFO_GROUP = 0
let IDX_ACCOUNT_DETAILS_GROUP = 1
let DEFAULT_CELL_HEIGHT: CGFloat = 44.0
let KEY_HEIGHT = "height"
let KEY_ANIMATED = "animated"

class AddEditAccountTableViewController: UITableViewController {

    var addAccountTable:[[AddEditAccountCell]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Info Group
        let nameCell = AddEditAccountCell(field: "name",
                                    placeholder: "myWallet",
                                 cellIdentifier: Constants.CellIdentifiers.AddAccountFieldValue,
                                   cellSettings: [:])
        
        let currencyCell = AddEditAccountCell(field: "currency",
                                        placeholder: "dollar",
                                     cellIdentifier: Constants.CellIdentifiers.AddAccountChevron,
                                       cellSettings: [KEY_ANIMATED:true])
        
        let initialAmountCell = AddEditAccountCell(field: "initAmount",
                                             placeholder: "500",
                                          cellIdentifier: Constants.CellIdentifiers.AddAccountFieldValue,
                                            cellSettings: [:])
        
        self.addAccountTable.append([])
        self.addAccountTable[IDX_ACCOUNT_INFO_GROUP].append(nameCell)
        self.addAccountTable[IDX_ACCOUNT_INFO_GROUP].append(currencyCell)
        self.addAccountTable[IDX_ACCOUNT_INFO_GROUP].append(initialAmountCell)
        
        // Account details group
        let defaultAccountCell = AddEditAccountCell(field: "isDefaultAccount?",
            placeholder: "defaultAccountForTransactions",
            cellIdentifier: Constants.CellIdentifiers.AddAccountSwitch,
            cellSettings: [KEY_HEIGHT:60.0])
        
        self.addAccountTable.append([])
        self.addAccountTable[IDX_ACCOUNT_DETAILS_GROUP].append(defaultAccountCell)
        
        // Dismiss keyboard after tapping outside of it
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:"dismissKeyboard")
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isKeyExistingForAddEditAccountCell(cell: AddEditAccountCell, key: String) -> Bool {
        return cell.cellSettings[key] != nil
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
        if isKeyExistingForAddEditAccountCell(cell.model, key: KEY_ANIMATED) {
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
        if self.isKeyExistingForAddEditAccountCell(cellItem, key: KEY_HEIGHT) {
            let height: CGFloat? = CGFloat(cellItem.cellSettings[KEY_HEIGHT]!.floatValue)
            return height!
        }
        return DEFAULT_CELL_HEIGHT
    }

}

extension AddEditAccountTableViewController: PushViewControllerDelegate {
    func pushViewController(destinationViewController: UIViewController, isAnimated: Bool) {
        self.navigationController?.pushViewController(destinationViewController, animated: isAnimated)
    }
}