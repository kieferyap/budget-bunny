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
                    let accountModel = model as! DoubleElementCell
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
                    let accountModel = model as! DoubleElementCell
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
                Constants.CellIdentifiers.budgetIncome,
                completion: {
                    let incomeModel = model as! DoubleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaLabel = self.betaUIElement as! UILabel
                    
                    alphaLabel.text = incomeModel.alphaElementTitle
                    betaLabel.text = incomeModel.betaElementTitle
                    self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                },
                getValue: { () -> String in
                    return ""
                },
                performAction: {
                    // On tap, an alert will show, allowing the user to edit the name of the income category
                }
            )
            
            // Budget name and budget amount in the add budget screen
            self.addCellType(
                Constants.CellIdentifiers.addBudgetFieldValue,
                completion: {
                    let budgetModel = model as! DoubleElementCell
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
            
        }
    }
}
