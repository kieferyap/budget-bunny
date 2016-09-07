//
//  BudgetViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/26/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

protocol BudgetDelegate: class {
    func presentNewIncomeAlert()
}

class BudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var budgetTableView: UITableView!
    @IBOutlet weak var addBudgetButton: UIBarButtonItem!
    private var budgetTable: [[BunnyCell]] = [[]]
    private var incomeList: [CategoryCell] = []
    private let screenConstants = ScreenConstants.Budget.self
    private var currentlySelectedObject: BunnyCell!
    private var amountDivider = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareModelData(screenConstants.sectionCount) {
            self.timeSegmentedControl.setTitle(
                BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_MONTHLY),
                forSegmentAtIndex: self.screenConstants.idxMonthly
            )
            self.timeSegmentedControl.setTitle(
                BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_WEEKLY),
                forSegmentAtIndex: self.screenConstants.idxWeekly
            )
            self.timeSegmentedControl.setTitle(
                BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_DAILY),
                forSegmentAtIndex: self.screenConstants.idxDaily
            )
            self.budgetTable = Array.init(
                count: self.screenConstants.sectionCount,
                repeatedValue: []
            )
            
            self.budgetTableView.delegate = self;
            self.budgetTableView.dataSource = self;
            self.budgetTableView.scrollEnabled = true;
            self.setTitleLocalizationKey(StringConstants.MENULABEL_BUDGETS)
        }
    }
  
    // Load the table data
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addBudgetButton.enabled = BunnyUtils.isDefaultAccountExisting()
        self.loadData()
        self.updateIncomeSection()
        self.budgetTableView.reloadData()
    }
    
    // Fetch from the core data, and append each element into the table
    private func loadData() {
        let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
        let defaultCurrencyIdentifier = defaultCurrency.identifier
        self.budgetTable[self.screenConstants.idxBudgetSection] = []
        
        let model = BunnyModel(tableName: ModelConstants.Entities.budget)
        model.selectAllObjects { (fetchedObjects) in
            for budget in fetchedObjects {
                let calculatedBudgetAmount =
                    (budget.valueForKey(ModelConstants.Budget.monthlyBudget) as! Double)/self.amountDivider
                
                //TO-DO: Change this once transactions has been implemented!
                let calculatedRemainingAmount =
                    (budget.valueForKey(ModelConstants.Budget.monthlyRemainingBudget) as! Double)/self.amountDivider
                
                let budgetItem: BudgetCell = BudgetCell(
                    budgetObject: budget,
                    budgetName: budget.valueForKey(ModelConstants.Budget.name) as! String,
                    budgetAmount: calculatedBudgetAmount,
                    remainingAmount: calculatedRemainingAmount,
                    currencyIdentifier: defaultCurrencyIdentifier
                )
                
                self.budgetTable[self.screenConstants.idxBudgetSection].append(budgetItem)
            }
        }
        
        let indexSet = NSIndexSet(index: self.screenConstants.idxBudgetSection)
        self.budgetTableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func updateIncomeSection() {
        let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
        
        // Fetch all the income categories
        let categoryModel = AttributeModel(
            tableName: ModelConstants.Entities.category,
            key: ModelConstants.Category.isIncome,
            value: true
        )
        
        self.budgetTable[self.screenConstants.idxIncomeSection] = []
        self.incomeList = []
        let model = BunnyModel(tableName: ModelConstants.Entities.category)
        model.selectAllObjectsWithParameters([categoryModel.format: categoryModel.value], completion: { (fetchedObjects) in
            for category in fetchedObjects {
                let amountDouble = category.valueForKey(ModelConstants.Category.monthlyAmount) as! Double
                let amountString = defaultCurrency.currencySymbol
                    .stringByAppendingString(" ")
                    .stringByAppendingString(String(format: "%.2f", amountDouble)
                )
                
                self.incomeList.append(
                    CategoryCell(
                        categoryObject: category,
                        alphaElementTitleKey: category.valueForKey(ModelConstants.Category.name) as! String,
                        betaElementTitleKey: amountString,
                        cellIdentifier: Constants.CellIdentifiers.budgetIncome,
                        cellSettings: [:]
                    )
                )
            }
        })
        
        let addNewIncome = SingleElementCell(
            alphaElementTitleKey: StringConstants.TEXTFIELD_NEW_INCOME,
            cellIdentifier: Constants.CellIdentifiers.addIncome,
            cellSettings: [
                Constants.AppKeys.keySelector: self.screenConstants.selectorAddNewIncome,
                Constants.AppKeys.keyEnabled: true,
                Constants.AppKeys.keyButtonColor: Constants.Colors.normalGreen
            ]
        )
        
        self.budgetTable[self.screenConstants.idxIncomeSection] = self.incomeList
        self.budgetTable[self.screenConstants.idxIncomeSection].append(addNewIncome)
        self.budgetTableView.reloadData()
    }
    
    func addNewIncome(incomeName: String) {
        BunnyUtils.saveSingleField(
            incomeName,
            parentArray: self.incomeList,
            maxCount: screenConstants.incomeMaxCount,
            errorMaxCountKey: StringConstants.ERRORLABEL_TOO_MANY_INCOME_CATEGORIES,
            errorEmptyNameKey: StringConstants.ERRORLABEL_INCOME_CATEGORY_NOT_EMPTY,
            errorDuplicateNameKey: StringConstants.ERRORLABEL_DUPLICATE_CATEGORY_NAME,
            viewController: self,
            isRename: false)
        { (success, newItem) in
            if success {
                self.dismissKeyboard()
                
                // Save the new income
                let activeRecord = BunnyModel.init(tableName: ModelConstants.Entities.category)
                
                // Set the values of the account and insert it
                let values = NSDictionary.init(
                    objects: [
                        newItem,
                        true,
                        0.0
                    ],
                    forKeys: [
                        ModelConstants.Category.name,
                        ModelConstants.Category.isIncome,
                        ModelConstants.Category.monthlyAmount
                    ]
                )
                
                activeRecord.insertObject(values)
                activeRecord.save()
                
                self.updateIncomeSection()
            }
        }
    }

    
    @IBAction func timeControlChanged(sender: UISegmentedControl) {
        let today = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let days = calendar.rangeOfUnit(.Day, inUnit: .Month, forDate: today)
        let weeks = calendar.rangeOfUnit(.WeekOfYear, inUnit: .Month, forDate: today)
        
        switch sender.selectedSegmentIndex {
        case self.screenConstants.idxWeekly:
            self.amountDivider = Double(weeks.length)
        case self.screenConstants.idxDaily:
            self.amountDivider = Double(days.length)
        default:
            self.amountDivider = 1.0
        }
        
        self.loadData()
    }
    
    private func displayIncomeCellActions() {
        let alertController = UIAlertController.init(
            title: "Category Actions",
            message: "Note that these actions may also be accessed by swiping the category to the left.",
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        let renameAction = UIAlertAction.init(
            title: "Rename",
            style: UIAlertActionStyle.Default,
            handler: { (UIAlertAction) in
                BudgetUtils.showRenameDialog(
                    self,
                    model: self.currentlySelectedObject,
                    incomeList: self.incomeList
                )
            }
        )
        
        let deleteAction = UIAlertAction.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE_ACCOUNT),
            style: UIAlertActionStyle.Destructive,
            handler: { (UIAlertAction) in
                BudgetUtils.showDeleteDialog(self, model: self.currentlySelectedObject)
            }
        )
        
        let cancelAction = UIAlertAction.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_CANCEL),
            style: UIAlertActionStyle.Cancel,
            handler: nil
        )
        
        alertController.addAction(renameAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    
    // Needed for the swipe functionality
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // Set the swipe buttons
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        var returnArray: [UITableViewRowAction] = []
        
        if indexPath.section == self.screenConstants.idxIncomeSection
            && indexPath.row != self.budgetTable[indexPath.section].count - 1
        {
            // Set the delete button
            let delete = UITableViewRowAction(
                style: UITableViewRowActionStyle.Destructive,
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE)
            ) { (action, indexPath) in
                BudgetUtils.showDeleteDialog(
                    self,
                    model: self.incomeList[indexPath.row]
                )
            }
            
            let rename = UITableViewRowAction(
                style: UITableViewRowActionStyle.Default,
                title: "Rename"
            ) { (action, indexPath) in
                BudgetUtils.showRenameDialog(
                    self,
                    model: self.incomeList[indexPath.row],
                    incomeList: self.incomeList
                )
            }
            
            delete.backgroundColor = Constants.Colors.dangerColor
            rename.backgroundColor = Constants.Colors.normalGreen
            
            returnArray = [delete, rename]
        }
        
        return returnArray
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return screenConstants.sectionCount
    }
    
    // Hey, wait a minute. Don't we have two sections for this?
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellCount = self.budgetTable[section].count
        if cellCount == 0 && section == screenConstants.idxBudgetSection {
            let inexistenceCell = SingleElementCell(
                alphaElementTitleKey: StringConstants.LABEL_NO_BUDGETS,
                cellIdentifier: Constants.CellIdentifiers.budgetInexistence,
                cellSettings: [:]
            )
            self.budgetTable[section].append(inexistenceCell)
        }
        
        return self.budgetTable[section].count
    }
    
    // On selection, set the values of the destination view controller and push it into the view controller stack
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.currentlySelectedObject = self.budgetTable[indexPath.section][indexPath.row]
        
        switch indexPath.section {
        case self.screenConstants.idxIncomeSection:
            // If it is not the last row
            if indexPath.row != self.budgetTable[indexPath.section].count - 1 {
                self.displayIncomeCellActions()
            }
            else {
                (tableView.cellForRowAtIndexPath(indexPath) as! BunnyTableViewCell).performAction()
            }
        case self.screenConstants.idxBudgetSection:
            // Something about transitioning to the next screen
            break
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // TO-DO: Header titles for ALL "Add"/"Edit" Screens
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: BunnyCell = self.budgetTable[indexPath.section][indexPath.row]
        let cellIdentifier = cellItem.cellIdentifier
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BunnyTableViewCellProtocol
        
        // Prepare the table view cell
        cell.prepareTableViewCell(cellItem)
        
        if cellIdentifier == Constants.CellIdentifiers.addIncome {
            (cell as! SingleElementTableViewCell).delegate = self
        }
        
        return cell as! UITableViewCell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerNameKey = ""
        switch section {
        case screenConstants.idxBudgetSection:
            headerNameKey = StringConstants.LABEL_HEADER_BUDGETS
        case screenConstants.idxIncomeSection:
            headerNameKey = StringConstants.LABEL_HEADER_INCOME
        default:
            break
        }
        return BunnyUtils.uncommentedLocalizedString(headerNameKey)
    }

    // MARK: - Navigation
    // Activated when + is tapped
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var frequencyKey = ""
        switch self.timeSegmentedControl.selectedSegmentIndex {
        case self.screenConstants.idxMonthly:
            frequencyKey = StringConstants.LABEL_MONTHLY_BUDGET
            break
        case self.screenConstants.idxWeekly:
            frequencyKey = StringConstants.LABEL_WEEKLY_BUDGET
            break
        case self.screenConstants.idxDaily:
            frequencyKey = StringConstants.LABEL_DAILY_BUDGET
            break
        default:
            break
        }

        self.prepareNextViewController(
            segue.destinationViewController,
            sourceInformation: -1 // Will be implemented in BUD-0003, I think.
        ) { (destinationViewController) in
            let vc = destinationViewController as! AddEditBudgetTableViewController
            vc.frequencyKey = frequencyKey
        }
    }
}

extension BudgetViewController: BudgetDelegate {

    func presentNewIncomeAlert() {
        if (self.incomeList.count == screenConstants.incomeMaxCount) {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: "Too many income categories. Please delete one to proceed."
            )
        }
        else {
            BunnyUtils.showTextFieldAlertWithCancelOK(
                "Add New Income Category",
                messageKey: "Add New Income Category Message",
                placeholderKey: "New Category Name",
                viewController: self
            ) { (textField) in
                self.addNewIncome(textField.text!)
            }
        }
    }

}