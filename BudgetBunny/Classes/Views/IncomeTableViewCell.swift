//
//  IncomeTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class IncomeTableViewCell: UITableViewCell /*, BunnyTableViewCellProtocol*/ {
/*
    @IBOutlet weak var noBudgetLabel: UILabel!
    @IBOutlet weak var incomeCategoryLabel: UILabel!
    @IBOutlet weak var incomeAmountLabel: UILabel!
    @IBOutlet weak var addNewIncomeTextfield: BunnyTextField!
    var model: BunnyCell?
    weak var delegate: BudgetDelegate?
    
    func setModelObject(modelObject: BunnyCell) {
        self.model = modelObject
        
        switch modelObject.cellIdentifier {
        case Constants.CellIdentifiers.addIncome:
            let incomeModel = modelObject as! IncomeCell
            BunnyUtils.prepareTextField(
                self.addNewIncomeTextfield,
                placeholderText: incomeModel.placeholder,
                textColor: Constants.Colors.darkGray,
                model: incomeModel
            )
            self.addNewIncomeTextfield.returnCompletion = { (text) in
                self.delegate?.addNewIncome(text)
            }
        case Constants.CellIdentifiers.budgetIncome:
            let incomeModel = modelObject as! IncomeCell
            self.incomeCategoryLabel.text = incomeModel.field
            self.incomeAmountLabel.text = incomeModel.value
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        case Constants.CellIdentifiers.budgetInexistence:
            let inexistenceModel = modelObject as! NoBudgetCell
            self.noBudgetLabel.text = inexistenceModel.noBudgetString
        default:
            break
        }
        
        // Selection color
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.lightGreen
        self.selectedBackgroundView = selectionColor
    }
    
    func performAction() {
        switch self.model!.cellIdentifier {
        case Constants.CellIdentifiers.addIncome:
            self.addNewIncomeTextfield.becomeFirstResponder()
            break
        case Constants.CellIdentifiers.budgetIncome:
            break
        default:
            break
        }
    }
 */
}
