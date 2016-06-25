//
//  AddEditBudgetViewController
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

protocol AddEditBudgetDelegate: class {
    func unmarkAllCategoriesExceptFor(cellModel: AddEditBudgetCell)
    func addNewCategory(categoryName: String)
}

class AddEditBudgetTableViewController: UITableViewController {

    private var addBudgetTable: [[AddEditBudgetCell]] = [[]]
    private var categoryList: [AddEditBudgetCell] = []
    private var selectedCategoryCell: AddEditBudgetCell?
    private let screenConstants = ScreenConstants.AddEditBudget.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addBudgetTable = Array.init(count: 2, repeatedValue: [])
        
        // TO-DO: Why not placeholderKey? We clearly have fieldKey. >:U
        let nameCell = AddEditBudgetCell(
            fieldKey: "Budget Name",
            placeholder: "Food",
            cellIdentifier: Constants.CellIdentifiers.addBudgetFieldValue,
            cellSettings: [
                Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                Constants.AppKeys.keyMaxLength: 10,
                Constants.AppKeys.keyTextFieldValue: ""
            ]
        )
        
        let budgetCell = AddEditBudgetCell(
            fieldKey: "Xly Budget",
            placeholder: "1000",
            cellIdentifier: Constants.CellIdentifiers.addBudgetFieldValue,
            cellSettings: [
                Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.decimal,
                Constants.AppKeys.keyMaxLength: 10,
                Constants.AppKeys.keyTextFieldValue: ""
            ]
        )
        
        self.addBudgetTable[screenConstants.idxInformationGroup].append(nameCell)
        self.addBudgetTable[screenConstants.idxInformationGroup].append(budgetCell)
        self.updateCategorySection()
        
        // Keyboard must be dismissed when regions outside of it is tapped
        BunnyUtils.addKeyboardDismisserListener(self)
    }
    
    func updateCategorySection() {
        // Will be used in the editing
        /*
         let categoryCell = AddEditBudgetCell(
         fieldKey: "Breakfast",
         placeholder: "",
         cellIdentifier: Constants.CellIdentifiers.addBudgetCategory,
         cellSettings: [:]
         )
         */
        self.addBudgetTable[screenConstants.idxCategoryGroup] = []
        
        let addCategoryCell = AddEditBudgetCell(
            fieldKey: "",
            placeholder: "Add New Category",
            cellIdentifier: Constants.CellIdentifiers.addBudgetNewCategory,
            cellSettings: [
                Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                Constants.AppKeys.keyMaxLength: 10,
                Constants.AppKeys.keyTextFieldValue: ""
            ]
        )
        
        self.addBudgetTable[screenConstants.idxCategoryGroup] = self.categoryList
        self.addBudgetTable[screenConstants.idxCategoryGroup].append(addCategoryCell)
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.screenConstants.sectionCount
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addBudgetTable[section].count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! AddEditBudgetTableViewCell
        cell.performAction()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: AddEditBudgetCell = self.addBudgetTable[indexPath.section][indexPath.row]
        let cellIdentifier: String = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! AddEditBudgetTableViewCell

        cell.setBudgetCellModel(cellItem)
        cell.delegate = self
        
        if self.selectedCategoryCell != nil {
            cell.model?.isSelected = false
            cell.accessoryType = UITableViewCellAccessoryType.None
            if cellItem.field == self.selectedCategoryCell!.field {
                cell.model?.isSelected = true
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
        
        return cell
    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cellItem: AddEditAccountCell = self.addAccountTable[indexPath.section][indexPath.row]
//        var cellHeight: CGFloat = CGFloat(screenConstants.defaultCellHeight)
//        BunnyUtils.keyExistsForCellSettings(cellItem, key: screenConstants.keyHeight) { (object) in
//            cellHeight = object as! CGFloat
//        }
//        return cellHeight
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddEditBudgetTableViewController: AddEditBudgetDelegate {
    
    func unmarkAllCategoriesExceptFor(cellModel: AddEditBudgetCell) {
        self.selectedCategoryCell = cellModel
        self.updateCategorySection()
        let indexSet = NSIndexSet.init(index: screenConstants.idxCategoryGroup)
        self.tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func addNewCategory(categoryName: String) {
        let newCategoryItem = AddEditBudgetCell(
            fieldKey: categoryName,
            placeholder: "",
            cellIdentifier: Constants.CellIdentifiers.addBudgetCategory,
            cellSettings: [:]
        )
        self.categoryList.append(newCategoryItem)
        self.dismissKeyboard()
        
        let indexSet = NSIndexSet.init(index: screenConstants.idxCategoryGroup)
        self.updateCategorySection()
        self.tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
    }
}
