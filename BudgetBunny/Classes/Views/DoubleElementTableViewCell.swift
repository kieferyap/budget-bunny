//
//  DoubleElementTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/10/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class DoubleElementTableViewCell: BunnyTableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var alphaUIElement: UIView!
    @IBOutlet weak var betaUIElement: UIView!
    
    func prepareTableViewCell(model: BunnyCell) {
        super.prepareTableViewCell(model) {
            
            // "Account name: <textfield>" in the Add/Edit Account Screens
            self.addCellType(
                Constants.CellIdentifiers.addAccountFieldValue,
                completion: {
                    let accountModel = self.model as! DoubleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    
                    alphaLabel.text = accountModel.alphaElementTitle
                    BunnyUtils.prepareTextField(
                        betaTextField,
                        placeholderText: accountModel.betaElementTitle,
                        textColor: Constants.Colors.darkGray,
                        model: accountModel
                    )
                    
                    betaTextField.placeholder = accountModel.betaElementTitle
                },
                getValue: {
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    return betaTextField.text!
                },
                performAction:  {
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    betaTextField.becomeFirstResponder()
                }
            )
            
            // "Currency: United States" in the Add/Edit Account Screens
            self.addCellType(
                Constants.CellIdentifiers.addAccountChevron,
                completion: {
                    let accountModel = self.model as! DoubleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaLabel = self.betaUIElement as! UILabel
                    
                    alphaLabel.text = accountModel.alphaElementTitle
                    betaLabel.text = accountModel.betaElementTitle
                    
                    betaLabel.adjustsFontSizeToFitWidth = true
                    betaLabel.textColor = Constants.Colors.darkGray
                    
                    self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                    self.setSelectedBackgroundColor(Constants.Colors.lightGreen)
                },
                getValue: {
                    // Does not need a return value because the value lies
                    // on the selected currency identifier.
                    return ""
                },
                performAction:  {
                    (self.delegate as! AddEditAccountDelegate).pushCurrencyViewController()
                }
            )
            
            // "Salary: $2000"/Income Category in the Budget Screen
            self.addCellType(
                Constants.CellIdentifiers.incomeCategory,
                completion: {
                    let incomeModel = self.model as! IncomeCategoryCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaLabel = self.betaUIElement as! UILabel
                    
                    alphaLabel.text = incomeModel.categoryObject.valueForKey(ModelConstants.Category.name) as? String
                    betaLabel.text = incomeModel.betaElementTitle
                    betaLabel.textColor = Constants.Colors.incomeColor
                    
                    alphaLabel.adjustsFontSizeToFitWidth = true
                    betaLabel.adjustsFontSizeToFitWidth = true
                    self.setSelectedBackgroundColor(Constants.Colors.lightGreen)
                },
                getValue: { () -> String in
                    return ""
                },
                performAction: {
                }
            )
            
            // Budget name and budget amount in the add budget screen
            self.addCellType(
                Constants.CellIdentifiers.addBudgetFieldValue,
                completion: {
                    let budgetModel = self.model as! DoubleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    
                    alphaLabel.text = budgetModel.alphaElementTitle
                    BunnyUtils.prepareTextField(
                        betaTextField,
                        placeholderText: budgetModel.betaElementTitle,
                        textColor: Constants.Colors.darkGray,
                        model: budgetModel
                    )
                },
                getValue: { () -> String in
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    return (betaTextField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()
                        )
                    )!
                },
                performAction: {
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    betaTextField.becomeFirstResponder()
                }
            )
            
            // Budget Category
            self.addCellType(
                Constants.CellIdentifiers.addBudgetCategory,
                completion: {
                    let categoryModel = self.model as! DoubleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaLabel = self.betaUIElement as! UILabel
                    
                    alphaLabel.text = categoryModel.alphaElementTitle
                    betaLabel.text = categoryModel.betaElementTitle
                    betaLabel.textColor = Constants.Colors.expenseColor
                    
                    alphaLabel.adjustsFontSizeToFitWidth = true
                    betaLabel.adjustsFontSizeToFitWidth = true
                },
                getValue: { () -> String in
                    return ""
                },
                performAction: {
                    (self.delegate as! AddEditBudgetDelegate).displayCategoryCellActions()
                }
            )
            
            // Amount ($) [ 1234.00 ], Title [ (optional) ]
            self.addCellType(
                Constants.CellIdentifiers.transactionFieldValueTextField,
                completion: {
                    let budgetModel = self.model as! DoubleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    
                    guard let textColor = budgetModel.cellSettings[Constants.AppKeys.keyTextColor] else {
                        return
                    }
                    
                    alphaLabel.text = budgetModel.alphaElementTitle
                    BunnyUtils.prepareTextField(
                        betaTextField,
                        placeholderText: budgetModel.betaElementTitle,
                        textColor: textColor as! UIColor,
                        model: budgetModel
                    )
                },
                getValue: { () -> String in
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    return (betaTextField.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()
                        )
                        )!
                },
                performAction: {
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    betaTextField.becomeFirstResponder()
                }
            )
            
            // Transaction field value (e.g. "Income Category: Salary")
            self.addCellType(
                Constants.CellIdentifiers.transactionFieldValue,
                completion: {
                    let transactionModel = self.model as! DoubleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaLabel = self.betaUIElement as! UILabel
                    
                    alphaLabel.text = transactionModel.alphaElementTitle
                    betaLabel.text = transactionModel.betaElementTitle
                    
                    let tintColor = transactionModel.cellSettings[Constants.AppKeys.keyTint]
                    let accessoryType = transactionModel.cellSettings[Constants.AppKeys.keyTableCellAccessoryType]
                    
                    if (tintColor != nil) {
                        betaLabel.textColor = tintColor as! UIColor
                    }
                    
                    if (accessoryType != nil) {
                        self.accessoryType = accessoryType as! UITableViewCellAccessoryType
                    }
                    
                }, getValue: { () -> String in
                    return ""
                }, performAction: {
                    self.cellAction()
                }
            )
        }
    }
    
    private func cellAction() {
        let actionModel = model as! SingleElementCell
        self.performSelector(
            Selector(
                actionModel.cellSettings[Constants.AppKeys.keySelector] as! String
            )
        )
    }
    
    private func test() {
        print("TEST")
    }
}
