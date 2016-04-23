//
//  CurrencyPickerTableViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class CurrencyPickerTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var currencyTable: NSArray = []
    var filteredCurrencies: NSArray = []
    var isSearching: Bool = false
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = CurrencyManager()
        manager.setCurrencyList()
        
        self.currencyTable = manager.currencyDictionary
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isSearching {
            return self.filteredCurrencies.count
        }
        return self.currencyTable.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellItem: Currency = self.currencyTable[indexPath.row] as! Currency
        if self.isSearching {
            cellItem = self.filteredCurrencies[indexPath.row] as! Currency
        }
        
        let cellIdentifier: String = Constants.CellIdentifiers.AddAccountCurrency
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CurrencyTableViewCell
        
        cell.setCurrencyModel(cellItem)
        return cell
    }
    
    // MARK: - Search Results
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchKey: String = searchController.searchBar.text!
        self.isSearching = false
        
        if searchKey.characters.count > 0 {
            let currencyPredicate = NSPredicate(format: "SELF.country CONTAINS[c] %@ OR SELF.currencyCode CONTAINS[c] %@ OR SELF.currencySymbol CONTAINS[c] %@", searchKey, searchKey, searchKey)
            self.filteredCurrencies = self.currencyTable.filteredArrayUsingPredicate(currencyPredicate)
            self.isSearching = true
        }
        
        self.tableView.reloadData()
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
