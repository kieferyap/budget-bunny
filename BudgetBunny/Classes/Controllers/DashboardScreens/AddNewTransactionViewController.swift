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
    private var selectedTransactionTypeIndex = ScreenConstants.AddTransaction.segmentedControlIdxExpense
    @IBOutlet weak var transactionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var transactionKindSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare the variables
        let titleKey = "Add New Transaction"

        self.transactionTableView.tintColor = self.tintColor
        self.prepareModelData(self.sectionCount) {
            
            switch self.selectedTransactionTypeIndex {
            case self.screenConstants.segmentedControlIdxExpense:
                self.tintColor = Constants.Colors.expenseColor
            case self.screenConstants.segmentedControlIdxIncome:
                self.tintColor = Constants.Colors.incomeColor
            case self.screenConstants.segmentedControlIdxTransfer:
                self.tintColor = Constants.Colors.darkGray
            default:
                break
            }
            
            self.transactionKindSegmentedControl.setTitle(
                BunnyUtils.uncommentedLocalizedString("New"),
                forSegmentAtIndex: self.screenConstants.segmentedControlIdxNew
            )
            self.transactionKindSegmentedControl.setTitle(
                BunnyUtils.uncommentedLocalizedString("Profile"),
                forSegmentAtIndex: self.screenConstants.segmentedControlIdxProfile
            )
            self.transactionKindSegmentedControl.setTitle(
                BunnyUtils.uncommentedLocalizedString("Recurring"),
                forSegmentAtIndex: self.screenConstants.segmentedControlIdxRecurring
            )
            
            // Transaction amount
            self.appendCellAtSectionIndex(
                self.screenConstants.idxTransactionInformation,
                idxRow: self.screenConstants.idxAmountCell,
                cellData: DoubleElementCell(
                    alphaElementTitleKey: "Amount ($)",
                    betaElementTitleKey: "150.25",
                    cellIdentifier: Constants.CellIdentifiers.transactionFieldValueTextField,
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
                cellData: DoubleElementCell(
                    alphaElementTitleKey: "Notes",
                    betaElementTitleKey: "Just some groceries",
                    cellIdentifier: Constants.CellIdentifiers.transactionFieldValueTextField,
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
            
            // Save transaction button
            self.appendCellAtSectionIndex(
                self.screenConstants.idxOtherActions,
                idxRow: self.screenConstants.idxSaveTransactionCell,
                cellData: SingleElementCell(
                    alphaElementTitleKey: "Save Transaction",
                    cellIdentifier: Constants.CellIdentifiers.transactionAction,
                    cellSettings: [
                        Constants.AppKeys.keySelector: self.screenConstants.selectorSaveTransaction,
                        Constants.AppKeys.keyEnabled: true,
                        Constants.AppKeys.keyButtonColor: Constants.Colors.normalGreen
                    ]
                )
            )
            
            // Save transaction and add as profile button
            self.appendCellAtSectionIndex(
                self.screenConstants.idxOtherActions,
                idxRow: self.screenConstants.idxSaveAddProfile,
                cellData: SingleElementCell(
                    alphaElementTitleKey: "Save and Add as Profile",
                    cellIdentifier: Constants.CellIdentifiers.transactionAction,
                    cellSettings: [
                        Constants.AppKeys.keySelector: self.screenConstants.selectorSaveAndAddAsProfile,
                        Constants.AppKeys.keyEnabled: true,
                        Constants.AppKeys.keyButtonColor: Constants.Colors.normalGreen
                    ]
                )
            )
            
            // Show More Details button
            self.appendCellAtSectionIndex(
                self.screenConstants.idxOtherActions,
                idxRow: self.screenConstants.idxShowMoreDetailsCell,
                cellData: SingleElementCell(
                    alphaElementTitleKey: "Show More Details",
                    cellIdentifier: Constants.CellIdentifiers.transactionAction,
                    cellSettings: [
                        Constants.AppKeys.keySelector: self.screenConstants.selectorShowMoreDetails,
                        Constants.AppKeys.keyEnabled: true,
                        Constants.AppKeys.keyButtonColor: Constants.Colors.normalGreen
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
        self.selectedTransactionTypeIndex = sender.selectedSegmentIndex
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
        case screenConstants.idxOtherActions:
            headerNameKey = "Transaction Actions"
        default:
            break
        }
        return BunnyUtils.uncommentedLocalizedString(headerNameKey)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

}
