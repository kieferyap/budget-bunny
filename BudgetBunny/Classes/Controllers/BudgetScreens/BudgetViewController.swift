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
    private var incomeList: [IncomeCategoryCell] = []
    private let screenConstants = ScreenConstants.Budget.self
    private var currentlySelectedObject: BunnyCell!
    private var amountDivider: Double = 1.0
    
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
        
        // Load the budget and income category data
        self.loadData()
        self.updateIncomeSection()
        
        // Reload the table view
        self.budgetTableView.reloadData()
    }
    
    // Fetch all budgets from the core data, and append each element into the table
    private func loadData() {
        let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
        let defaultCurrencyIdentifier = defaultCurrency.identifier
        self.budgetTable[self.screenConstants.idxBudgetSection] = []
        
        let model = ActiveRecord(tableName: ModelConstants.Entities.budget)
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
    
    // Fetch all income categories from the core data, and append each element into the table
    private func updateIncomeSection() {
        let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
        
        // "SELECT * FROM categories WHERE isIncome = true;"
        let categoryModel = AttributeModel(
            tableName: ModelConstants.Entities.category,
            key: ModelConstants.Category.isIncome,
            value: true
        )
        
        // Reset the core data
        self.budgetTable[self.screenConstants.idxIncomeSection] = []
        self.incomeList = []
        let model = ActiveRecord(tableName: ModelConstants.Entities.category)
        model.selectAllObjectsWithParameters([categoryModel.format: categoryModel.value], completion: { (fetchedObjects) in
            for category in fetchedObjects {
                // Format the amount
                let amountDouble = category.valueForKey(ModelConstants.Category.monthlyAmount) as! Double
                let amountString = defaultCurrency.currencySymbol
                    .stringByAppendingString(" ")
                    .stringByAppendingString(String(format: "%.2f", amountDouble)
                )
                
                // Append to table
                self.incomeList.append(
                    IncomeCategoryCell(
                        categoryObject: category,
                        alphaElementTitleKey: category.valueForKey(ModelConstants.Category.name) as! String,
                        betaElementTitleKey: amountString,
                        cellIdentifier: Constants.CellIdentifiers.incomeCategory,
                        cellSettings: [:]
                    )
                )
            }
        })
        
        // "Add New Income" button
        let addNewIncome = SingleElementCell(
            alphaElementTitleKey: StringConstants.TEXTFIELD_NEW_INCOME,
            cellIdentifier: Constants.CellIdentifiers.addIncomeCategory,
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
    
    // Save the new income and refresh the table
    private func addNewIncome(incomeName: String) {
        BunnyUtils.saveSingleField(
            incomeName,
            parentArray: self.incomeList,
            maxCount: screenConstants.incomeMaxCount,
            maxLength: ScreenConstants.Budget.incomeNameMaxLength,
            errorMaxLengthKey: StringConstants.ERRORLABEL_INCOME_CATEGORY_NAME_TOO_LONG,
            errorMaxCountKey: StringConstants.ERRORLABEL_TOO_MANY_INCOME_CATEGORIES,
            errorEmptyNameKey: StringConstants.ERRORLABEL_INCOME_CATEGORY_NOT_EMPTY,
            errorDuplicateNameKey: StringConstants.ERRORLABEL_DUPLICATE_CATEGORY_NAME,
            viewController: self,
            isRename: false)
        { (success, newItem) in
            
            // TO-DO: Sort the income alphabetically
            if success {
                self.dismissKeyboard()
                
                // Save the new income
                let activeRecord = ActiveRecord.init(tableName: ModelConstants.Entities.category)
                
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

    // Changes the budget and income amounts based on the time control
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
    
    // When a category cell is tapped, the user is presented with options to rename or delete it.
    private func displayIncomeCellActions() {
        BudgetUtils.displayCategoryCellActions(
            self,
            tableView: self.budgetTableView,
            renameCompletion: {
                BudgetUtils.showRenameDialog(
                    self,
                    tableView: self.budgetTableView,
                    completion: { (textField) in
                        BudgetUtils.saveIncomeCategoryTextField(
                            textField,
                            model: self.currentlySelectedObject,
                            incomeList: self.incomeList,
                            vc: self,
                            completion: {
                                self.updateIncomeSection()
                            }
                        )
                    }
                )
            },
            deleteCompletion: {
                BunnyUtils.showDeleteDialog(
                    self,
                    managedObject: (self.currentlySelectedObject as! IncomeCategoryCell).categoryObject,
                    deleteTitleKey: StringConstants.LABEL_DELETE_CATEGORY_TITLE,
                    deleteMessegeKey: StringConstants.LABEL_DELETE_INCOME_CATEGORY_MESSAGE,
                    deleteActionKey: StringConstants.BUTTON_DELETE_INCOME_CATEGORY,
                    tableName: ModelConstants.Entities.category,
                    tableView: self.budgetTableView,
                    completion: {
                        self.updateIncomeSection()
                    }
                )
            },
            titleKey: StringConstants.LABEL_INCOME_CATEGORY_ACTIONS
        )
    }
    
    private func getFrequencyKey() -> String {
        switch self.timeSegmentedControl.selectedSegmentIndex {
        case self.screenConstants.idxMonthly:
            return StringConstants.LABEL_MONTHLY_BUDGET
        case self.screenConstants.idxWeekly:
            return StringConstants.LABEL_WEEKLY_BUDGET
        case self.screenConstants.idxDaily:
            return StringConstants.LABEL_DAILY_BUDGET
        default:
            return ""
        }
    }
    
    // MARK: - Table view data source
    
    // Needed for the swipe functionality.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // All budget rows are swipable. All categories, except the last row, is swipable.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch (indexPath.section) {
            case self.screenConstants.idxBudgetSection:
                return true
            case self.screenConstants.idxIncomeSection:
                // Return true if it's not the last row. False if otherwise.
                return indexPath.row != self.budgetTable[indexPath.section].count - 1 ? true: false
            default:
                return false
        }
    }
    
    // Budget cells show the Delete button when swiped left. Category cells show the Delete and Rename buttons.
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        var returnArray: [UITableViewRowAction] = []
        
        switch (indexPath.section) {
            
        // Budget cells
        case self.screenConstants.idxBudgetSection:
            
            // Set the delete button
            let delete = UITableViewRowAction(
                style: UITableViewRowActionStyle.Destructive,
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE)
            ) { (action, indexPath) in
                BunnyUtils.showDeleteDialog(
                    self,
                    managedObject: (self.budgetTable[indexPath.section][indexPath.row] as! BudgetCell).budgetObject,
                    deleteTitleKey: StringConstants.LABEL_DELETE_BUDGET_TITLE,
                    deleteMessegeKey: StringConstants.LABEL_DELETE_BUDGET_MESSAGE,
                    deleteActionKey: StringConstants.BUTTON_DELETE_BUDGET,
                    tableName: ModelConstants.Entities.budget,
                    tableView: self.budgetTableView,
                    completion: {
                        self.loadData()
                    }
                )
            }
            delete.backgroundColor = Constants.Colors.dangerColor
            returnArray = [delete]
            
        // Income category cells
        case self.screenConstants.idxIncomeSection:
            
            // If it's not the last row, show the delete and rename buttons
            if indexPath.row != self.budgetTable[indexPath.section].count - 1
            {
                // Set the delete button
                let delete = UITableViewRowAction(
                    style: UITableViewRowActionStyle.Destructive,
                    title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE)
                ) { (action, indexPath) in
                    BunnyUtils.showDeleteDialog (
                        self,
                        managedObject: self.incomeList[indexPath.row].categoryObject,
                        deleteTitleKey: StringConstants.LABEL_DELETE_CATEGORY_TITLE,
                        deleteMessegeKey: StringConstants.LABEL_DELETE_INCOME_CATEGORY_MESSAGE,
                        deleteActionKey: StringConstants.BUTTON_DELETE_INCOME_CATEGORY,
                        tableName: ModelConstants.Entities.category,
                        tableView: self.budgetTableView,
                        completion: {
                            self.updateIncomeSection()
                        }
                    )
                }
                
                // Set the rename button
                let rename = UITableViewRowAction(
                    style: UITableViewRowActionStyle.Default,
                    title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_RENAME)
                ) { (action, indexPath) in
                    BudgetUtils.showRenameDialog(
                        self,
                        tableView: self.budgetTableView,
                        completion: { (textField) in
                            BudgetUtils.saveIncomeCategoryTextField(
                                textField,
                                model: self.incomeList[indexPath.row],
                                incomeList: self.incomeList,
                                vc: self,
                                completion: {
                                    self.updateIncomeSection()
                                }
                            )
                        }
                    )
                }
                
                delete.backgroundColor = Constants.Colors.dangerColor
                rename.backgroundColor = Constants.Colors.normalGreen
                
                returnArray = [delete, rename]
            }
        default:
            break
        }
        
        return returnArray
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return screenConstants.sectionCount
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cellCount = self.budgetTable[section].count
        
        // "There are no budgets yet."
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
    
    // When a row is tapped...
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.currentlySelectedObject = self.budgetTable[indexPath.section][indexPath.row]
        
        switch indexPath.section {
            
        // Present income cell actions (Rename and Delete)
        case self.screenConstants.idxIncomeSection:
            // If it is not the last row
            if indexPath.row != self.budgetTable[indexPath.section].count - 1 {
                self.displayIncomeCellActions()
            }
            else {
                (tableView.cellForRowAtIndexPath(indexPath) as! BunnyTableViewCell).performAction()
            }
            
        // Prepare the Edit View Controller and pass the relevant values
        case self.screenConstants.idxBudgetSection:
            let cell = self.budgetTable[indexPath.section][indexPath.row] as! BudgetCell
            let storyboard = UIStoryboard(name: Constants.Storyboards.mainStoryboard, bundle: nil)
            let frequencyKey = self.getFrequencyKey()
            var vc: AddEditBudgetTableViewController!
            
            let newNavigationController = storyboard.instantiateViewControllerWithIdentifier(Constants.ViewControllers.addBudgetNavigation) as! UINavigationController
            let topViewController = newNavigationController.topViewController
            
            self.prepareNextViewController(
                topViewController!,
                sourceInformation: Constants.SourceInformation.budgetEditing
            ) { (destinationViewController) in
                vc = destinationViewController as! AddEditBudgetTableViewController
                vc.budgetInformation = cell
                vc.frequencyKey = frequencyKey
                vc.amountDivider = self.amountDivider
            }
            
            self.presentViewController(newNavigationController, animated: true) {}
            break
        default:
            break
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: BunnyCell = self.budgetTable[indexPath.section][indexPath.row]
        let cellIdentifier = cellItem.cellIdentifier
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BunnyTableViewCellProtocol
        
        cell.prepareTableViewCell(cellItem)
        
        if cellIdentifier == Constants.CellIdentifiers.addIncomeCategory {
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
        
        // Users can only add so many budgets.
        guard
            self.budgetTable[self.screenConstants.idxBudgetSection].count < self.screenConstants.budgetMaxCount
        else {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: StringConstants.ERRORLABEL_TOO_MANY_BUDGETS
            )
            return
        }
        
        // Users can't add a new budget if a default account doesn't exist.
        guard BunnyUtils.isDefaultAccountExisting() else {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: StringConstants.ERRORLABEL_NO_DEFAULT_ACCOUNT
            )
            return
        }
        
        // Pass the frequency key
        let frequencyKey = self.getFrequencyKey()

        let newNavigationController = segue.destinationViewController as! UINavigationController
        let topViewController = newNavigationController.topViewController
        
        self.prepareNextViewController(
            topViewController!,
            sourceInformation: Constants.SourceInformation.budgetNew
        ) { (destinationViewController) in
            let vc = destinationViewController as! AddEditBudgetTableViewController
            vc.frequencyKey = frequencyKey
            vc.amountDivider = self.amountDivider
        }
    }
}

extension BudgetViewController: BudgetDelegate {

    // "Add New Income Source" is tapped 
    func presentNewIncomeAlert() {
        BunnyUtils.showTextFieldAlertWithCancelOK(
            StringConstants.LABEL_ADD_NEW_INCOME_CATEGORY,
            messageKey: StringConstants.LABEL_ADD_NEW_INCOME_CATEGORY_MESSAGE,
            placeholderKey: StringConstants.TEXTFIELD_ADD_NEW_INCOME_CATEGORY_PLACEHOLDER,
            viewController: self
        ) { (textField) in
            self.addNewIncome(textField.text!)
        }
    }

}