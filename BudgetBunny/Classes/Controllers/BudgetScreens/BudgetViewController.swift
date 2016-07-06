//
//  BudgetViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/26/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

protocol BudgetDelegate: class {
    func addNewIncome(incomeName: String)
}

class BudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var budgetTableView: UITableView!
    private var budgetTable: [[BunnyCell]] = [[]]
    private var incomeList: [IncomeCell] = []
    private let screenConstants = ScreenConstants.Budget.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleLocalizationKey(StringConstants.MENULABEL_BUDGETS)
        self.timeSegmentedControl.setTitle(
            BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_MONTHLY),
            forSegmentAtIndex: screenConstants.idxMonthly
        )
        self.timeSegmentedControl.setTitle(
            BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_WEEKLY),
            forSegmentAtIndex: screenConstants.idxWeekly
        )
        self.timeSegmentedControl.setTitle(
            BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_DAILY),
            forSegmentAtIndex: screenConstants.idxDaily
        )
        self.budgetTable = Array.init(
            count: screenConstants.sectionCount,
            repeatedValue: []
        )
        
        self.budgetTableView.delegate = self;
        self.budgetTableView.dataSource = self;
        self.budgetTableView.scrollEnabled = true;
    }
    
    // Load the table data
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
        self.updateIncomeSection()
    }
    
    private func updateIncomeSection() {
        self.budgetTable[self.screenConstants.idxIncomeSection] = []
        
        let addNewIncome = IncomeCell(
            fieldKey: "",
            valueKey: "",
            placeholderKey: StringConstants.TEXTFIELD_NEW_CATEGORY_PLACEHOLDER,
            cellIdentifier: Constants.CellIdentifiers.addIncome,
            cellSettings: [
                Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                Constants.AppKeys.keyMaxLength: screenConstants.incomeNameMaxLength,
                Constants.AppKeys.keyTextFieldValue: ""
            ]
        )
        
        self.budgetTable[self.screenConstants.idxIncomeSection] = self.incomeList
        self.budgetTable[self.screenConstants.idxIncomeSection].append(addNewIncome)
    }
    
    // Fetch from the core data, and append each element into the table
    private func loadData() {
        BunnyUtils.getCurrencyObjectOfDefaultAccount { (defaultCurrency) in
            let defaultCurrencyIdentifier = defaultCurrency.identifier
            self.budgetTable[self.screenConstants.idxBudgetSection] = []
            
            let model = BunnyModel(tableName: ModelConstants.Entities.budget)
            model.selectAllObjects { (fetchedObjects) in
                for budget in fetchedObjects {
                    
                    let budgetItem: BudgetCell = BudgetCell(
                        budgetObject: budget,
                        budgetName: budget.valueForKey(ModelConstants.Budget.name) as! String,
                        budgetAmount: budget.valueForKey(ModelConstants.Budget.monthlyBudget) as! Double,
                        amountRemaining: budget.valueForKey(ModelConstants.Budget.monthlyRemainingBudget) as! Double,
                        currencyIdentifier: defaultCurrencyIdentifier
                    )
                    
                    self.budgetTable[self.screenConstants.idxBudgetSection].append(budgetItem)
                }
            }
            
            self.budgetTableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return screenConstants.sectionCount
    }
    
    // Hey, wait a minute. Don't we have two sections for this?
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.budgetTable[section].count
    }
    
    // On selection, set the values of the destination view controller and push it into the view controller stack
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == screenConstants.idxIncomeSection {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! IncomeTableViewCell
            cell.performAction()
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // TO-DO: Header titles for ALL "Add"/"Edit" Screens
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: BunnyCell = self.budgetTable[indexPath.section][indexPath.row]
        let cellIdentifier = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BunnyTableViewCellProtocol
        
        cell.setModelObject(cellItem)
        
        if indexPath.section == self.screenConstants.idxIncomeSection {
            (cell as! IncomeTableViewCell).delegate = self
        }
        
        return cell as! UITableViewCell
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

    func addNewIncome(incomeName: String) {
        let trimmedIncomeName = incomeName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        guard self.incomeList.count < screenConstants.incomeMaxCount else {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: StringConstants.ERRORLABEL_TOO_MANY_CATEGORIES
            )
            return
        }
        
        guard trimmedIncomeName != "" else {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: StringConstants.ERRORLABEL_CATEGORY_NOT_EMPTY
            )
            return
        }
        
        // Check if category name already exists
        let newIncomeCell = IncomeCell(
            fieldKey: trimmedIncomeName,
            valueKey: "0",
            placeholderKey: "",
            cellIdentifier: Constants.CellIdentifiers.budgetIncome,
            cellSettings: [:]
        )
        
        // Uniqueness validator
        let incomeUniquenessValidator = IncomeUniquenessValidator(
            objectToValidate: newIncomeCell,
            errorStringKey: StringConstants.ERRORLABEL_DUPLICATE_CATEGORY_NAME,
            parentArray: self.incomeList
        )
 
        // TO-DO: Sort the income alphabetically
        // TO-DO: Income name editing and category name deletion
        let validator = Validator(viewController: self)
        validator.addValidator(incomeUniquenessValidator)
        validator.validate { (success) in
            if success {
                self.incomeList.append(newIncomeCell)
                self.dismissKeyboard()
                
                // Save the new income
                
                
                let indexSet = NSIndexSet.init(index: self.screenConstants.idxIncomeSection)
                self.updateIncomeSection()
                self.budgetTableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
            }
        }
    }

}