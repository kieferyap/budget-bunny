//
//  AddEditBudgetViewController
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

protocol AddEditBudgetDelegate: class {
    func addNewCategory(categoryName: String)
}

class AddEditBudgetTableViewController: UITableViewController {
/*
    private var categoryList: [AddEditBudgetCell] = []
    private let screenConstants = ScreenConstants.AddEditBudget.self
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var frequencyKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBudgetTable = Array.init(
            count: screenConstants.sectionCount,
            repeatedValue: []
        )
        
        // Get the currency symbol of the default account
        BunnyUtils.getCurrencyObjectOfDefaultAccount { (defaultCurrency) in
            let currencySymbol = defaultCurrency.currencySymbol
            
            let amountText = BunnyUtils.uncommentedLocalizedString(self.frequencyKey)
                .stringByAppendingString(" (")
                .stringByAppendingString(currencySymbol)
                .stringByAppendingString(")")
            
            let nameCell = AddEditBudgetCell(
                fieldKey: StringConstants.LABEL_BUDGET_NAME,
                placeholderKey: StringConstants.TEXTFIELD_BUDGET_PLACEHOLDER,
                cellIdentifier: Constants.CellIdentifiers.addBudgetFieldValue,
                cellSettings: [
                    Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                    Constants.AppKeys.keyMaxLength: self.screenConstants.budgetNameMaxLength,
                    Constants.AppKeys.keyTextFieldValue: ""
                ]
            )
            
            let amountCell = AddEditBudgetCell(
                fieldKey: amountText,
                placeholderKey: StringConstants.TEXTFIELD_XLY_BUDGET_PLACEHOLDER,
                cellIdentifier: Constants.CellIdentifiers.addBudgetFieldValue,
                cellSettings: [
                    Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.decimal,
                    Constants.AppKeys.keyMaxLength: self.screenConstants.budgetAmountMaxLength,
                    Constants.AppKeys.keyTextFieldValue: ""
                ]
            )
            
            self.addBudgetTable[self.screenConstants.idxInformationGroup].append(nameCell)
            self.addBudgetTable[self.screenConstants.idxInformationGroup].append(amountCell)
            self.updateCategorySection()
            
            // Keyboard must be dismissed when regions outside of it is tapped
            BunnyUtils.addKeyboardDismisserListener(self)
            self.doneButton.title = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DONE)
            self.setTitleLocalizationKey(StringConstants.MENULABEL_ADD_BUDGET)
        }
        
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
    
    // Grabs the value for each cell, used for saving the data
    private func getTableViewCellValue(section: Int, row: Int) -> String {
        let indexPath = NSIndexPath.init(forRow: row, inSection: section)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! AddEditBudgetTableViewCell
        return (cell.textfield.text?.stringByTrimmingCharactersInSet(
            NSCharacterSet.whitespaceAndNewlineCharacterSet()
        ))!
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        // Gather the input values
        let budgetName = self.getTableViewCellValue(
            screenConstants.idxInformationGroup,
            row: screenConstants.idxNameCell
        )
        let budgetAmount = self.getTableViewCellValue(
            screenConstants.idxInformationGroup,
            row: screenConstants.idxAmountCell
        )
        let budgetAmountFloat = (budgetAmount as NSString).doubleValue
        
        // Set up the error validators
        let budgetNameModel = AttributeModel(
            tableName: ModelConstants.Entities.budget,
            key: ModelConstants.Budget.name,
            value: budgetName
        )
        let emptyNameValidator = EmptyStringValidator(
            objectToValidate: budgetName,
            errorStringKey:  StringConstants.ERRORLABEL_NAME_AMOUNT_NOT_EMPTY
        )
        let emptyAmountValidator = EmptyStringValidator(
            objectToValidate: budgetAmount,
            errorStringKey: StringConstants.ERRORLABEL_NAME_AMOUNT_NOT_EMPTY
        )
        let nameUniquenessValidator = AttributeUniquenessValidator(
            objectToValidate: budgetNameModel,
            errorStringKey: StringConstants.ERRORLABEL_DUPLICATE_BUDGET_NAME,
            oldName: ""
        )
        let categoryCountValidator = EmptyArrayValidator(
            objectToValidate: self.categoryList,
            errorStringKey: StringConstants.ERRORLABEL_NO_CATEGORIES
        )
        
        // Add the error validators
        let validator = Validator(viewController: self)
        validator.addValidator(emptyNameValidator)
        validator.addValidator(emptyAmountValidator)
        validator.addValidator(nameUniquenessValidator)
        validator.addValidator(categoryCountValidator)
        
        // Validate the fields
        validator.validate { (success) in
            
            // If there are no errors, save the fields
            if success {
                // Adding a new account
                let activeRecord = BunnyModel.init(tableName: ModelConstants.Entities.budget)
                
                // Set the values of the account and insert it
                var values = NSDictionary.init(
                    objects: [
                        budgetName,
                        budgetAmountFloat,
                        budgetAmountFloat
                    ],
                    forKeys: [
                        ModelConstants.Budget.name,
                        ModelConstants.Budget.monthlyBudget,
                        ModelConstants.Budget.monthlyRemainingBudget
                    ]
                )
                
                // The active record should insert if the account is new, but update if it is being edited
                let model = activeRecord.insertObject(values)
                
                // Add the related categories
                for item in self.categoryList {
                    let categoryName = item.field.stringByTrimmingCharactersInSet(
                        NSCharacterSet.whitespaceAndNewlineCharacterSet()
                    )
                    
                    activeRecord.changeTableName(ModelConstants.Entities.category)
                    values = NSDictionary.init(
                        objects: [
                            categoryName,
                            false,
                            0.0,
                            model
                        ],
                        forKeys: [
                            ModelConstants.Category.name,
                            ModelConstants.Category.isIncome,
                            ModelConstants.Category.monthlyAmount,
                            ModelConstants.Category.budgetId
                        ]
                    )

                }
                
                activeRecord.insertObject(values)
                activeRecord.save()
                
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
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

        cell.setModelObject(cellItem)
        cell.delegate = self
        
        return cell
    }

}

extension AddEditBudgetTableViewController: AddEditBudgetDelegate {
    
    func addNewCategory(categoryName: String) {
        let trimmedCategoryName = categoryName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        guard self.categoryList.count < screenConstants.categoryMaxCount else {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: StringConstants.ERRORLABEL_TOO_MANY_CATEGORIES
            )
            return
        }
        
        guard trimmedCategoryName != "" else {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: StringConstants.ERRORLABEL_CATEGORY_NOT_EMPTY
            )
            return
        }
        
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
        
        // TO-DO: Sort the categories alphabetically
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
 */
}
