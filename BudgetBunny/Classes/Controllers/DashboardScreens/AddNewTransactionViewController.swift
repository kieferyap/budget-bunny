//
//  AddNewTransactionViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

protocol AddTransactionDelegate: class {
    func showMoreDetails()
    func toggleIsRecurring()
}

class AddNewTransactionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var sectionCount = ScreenConstants.AddTransaction.sectionCount
    private var screenConstants = ScreenConstants.AddTransaction.self
    private var tintColor = Constants.Colors.expenseColor
    private var selectedTransactionTypeIndex = ScreenConstants.AddTransaction.segmentedControlIdxExpense
    private var isRecurringTransaction = false
    private var isMoreDetailsShown = false
    @IBOutlet weak var transactionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var transactionTableView: UITableView!
    @IBOutlet weak var transactionKindSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare the variables
        let titleKey = "Add New Transaction"
        
        // Assumes that isMoreDetailsShown is false
        var showMoreTextKey = "Show More Details"
        var idxOtherActions = self.screenConstants.idxOtherActions
        
        // Change text if set to true
        if (self.isMoreDetailsShown) {
            showMoreTextKey = "Show Less Details"
            idxOtherActions = self.screenConstants.idxOtherActionsMore
            self.sectionCount = self.screenConstants.sectionCountMore
        }

        self.prepareModelData(self.sectionCount) {
            
            var transactionInfoCell: BunnyCell!
            
            switch self.selectedTransactionTypeIndex {
            case self.screenConstants.segmentedControlIdxExpense:
                self.tintColor = Constants.Colors.expenseColor
                transactionInfoCell = QuadrupleElementCell(
                    alphaElementTitleKey: "Budget name",
                    betaElementTitleKey: "Category name",
                    gammaElementTitleKey: "Food and Groceries",
                    deltaElementTitleKey: "Snacks",
                    cellIdentifier: Constants.CellIdentifiers.transactionDoubleFieldValue,
                    cellSettings: [
                        Constants.AppKeys.keyTint: self.tintColor,
                        Constants.AppKeys.keySelector: self.screenConstants.selectorTest,
                        Constants.AppKeys.keyHeight: self.screenConstants.doubleFieldValueCellHeight,
                        Constants.AppKeys.keyTableCellDisclosure: true
                    ]
                )
            case self.screenConstants.segmentedControlIdxIncome:
                self.tintColor = Constants.Colors.incomeColor
                transactionInfoCell = DoubleElementCell(
                    alphaElementTitleKey: "Income Category name",
                    betaElementTitleKey: "Salary",
                    cellIdentifier: Constants.CellIdentifiers.transactionFieldValue,
                    cellSettings: [
                        Constants.AppKeys.keyTint: self.tintColor,
                        Constants.AppKeys.keySelector: self.screenConstants.selectorTest,
                        Constants.AppKeys.keyTableCellDisclosure: true
                    ]
                )
            case self.screenConstants.segmentedControlIdxTransfer:
                self.tintColor = Constants.Colors.darkGray
                transactionInfoCell = QuadrupleElementCell(
                    alphaElementTitleKey: "Transfer from",
                    betaElementTitleKey: "Transfer to",
                    gammaElementTitleKey: "Bank Account",
                    deltaElementTitleKey: "My Wallet",
                    cellIdentifier: Constants.CellIdentifiers.transactionDoubleFieldValue,
                    cellSettings: [
                        Constants.AppKeys.keyTint: self.tintColor,
                        Constants.AppKeys.keySelector: self.screenConstants.selectorTest,
                        Constants.AppKeys.keyHeight: self.screenConstants.doubleFieldValueCellHeight,
                        Constants.AppKeys.keyTableCellDisclosure: true
                    ]
                )
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
            
            // Income/Expense/Transfer Section
            self.appendCellAtSectionIndex(
                self.screenConstants.idxTypeInformation,
                idxRow: self.screenConstants.idxTransactionInfoCell,
                cellData: transactionInfoCell
            )
            
            // Save transaction button
            self.appendCellAtSectionIndex(
                idxOtherActions,
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
                idxOtherActions,
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
                idxOtherActions,
                idxRow: self.screenConstants.idxShowMoreDetailsCell,
                cellData: SingleElementCell(
                    alphaElementTitleKey: showMoreTextKey,
                    cellIdentifier: Constants.CellIdentifiers.transactionAction,
                    cellSettings: [
                        Constants.AppKeys.keySelector: self.screenConstants.selectorShowMoreDetails,
                        Constants.AppKeys.keyEnabled: true,
                        Constants.AppKeys.keyButtonColor: Constants.Colors.normalGreen
                    ]
                )
            )
            
            if (self.isMoreDetailsShown) {
                
                let accountIdx = self.screenConstants.idxAccountCell
                var switchIdx = self.screenConstants.idxRecurringExpenseCell
                var recurringIdx = self.screenConstants.idxRepeatEveryCell
                let isTransfer = self.selectedTransactionTypeIndex == self.screenConstants.segmentedControlIdxTransfer
                let isRecurringString = self.isRecurringTransaction ? Constants.App.trueString : Constants.App.falseString
                
                if (isTransfer) {
                    switchIdx = self.screenConstants.idxRecurringExpenseCellTransfer
                    recurringIdx = self.screenConstants.idxRepeatEveryCellTransfer
                }
                
                // Account name. Don't display on Transfer
                else {
                    self.appendCellAtSectionIndex(
                        self.screenConstants.idxTransactionDetails,
                        idxRow: accountIdx,
                        cellData: DoubleElementCell(
                            alphaElementTitleKey: "Account",
                            betaElementTitleKey: "My Wallet",
                            cellIdentifier: Constants.CellIdentifiers.transactionFieldValue,
                            cellSettings: [
                                Constants.AppKeys.keyTint: self.tintColor,
                                Constants.AppKeys.keySelector: self.screenConstants.selectorTest,
                                Constants.AppKeys.keyTableCellDisclosure: true
                            ]
                        )
                    )
                }
                
                // Mark expense as a recurring expense
                self.appendCellAtSectionIndex(
                    self.screenConstants.idxTransactionDetails,
                    idxRow: switchIdx,
                    cellData: DoubleElementCell(
                        alphaElementTitleKey: "Recurring Expense",
                        betaElementTitleKey: isRecurringString,
                        cellIdentifier: Constants.CellIdentifiers.transactionSwitch,
                        cellSettings: [
                            Constants.AppKeys.keySelector: self.screenConstants.selectorToggleIsRecurring,
                            Constants.AppKeys.keyTint: self.tintColor,
                        ]
                    )
                )
                
                // Repeat every X. Do not display this cell if the UISwitch in Recurring Expenses is not turned on
                if (self.isRecurringTransaction) {
                    self.appendCellAtSectionIndex(
                        self.screenConstants.idxTransactionDetails,
                        idxRow: recurringIdx,
                        cellData: DoubleElementCell(
                            alphaElementTitleKey: "Repeat Every:",
                            betaElementTitleKey: "10th, 25th",
                            cellIdentifier: Constants.CellIdentifiers.transactionFieldValue,
                            cellSettings: [
                                Constants.AppKeys.keyTint: self.tintColor,
                                Constants.AppKeys.keySelector: self.screenConstants.selectorTest,
                                Constants.AppKeys.keyTableCellDisclosure: true
                            ]
                        )
                    )
                }
                
            }
            
            
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
        (cell as! BunnyTableViewCell).delegate = self
        
        return cell as! UITableViewCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cellItem: BunnyCell = self.modelData[indexPath.section][indexPath.row]
        var cellHeight: CGFloat = CGFloat(Constants.App.defaultCellHeight)
        BunnyUtils.keyExistsForCellSettings(cellItem, key: Constants.AppKeys.keyHeight) { (object) in
            cellHeight = object as! CGFloat
        }
        return cellHeight
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerNameKey = ""
        var idxOtherActions = self.screenConstants.idxOtherActions
        
        if (self.isMoreDetailsShown) {
            idxOtherActions = self.screenConstants.idxOtherActionsMore
        }
        
        switch section {
        case screenConstants.idxTransactionInformation:
            headerNameKey = "Transaction Information"
        case screenConstants.idxTypeInformation:
            switch self.selectedTransactionTypeIndex {
            case self.screenConstants.segmentedControlIdxExpense:
                headerNameKey = "Expense Information"
            case self.screenConstants.segmentedControlIdxIncome:
                headerNameKey = "Income Information"
            case self.screenConstants.segmentedControlIdxTransfer:
                headerNameKey = "Transfer Information"
            default:
                break
            }
        case idxOtherActions:
            headerNameKey = "Transaction Actions"
        case screenConstants.idxTransactionDetails:
            headerNameKey = "Transaction Details"
        default:
            break
        }
        return BunnyUtils.uncommentedLocalizedString(headerNameKey)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }

}

extension AddNewTransactionViewController: AddTransactionDelegate {
    func showMoreDetails() {
        self.isMoreDetailsShown = !self.isMoreDetailsShown
        self.viewDidLoad()
    }
    func toggleIsRecurring() {
        self.isRecurringTransaction = !self.isRecurringTransaction
        self.viewDidLoad()
    }
}
