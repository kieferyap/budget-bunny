//
//  AddEditBudgetViewController
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

protocol AddEditBudgetDelegate: class {
    func addNewCategory(categoryName: String)
    func deleteBudget(budgetObject: NSManagedObject)
    func displayCategoryCellActions()
}

class AddEditBudgetTableViewController: UITableViewController {

    private var categoryList: [BudgetCategoryCell] = []
    private let screenConstants = ScreenConstants.AddEditBudget.self
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var frequencyKey: String = ""
    var budgetInformation: BudgetCell?
    private var sectionCount: Int = 0
    private var selectedCategoryRowIdx: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the currency symbol of the default account
        let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
        let currencySymbol = defaultCurrency.currencySymbol
        
        // Prepare the variables
        var doneButtonTitleKey = StringConstants.BUTTON_DONE
        var budgetName = ""
        var budgetAmount = ""
        let isEditing = self.sourceInformation == Constants.SourceInformation.budgetEditing
            && self.budgetInformation != nil
        self.sectionCount = screenConstants.sectionCount
        
        // If we're in edit mode, retrieve budget information and set the Save button
        if (isEditing) {
            let floatFormat: String = self.budgetInformation!.budgetAmount.isInteger ? "%.0f" : "%.2f"
            budgetAmount = String(format: floatFormat, self.budgetInformation!.budgetAmount)
            budgetName = (self.budgetInformation?.alphaElementTitle)!
            doneButtonTitleKey = StringConstants.BUTTON_SAVE
            self.sectionCount = screenConstants.sectionCountWithDelete
        }
        
        // "Monthly/Weekly/Daily Budget ($)"
        let amountText = BunnyUtils.uncommentedLocalizedString(self.frequencyKey)
            .stringByAppendingString(" (")
            .stringByAppendingString(currencySymbol)
            .stringByAppendingString(")")
        
        self.prepareModelData(self.sectionCount) {
            
            // Budget name
            self.appendCellAtSectionIndex(
                self.screenConstants.idxInformationGroup,
                idxRow: self.screenConstants.idxNameCell,
                cellData: DoubleElementCell(
                    alphaElementTitleKey: StringConstants.LABEL_BUDGET_NAME,
                    betaElementTitleKey: StringConstants.TEXTFIELD_BUDGET_PLACEHOLDER,
                    cellIdentifier: Constants.CellIdentifiers.addBudgetFieldValue,
                    cellSettings: [
                        Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                        Constants.AppKeys.keyMaxLength: self.screenConstants.budgetNameMaxLength,
                        Constants.AppKeys.keyTextFieldValue: budgetName
                    ]
                )
            )
            
            // Budget amount
            self.appendCellAtSectionIndex(
                self.screenConstants.idxInformationGroup,
                idxRow: self.screenConstants.idxAmountCell,
                cellData: DoubleElementCell(
                    alphaElementTitleKey: amountText,
                    betaElementTitleKey: StringConstants.TEXTFIELD_XLY_BUDGET_PLACEHOLDER,
                    cellIdentifier: Constants.CellIdentifiers.addBudgetFieldValue,
                    cellSettings:[
                        Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.decimal,
                        Constants.AppKeys.keyMaxLength: self.screenConstants.budgetAmountMaxLength,
                        Constants.AppKeys.keyTextFieldValue: budgetAmount
                    ]
                )
            )
            
            // Budget Categories
            self.updateCategorySection(true)
            
            // Enable budget deletion if we're editing
            if (isEditing) {
                
                // Delete budget
                self.appendCellAtSectionIndex(
                    self.screenConstants.idxActionsGroup,
                    idxRow: self.screenConstants.idxDeleteCell,
                    cellData: SingleElementCell(
                        alphaElementTitleKey: StringConstants.LABEL_DELETE_BUDGET_BUTTON,
                        cellIdentifier: Constants.CellIdentifiers.addBudgetAction,
                        cellSettings: [
                            Constants.AppKeys.keySelector: self.screenConstants.selectorDelete,
                            Constants.AppKeys.keyEnabled: true,
                            Constants.AppKeys.keyButtonColor: Constants.Colors.dangerColor,
                            Constants.AppKeys.keyManagedObject: (self.budgetInformation?.budgetObject)!
                        ]
                    )
                )
            }
            
            // Set title and done button
            self.doneButton.title = BunnyUtils.uncommentedLocalizedString(doneButtonTitleKey)
            self.setTitleLocalizationKey(StringConstants.MENULABEL_ADD_BUDGET)
        }
    }
    
    private func updateCategorySection(isInitialLoading: Bool) {
        self.modelData[screenConstants.idxCategoryGroup] = []
        
        // If we're in edit mode, we should retrieve the budget categories from the core data.
        if (
            self.sourceInformation == Constants.SourceInformation.budgetEditing
            && self.budgetInformation != nil
            && isInitialLoading
        ) {
            // This entire bit is basically: "SELECT * FROM categories WHERE budgetId = n;"
            let categoryModel = AttributeModel(
                tableName: ModelConstants.Entities.category,
                key: ModelConstants.Category.budgetId,
                value: (self.budgetInformation?.budgetObject)!
            )
            
            let model = ActiveRecord(tableName: ModelConstants.Entities.category)
            let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
            
            model.selectAllObjectsWithParameters([categoryModel.format: categoryModel.value], completion: { (fetchedObjects) in
                for category in fetchedObjects {
                    self.categoryList.append(
                        BudgetCategoryCell(
                            categoryObject: category,
                            alphaElementTitleKey: category.valueForKey(ModelConstants.Category.name) as! String,
                            betaElementTitleKey: BunnyUtils.getFormattedAmount(category.valueForKey(ModelConstants.Category.monthlyAmount) as! Double, identifier: defaultCurrency.identifier),
                            cellIdentifier: Constants.CellIdentifiers.addBudgetCategory,
                            cellSettings: [:]
                        )
                    )
                }
            })
        }
        
        // "Add Budget Category"
        let addCategoryCell = SingleElementCell(
            alphaElementTitleKey: StringConstants.TEXTFIELD_NEW_CATEGORY_PLACEHOLDER,
            cellIdentifier: Constants.CellIdentifiers.addBudgetNewCategory,
            cellSettings: [
                Constants.AppKeys.keyKeyboardType: Constants.KeyboardTypes.alphanumeric,
                Constants.AppKeys.keyMaxLength: screenConstants.categoryNameMaxLength,
                Constants.AppKeys.keyTextFieldValue: ""
            ]
        )
        
        self.modelData[screenConstants.idxCategoryGroup] = self.categoryList
        self.modelData[screenConstants.idxCategoryGroup].append(addCategoryCell)
    }
    
    
    // Grabs the value for each cell. This is used for saving the data
    private func getTableViewCellValue(section: Int, row: Int) -> String {
        let indexPath = NSIndexPath.init(forRow: row, inSection: section)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as! BunnyTableViewCell
        return cell.getValue()
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
        var oldName = ""
        
        // If we're editing, we should keep track of the old name
        if self.sourceInformation == Constants.SourceInformation.budgetEditing {
            oldName = (self.budgetInformation?.alphaElementTitle)!
        }
        
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
            oldName: oldName
        )
        
        // Add the error validators
        let validator = Validator(viewController: self)
        validator.addValidator(emptyNameValidator)
        validator.addValidator(emptyAmountValidator)
        validator.addValidator(nameUniquenessValidator)
        
        // Validate the fields
        validator.validate { (success) in
            
            // If there are no errors, save the fields
            if success {
                let activeRecord = ActiveRecord.init(tableName: ModelConstants.Entities.budget)
                
                // Set the values of the budget and insert it
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
                
                // The active record should insert if the budget is new, but update if it is being edited
                let model = self.sourceInformation == Constants.SourceInformation.budgetNew ?
                    activeRecord.insertObject(values) :
                    activeRecord.updateObjectWithObjectId(
                        (self.budgetInformation?.budgetObject.objectID)!,
                        updateParameters: values
                    )
                
                // Add the related categories
                if self.categoryList.count > 0 {
                    for item in self.categoryList {
                        let categoryName = item.alphaElementTitle
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
                        
                        // If the category is new, insert it.
                        if item.categoryObject == nil {
                            activeRecord.insertObject(values)
                        }
                            
                        // If the category already exists in the core data, update it.
                        else {
                            activeRecord.updateObjectWithObjectId(
                                item.categoryObject.objectID,
                                updateParameters: values
                            )
                        }
                        activeRecord.save()
                    }
                }
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }

    private func renameCategory(newName: String, categoryIdx: Int) {
        // Trim the new name
        let trimmedName = BunnyUtils.trimLeadingTrailingSpaces(newName)
        
        // Check for valid length
        guard trimmedName.characters.count <= self.screenConstants.categoryNameMaxLength else {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: StringConstants.ERRORLABEL_BUDGET_CATEGORY_NAME_TOO_LONG
            )
            return
        }
        
        // Check for emptiness
        guard trimmedName != "" else {
            BunnyUtils.showAlertWithOKButton(
                self,
                titleKey: StringConstants.ERRORLABEL_ERROR_TITLE,
                messageKey: StringConstants.ERRORLABEL_BUDGET_CATEGORY_NOT_EMPTY
            )
            return
        }
        
        // Set the new title
        self.categoryList[categoryIdx].alphaElementTitle = trimmedName
        let indexPath = NSIndexPath.init(forRow: categoryIdx, inSection: self.screenConstants.idxCategoryGroup)
        self.tableView.reloadRowsAtIndexPaths(
            [indexPath],
            withRowAnimation: UITableViewRowAnimation.None
        )
    }
    
    private func deleteCategory(categoryIdx: Int) {
        // "Are you sure you want to delete this? This can't be undone."
        let alertController = UIAlertController.init(
            title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_DELETE_CATEGORY_TITLE),
            message: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_DELETE_BUDGET_CATEGORY_MESSAGE),
            preferredStyle: UIAlertControllerStyle.ActionSheet
        )
        
        // The delete button
        alertController.addAction(
            UIAlertAction.init(
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_DELETE_BUDGET_CATEGORY_BUTTON),
                style: UIAlertActionStyle.Destructive,
                handler: { (UIAlertAction) in
                    let categoryObject = self.categoryList[categoryIdx].categoryObject
                    if (categoryObject != nil) {
                        // Delete it from the core data
                        let activeRecord = ActiveRecord.init(tableName: ModelConstants.Entities.category)
                        activeRecord.deleteObject(categoryObject, completion: {})
                    }
                    
                    self.categoryList.removeAtIndex(categoryIdx)
                    self.updateCategorySection(false)
                    
                    let sectionIdx = NSIndexSet.init(index: self.screenConstants.idxCategoryGroup)
                    self.tableView.reloadSections(sectionIdx, withRowAnimation: UITableViewRowAnimation.None)
                }
            )
        )
        
        // Cancel button
        alertController.addAction(
            UIAlertAction.init(
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_CANCEL),
                style: UIAlertActionStyle.Cancel,
                handler: nil
            )
        )
        
        // Present the alert
        self.presentViewController(
            alertController,
            animated: true,
            completion: nil
        )
        
        // If any cell in the table is swiped left, then it will return to its normal position
        if (tableView != nil) {
            tableView?.setEditing(false, animated: true)
        }

    }
    
    // MARK: - Table view data source
    // Needed for the swipe functionality
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // Set if the row is swipable
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == self.screenConstants.idxCategoryGroup {
            // Return true if it's not the last row. False if otherwise.
            return indexPath.row != self.modelData[indexPath.section].count - 1 ? true: false
        }
        return false
    }
    
    // Set the swipe buttons
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        var returnArray: [UITableViewRowAction] = []
        
        // All cells in the category section (except the bottom-most row) has the swipe functionality.
        if (
            indexPath.section == self.screenConstants.idxCategoryGroup
            && indexPath.row != self.modelData[indexPath.section].count - 1
        ) {
            // Set the delete button
            let delete = UITableViewRowAction(
                style: UITableViewRowActionStyle.Destructive,
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DELETE)
            ) { (action, indexPath) in
                self.deleteCategory(indexPath.row)
            }
            
            // Set the rename button
            let rename = UITableViewRowAction(
                style: UITableViewRowActionStyle.Default,
                title: BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_RENAME)
            ) { (action, indexPath) in
                BudgetUtils.showRenameDialog(
                    self,
                    tableView: self.tableView,
                    completion: { (textField) in
                        self.renameCategory(textField.text!, categoryIdx: indexPath.row)
                    }
                )
            }
            
            delete.backgroundColor = Constants.Colors.dangerColor
            rename.backgroundColor = Constants.Colors.normalGreen
            
            returnArray = [delete, rename]
        }
        
        return returnArray
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionCount
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelData[section].count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! BunnyTableViewCell
        
        if indexPath.section == screenConstants.idxCategoryGroup {
            self.selectedCategoryRowIdx = indexPath.row
        }
        
        cell.performAction()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: BunnyCell = self.modelData[indexPath.section][indexPath.row]
        let cellIdentifier: String = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BunnyTableViewCellProtocol

        cell.prepareTableViewCell(cellItem)
        
        if (cellIdentifier != Constants.CellIdentifiers.addBudgetFieldValue) {
            (cell as! BunnyTableViewCell).delegate = self
        }
        
        return cell as! UITableViewCell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerNameKey = ""
        switch section {
        case screenConstants.idxInformationGroup:
            headerNameKey = StringConstants.LABEL_HEADER_BUDGET_INFORMATION
        case screenConstants.idxCategoryGroup:
            headerNameKey = StringConstants.LABEL_HEADER_BUDGET_CATEGORIES
        case screenConstants.idxActionsGroup:
            headerNameKey = StringConstants.LABEL_BUDGET_CATEGORY_ACTIONS
        default:
            break
        }
        return BunnyUtils.uncommentedLocalizedString(headerNameKey)
    }
 
}

extension AddEditBudgetTableViewController: AddEditBudgetDelegate {
    
    func displayCategoryCellActions() {
        BudgetUtils.displayCategoryCellActions(
            self,
            tableView: self.tableView,
            renameCompletion: {
                // Rename completion
                BudgetUtils.showRenameDialog(
                    self,
                    tableView: self.tableView,
                    completion: { (textField) in
                        self.renameCategory(textField.text!, categoryIdx: self.selectedCategoryRowIdx)
                    }
                )
            }){
                // Delete completion
                self.deleteCategory(self.selectedCategoryRowIdx)
            }
    }
    
    func addNewCategory(categoryName: String) {
        BunnyUtils.saveSingleField(
            categoryName,
            parentArray: self.categoryList,
            maxCount: screenConstants.categoryMaxCount,
            maxLength: ScreenConstants.AddEditBudget.categoryNameMaxLength,
            errorMaxLengthKey: StringConstants.ERRORLABEL_BUDGET_CATEGORY_NAME_TOO_LONG,
            errorMaxCountKey: StringConstants.ERRORLABEL_TOO_MANY_CATEGORIES,
            errorEmptyNameKey: StringConstants.ERRORLABEL_CATEGORY_NOT_EMPTY,
            errorDuplicateNameKey: StringConstants.ERRORLABEL_DUPLICATE_CATEGORY_NAME,
            viewController: self,
            isRename: false)
        { (success, newItem) in
            // Add the new category in the table and refresh it
            if success {
                let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
                
                let newCategoryItem = BudgetCategoryCell(
                    categoryObject: nil,
                    alphaElementTitleKey: newItem,
                    betaElementTitleKey: BunnyUtils.getFormattedAmount(
                        0.0,
                        identifier: defaultCurrency.identifier
                    ),
                    cellIdentifier: Constants.CellIdentifiers.addBudgetCategory,
                    cellSettings: [:]
                )
                
                self.categoryList.append(newCategoryItem)
                self.dismissKeyboard()
                
                let indexSet = NSIndexSet.init(index: self.screenConstants.idxCategoryGroup)
                self.updateCategorySection(false)
                self.tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
            }
        }
    }
    
    // Delete the budget from the core data and pop the view controller.
    func deleteBudget(budgetObject: NSManagedObject) {
        // "This action can't be undone, etc."
        BunnyUtils.showDeleteDialog(
            self,
            managedObject: budgetObject,
            deleteTitleKey: StringConstants.LABEL_DELETE_BUDGET_TITLE,
            deleteMessegeKey: StringConstants.LABEL_DELETE_BUDGET_MESSAGE,
            deleteActionKey: StringConstants.LABEL_DELETE_BUDGET_BUTTON,
            tableName: ModelConstants.Entities.budget,
            tableView: self.tableView,
            completion: {
                self.navigationController?.popViewControllerAnimated(true)
            }
        )
    }
}

