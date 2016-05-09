//
//  CurrencyPickerTableViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

let TABLE_VIEW_SECTIONS = 1
let COUNTRY_SEARCH_PARAMETER = "SELF.country CONTAINS[c] %@ OR "
let CODE_SEARCH_PARAMETER = "SELF.currencyCode CONTAINS[c] %@ OR "
let SYMBOL_SEARCH_PARAMETER = "SELF.currencySymbol CONTAINS[c] %@"

protocol CurrencySelectionDelegate: class {
    func setSelectedCurrencyIdentifier(identifier: String)
}

class CurrencyPickerTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var currencyTable: NSArray = []
    var filteredCurrencies: NSArray = []
    var isSearching: Bool = false
    var selectedCountryIdentifier: String = ""
    let searchController = UISearchController(searchResultsController: nil)
    weak var delegate:CurrencySelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = BunnyUtils.uncommentedLocalizedString(StringConstants.MENULABEL_CURRENCY_PICKER)
        
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
        self.searchController.searchBar.tintColor = Constants.Colors.DarkGreen
        definesPresentationContext = true
        self.tableView.tableHeaderView = searchController.searchBar
        
        BunnyUtils.addKeyboardDismisserListener(self)
    }

    func dismissKeyboard() {
        view.endEditing(true)
        // self.searchController.active = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.searchController.view.removeFromSuperview()
        self.delegate?.setSelectedCurrencyIdentifier(self.selectedCountryIdentifier)
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TABLE_VIEW_SECTIONS
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let emptyTableLabel = UILabel.init(frame: CGRectMake(0, 0, self.tableView.bounds.size.height, self.tableView.bounds.size.width))
        var labelString: String = BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_LOADING)
        var rows: Int = 0
        var separatorStyle = UITableViewCellSeparatorStyle.None
        var isTableScrollable = false
        
        if self.currencyTable.count > 0 {
            labelString = ""
            separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            isTableScrollable = true
            
            if self.isSearching {
                rows = self.filteredCurrencies.count
            }
            else {
                rows = self.currencyTable.count
            }
        }
        
        // Set empty table label
        emptyTableLabel.text = labelString
        emptyTableLabel.textAlignment = NSTextAlignment.Center
        emptyTableLabel.sizeToFit()
        emptyTableLabel.textColor = Constants.Colors.NormalGreen
        
        // Add table label to table view's background view
        self.tableView.backgroundView = emptyTableLabel
        self.tableView.separatorStyle = separatorStyle
        self.tableView.scrollEnabled = isTableScrollable
        
        return rows
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellItem: Currency = self.currencyTable[indexPath.row] as! Currency
        let cellIdentifier: String = Constants.CellIdentifiers.AddAccountCurrency
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
            let searchParameters = COUNTRY_SEARCH_PARAMETER
                .stringByAppendingString(CODE_SEARCH_PARAMETER)
                .stringByAppendingString(SYMBOL_SEARCH_PARAMETER)
            
            let currencyPredicate = NSPredicate(format: searchParameters, searchKey, searchKey, searchKey)
            self.filteredCurrencies = self.currencyTable.filteredArrayUsingPredicate(currencyPredicate)
            self.isSearching = true
        }
        
        self.tableView.reloadData()
    }
}
