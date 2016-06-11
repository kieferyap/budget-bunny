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
    var selectedCountryIdentifier: String = ""
    let searchController = UISearchController(searchResultsController: nil)
    let constants = ScreenConstants.Currency.self
    weak var delegate:AddEditAccountDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleLocalizationKey(StringConstants.MENULABEL_CURRENCY_PICKER)
        
        // Set the currency table
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let manager = CurrencyManager()
            manager.setCurrencyList()
            self.currencyTable = manager.currencyDictionary
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
            })
        }
        
        // Set the search controller
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        
        // Set the search bar
        self.searchController.searchBar.sizeToFit()
        self.searchController.searchBar.tintColor = Constants.Colors.darkGreen
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        
        BunnyUtils.addKeyboardDismisserListener(self)
    }
    
    // Remove the search bar, and pass the selected identifier through a delegate
    override func viewWillDisappear(animated: Bool) {
        self.searchController.view.removeFromSuperview()
        self.delegate?.setSelectedCurrencyIdentifier(self.selectedCountryIdentifier)
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return constants.sectionCount
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BunnyUtils.tableRowsWithLoadingTitle(
            StringConstants.GUIDELABEL_LOADING,
            tableModel: self.currencyTable,
            tableView: self.tableView
        ) { () -> Int in
            return self.isSearching ? self.filteredCurrencies.count : self.currencyTable.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellItem: Currency = self.currencyTable[indexPath.row] as! Currency
        let cellIdentifier: String = Constants.CellIdentifiers.addAccountCurrency
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CurrencyTableViewCell
        
        if self.isSearching {
            cellItem = self.filteredCurrencies[indexPath.row] as! Currency
        }
        
        cell.setCurrencyModel(cellItem, selectedCountryIdentifier: self.selectedCountryIdentifier)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CurrencyTableViewCell
        self.selectedCountryIdentifier = cell.model.identifier
        self.tableView.reloadData()
    }
    
    // MARK: - Search Results
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchKey: String = searchController.searchBar.text!
        self.isSearching = false
        
        if searchKey.characters.count > 0 {
            let searchParameters = constants.countrySearchParameter
                .stringByAppendingString(constants.codeSearchParameter)
                .stringByAppendingString(constants.symbolSearchParameter)
            
            let currencyPredicate = NSPredicate(format: searchParameters, searchKey, searchKey, searchKey)
            self.filteredCurrencies = self.currencyTable.filteredArrayUsingPredicate(currencyPredicate)
            self.isSearching = true
        }
        
        self.tableView.reloadData()
    }
}
