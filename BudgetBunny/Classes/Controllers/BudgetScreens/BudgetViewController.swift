//
//  BudgetViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/26/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class BudgetViewController: UIViewController {

    @IBOutlet weak var timeSegmentedControl: UISegmentedControl!
    private let screenConstants = ScreenConstants.Budget.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleLocalizationKey(StringConstants.MENULABEL_BUDGETS)
        self.timeSegmentedControl.setTitle(
            BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_MONTHLY),
            forSegmentAtIndex: screenConstants.monthly
        )
        self.timeSegmentedControl.setTitle(
            BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_WEEKLY),
            forSegmentAtIndex: screenConstants.weekly
        )
        self.timeSegmentedControl.setTitle(
            BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_DAILY),
            forSegmentAtIndex: screenConstants.daily
        )
    }
    
    // Load the table data
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    // Fetch from the core data, and append each element into the table
    private func loadData() {
        let model = BunnyModel(tableName: ModelConstants.Entities.budget)
        model.selectAllObjects { (fetchedObjects) in
            for budget in fetchedObjects {
                print(budget)
            }
        }
    }

    // MARK: - Navigation
    // Activated when + is tapped
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var frequencyKey = ""
        switch self.timeSegmentedControl.selectedSegmentIndex {
        case screenConstants.monthly:
            frequencyKey = StringConstants.LABEL_MONTHLY_BUDGET
            break
        case screenConstants.weekly:
            frequencyKey = StringConstants.LABEL_WEEKLY_BUDGET
            break
        case screenConstants.daily:
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
