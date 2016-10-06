//
//  AddNewTransactionViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class AddNewTransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var sectionCount = ScreenConstants.AddTransaction.sectionCount
    private var screenConstants = ScreenConstants.AddTransaction.self
    private var tintColor = Constants.Colors.expenseColor
    @IBOutlet weak var transactionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var transactionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare the variables
        let titleKey = "Add New Transaction"

        self.transactionTableView.tintColor = self.tintColor
        self.prepareModelData(self.sectionCount) {
            
            // Transaction amount
            self.appendCellAtSectionIndex(
                self.screenConstants.idxTransactionInformation,
                idxRow: self.screenConstants.idxAmountCell,
                cellData: DoubleElementCell(
                    alphaElementTitleKey: "$",
                    betaElementTitleKey: "150.25",
                    cellIdentifier: Constants.CellIdentifiers.transactionAmount,
                    cellSettings: [
                        Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.decimal,
                        Constants.AppKeys.keyMaxLength: self.screenConstants.transactionAmountMaxCount,
                        Constants.AppKeys.keyTextFieldValue: "",
                        Constants.AppKeys.keyTextColor: self.tintColor
                    ]
                )
            )
            
            // Transaction name
            // TO-DO: randomized placeholder, which changes according to what the transaction type is
            self.appendCellAtSectionIndex(
                self.screenConstants.idxTransactionInformation,
                idxRow: self.screenConstants.idxNameCell,
                cellData: SingleElementCell(
                    alphaElementTitleKey: "Just some groceries",
                    cellIdentifier: Constants.CellIdentifiers.transactionNotes,
                    cellSettings: [
                        Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                        Constants.AppKeys.keyMaxLength: self.screenConstants.transactionNameMaxCount,
                        Constants.AppKeys.keyTextFieldValue: "",
                        Constants.AppKeys.keyTextColor: self.tintColor
                    ]
                )
            )
            
            // Transaction type segmented control
            self.appendCellAtSectionIndex(
                self.screenConstants.idxTransactionInformation,
                idxRow: self.screenConstants.idxTypeSegmentControlCell,
                cellData: SingleElementCell(
                    alphaElementTitleKey: "",
                    cellIdentifier: Constants.CellIdentifiers.transactionType,
                    cellSettings: [
                        Constants.AppKeys.keySegmentedControlText: [
                            "Expense",
                            "Income",
                            "Transfer"
                        ],
                        Constants.AppKeys.keyTint: self.tintColor
                    ]
                )
            )
        }
        
        // Do any additional setup after loading the view.
        self.transactionTableView.delegate = self;
        self.transactionTableView.dataSource = self;
        self.transactionTableView.scrollEnabled = true;
        self.setTitleLocalizationKey(titleKey)
        self.transactionTableView.reloadData()
    }

    @IBAction func transactionTypeChanged(sender: AnyObject) {
        switch sender.selectedSegmentIndex {
        case screenConstants.segmentedControlIdxExpense:
            self.tintColor = Constants.Colors.expenseColor
        case screenConstants.segmentedControlIdxIncome:
            self.tintColor = Constants.Colors.incomeColor
        case screenConstants.segmentedControlIdxTransfer:
            self.tintColor = Constants.Colors.darkGray
        default:
            break
        }
        self.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionCount
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelData[section].count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! BunnyTableViewCell
        
        cell.performAction()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: BunnyCell = self.modelData[indexPath.section][indexPath.row]
        let cellIdentifier: String = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BunnyTableViewCellProtocol
        
        cell.prepareTableViewCell(cellItem)
        
        return cell as! UITableViewCell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerNameKey = ""
        switch section {
        case screenConstants.idxTransactionInformation:
            headerNameKey = "Transaction Information"
        default:
            break
        }
        return BunnyUtils.uncommentedLocalizedString(headerNameKey)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

}
