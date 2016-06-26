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
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var frequencyKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBudgetTable = Array.init(
            count: screenConstants.sectionCount,
            repeatedValue: []
        )
        
        // TO-DO: Why not placeholderKey? We clearly have fieldKey. >:U
        let nameCell = AddEditBudgetCell(
            fieldKey: StringConstants.LABEL_BUDGET_NAME,
            placeholderKey: StringConstants.TEXTFIELD_BUDGET_PLACEHOLDER,
            cellIdentifier: Constants.CellIdentifiers.addBudgetFieldValue,
            cellSettings: [
                Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                Constants.AppKeys.keyMaxLength: screenConstants.budgetNameMaxLength,
                Constants.AppKeys.keyTextFieldValue: ""
            ]
        )
        
        let budgetCell = AddEditBudgetCell(
            fieldKey: self.frequencyKey,
            placeholderKey: StringConstants.TEXTFIELD_XLY_BUDGET_PLACEHOLDER,
            cellIdentifier: Constants.CellIdentifiers.addBudgetFieldValue,
            cellSettings: [
                Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.decimal,
                Constants.AppKeys.keyMaxLength: screenConstants.budgetAmountMaxLength,
                Constants.AppKeys.keyTextFieldValue: ""
            ]
        )
        
        self.addBudgetTable[screenConstants.idxInformationGroup].append(nameCell)
        self.addBudgetTable[screenConstants.idxInformationGroup].append(budgetCell)
        self.updateCategorySection()
        
        // Keyboard must be dismissed when regions outside of it is tapped
        BunnyUtils.addKeyboardDismisserListener(self)
        self.doneButton.title = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DONE)
        self.setTitleLocalizationKey(StringConstants.MENULABEL_ADD_ACCOUNT)
    }
    
    func updateCategorySection() {
        // Will (probably) be used in editing
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
            placeholderKey: StringConstants.TEXTFIELD_NEW_CATEGORY_PLACEHOLDER,
            cellIdentifier: Constants.CellIdentifiers.addBudgetNewCategory,
            cellSettings: [
                Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                Constants.AppKeys.keyMaxLength: screenConstants.categoryNameMaxLength,
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

}

extension AddEditBudgetTableViewController: AddEditBudgetDelegate {
    
    func unmarkAllCategoriesExceptFor(cellModel: AddEditBudgetCell) {
        self.selectedCategoryCell = cellModel
        self.updateCategorySection()
        let indexSet = NSIndexSet.init(index: screenConstants.idxCategoryGroup)
        self.tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
    }
    
    func addNewCategory(categoryName: String) {
        // Check if category name already exists
        let newCategoryItem = AddEditBudgetCell(
            fieldKey: categoryName,
            placeholderKey: "",
            cellIdentifier: Constants.CellIdentifiers.addBudgetCategory,
            cellSettings: [:]
        )
        
        let categoryUniquenessValidator = CategoryUniquenessValidator(
            objectToValidate: newCategoryItem,
            errorStringKey: StringConstants.ERRORLABEL_DUPLICATE_CATEGORY_NAME,
            parentArray: self.categoryList
        )
        
        // TO-DO: Category name editing and category name deletion
        let validator = Validator(viewController: self)
        validator.addValidator(categoryUniquenessValidator)
        validator.validate { (success) in
            if success {
                self.categoryList.append(newCategoryItem)
                self.dismissKeyboard()
                
                let indexSet = NSIndexSet.init(index: self.screenConstants.idxCategoryGroup)
                self.updateCategorySection()
                self.tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
            }
        }
    }
}
