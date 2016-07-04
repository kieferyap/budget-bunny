//
//  BudgetViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/26/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var budgetTableView: UITableView!
    private var budgetTable: [BudgetCell] = []
    private var incomeTable: [BudgetCell] = [] // Should be IncomeCell
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
    }
    
    // Load the table data
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    // Fetch from the core data, and append each element into the table
    private func loadData() {
        BunnyUtils.getCurrencyObjectOfDefaultAccount { (defaultCurrency) in
            let defaultCurrencyIdentifier = defaultCurrency.identifier
            self.budgetTable = []
            
            var i = 0
            let tempArray = [0.6, 0.4, 0.2]
            
            let model = BunnyModel(tableName: ModelConstants.Entities.budget)
            model.selectAllObjects { (fetchedObjects) in
                for budget in fetchedObjects {
                    
                    let budgetItem: BudgetCell = BudgetCell(
                        budgetObject: budget,
                        budgetName: budget.valueForKey(ModelConstants.Budget.name) as! String,
                        budgetAmount: budget.valueForKey(ModelConstants.Budget.monthlyBudget) as! Double,
                        amountRemaining: (budget.valueForKey(ModelConstants.Budget.monthlyRemainingBudget) as! Double)*tempArray[i],
                        currencyIdentifier: defaultCurrencyIdentifier
                    )
                    
                    self.budgetTable.append(budgetItem)
                    i+=1
                }
            }
            
            self.budgetTableView.delegate = self;
            self.budgetTableView.dataSource = self;
            self.budgetTableView.scrollEnabled = true;
        }
        
    }
    
    // MARK: - Table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return screenConstants.sectionCount
    }
    
    // Hey, wait a minute. Don't we have two sections for this?
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == screenConstants.idxBudgetSection {
            return BunnyUtils.tableRowsWithLoadingTitle(
                StringConstants.GUIDELABEL_NO_ACCOUNTS, //TO-DO: GUIDELABEL_NO_BUDGETS
                tableModel: self.budgetTable,
                tableView: self.budgetTableView
            ) { () -> Int in
                return self.budgetTable.count
            }
        }
        return 0
    }
    
    // On selection, set the values of the destination view controller and push it into the view controller stack
    
    /*
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.section == screenConstants.idxBudgetSection {
            
        }
        let cell: AccountCell = self.budgetTable[indexPath.row]
        let storyboard = UIStoryboard(name: Constants.Storyboards.mainStoryboard, bundle: nil)
        var vc: AddEditAccountTableViewController!
        
        self.prepareNextViewController(
            storyboard.instantiateViewControllerWithIdentifier(Constants.ViewControllers.addEditTable),
            sourceInformation: Constants.SourceInformation.accountEditing
        ) { (destinationViewController) in
            vc = destinationViewController as! AddEditAccountTableViewController
            vc.accountInformation = cell
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
     */
    
    // TO-DO: Header titles for ALL "Add"/"Edit" Screens
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cellItem = BunnyCell(cellIdentifier: "", cellSettings: [:])
        
        switch indexPath.section {
        case self.screenConstants.idxBudgetSection:
            cellItem = self.budgetTable[indexPath.row]
            break
        // TO-DO: Case for Income type
        default:
            break
        }
        
        let cellIdentifier = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BunnyTableViewCellProtocol
        
        cell.setModelObject(cellItem)
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
