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

    private var categoryList: [DoubleElementCell] = []
    private let screenConstants = ScreenConstants.AddEditBudget.self
    @IBOutlet weak var doneButton: UIBarButtonItem!
    var frequencyKey: String = ""
    var budgetInformation: BudgetCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the currency symbol of the default account
        let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
        let currencySymbol = defaultCurrency.currencySymbol
        var budgetName = ""
        var budgetAmount = ""
        
        if (
            self.sourceInformation == Constants.SourceInformation.budgetEditing
            && self.budgetInformation != nil
        ) {
            let floatFormat: String = self.budgetInformation!.budgetAmount.isInteger ? "%.0f" : "%.2f"
            budgetAmount = String(format: floatFormat, self.budgetInformation!.budgetAmount)
            budgetName = (self.budgetInformation?.alphaElementTitle)!
        }
        
        let amountText = BunnyUtils.uncommentedLocalizedString(self.frequencyKey)
            .stringByAppendingString(" (")
            .stringByAppendingString(currencySymbol)
            .stringByAppendingString(")")
        
        self.prepareModelData(screenConstants.sectionCount) {
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
            
            self.updateCategorySection()
            self.doneButton.title = BunnyUtils.uncommentedLocalizedString(StringConstants.BUTTON_DONE)
            self.setTitleLocalizationKey(StringConstants.MENULABEL_ADD_BUDGET)
        }
    }
    
    private func updateCategorySection() {
        self.modelData[screenConstants.idxCategoryGroup] = []
        
        if (
            self.sourceInformation == Constants.SourceInformation.budgetEditing
            && self.budgetInformation != nil
        ) {
            let categoryModel = AttributeModel(
                tableName: ModelConstants.Entities.category,
                key: ModelConstants.Category.isIncome,
                value: false
            )
            
            let model = BunnyModel(tableName: ModelConstants.Entities.category)
            let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
            
            model.selectAllObjectsWithParameters([categoryModel.format: categoryModel.value], completion: { (fetchedObjects) in
                for category in fetchedObjects {
                    print(category.valueForKey(ModelConstants.Category.name))
                    self.categoryList.append(
                        DoubleElementCell(
                            alphaElementTitleKey: category.valueForKey(ModelConstants.Category.name) as! String,
                            betaElementTitleKey: BunnyUtils.getFormattedAmount(category.valueForKey(ModelConstants.Category.monthlyAmount) as! Double, identifier: defaultCurrency.identifier),
                            cellIdentifier: Constants.CellIdentifiers.addBudgetCategory,
                            cellSettings: [:]
                        )
                    )
                }
            })
        }
        
        
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
    
    
    // Grabs the value for each cell, used for saving the data
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
        
        // Add the error validators
        let validator = Validator(viewController: self)
        validator.addValidator(emptyNameValidator)
        validator.addValidator(emptyAmountValidator)
        validator.addValidator(nameUniquenessValidator)
        
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
                        activeRecord.insertObject(values)
                        activeRecord.save()
                    }
                }
                
                
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }

    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.screenConstants.sectionCount
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelData[section].count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! BunnyTableViewCell
        cell.performAction()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellItem: BunnyCell = self.modelData[indexPath.section][indexPath.row]
        let cellIdentifier: String = cellItem.cellIdentifier
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! BunnyTableViewCellProtocol

        cell.prepareTableViewCell(cellItem)
        
        if cellIdentifier == Constants.CellIdentifiers.addBudgetNewCategory {
            (cell as! SingleElementTableViewCell).delegate = self
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
        default:
            break
        }
        return BunnyUtils.uncommentedLocalizedString(headerNameKey)
    }
 
}

extension AddEditBudgetTableViewController: AddEditBudgetDelegate {
    
    func addNewCategory(categoryName: String) {
        BunnyUtils.saveSingleField(
            categoryName,
            parentArray: self.categoryList,
            maxCount: screenConstants.categoryMaxCount,
            errorMaxCountKey: StringConstants.ERRORLABEL_TOO_MANY_CATEGORIES,
            errorEmptyNameKey: StringConstants.ERRORLABEL_CATEGORY_NOT_EMPTY,
            errorDuplicateNameKey: StringConstants.ERRORLABEL_DUPLICATE_CATEGORY_NAME,
            viewController: self,
            isRename: false)
        { (success, newItem) in
            if success {
                let defaultCurrency = BunnyUtils.getCurrencyObjectOfDefaultAccount()
                
                let newCategoryItem = DoubleElementCell(
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
                self.updateCategorySection()
                self.tableView.reloadSections(indexSet, withRowAnimation: UITableViewRowAnimation.None)
            }
        }
    }
}

