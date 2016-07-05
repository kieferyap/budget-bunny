//
//  IncomeTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class IncomeTableViewCell: UITableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var incomeCategoryLabel: UILabel!
    @IBOutlet weak var incomeAmountLabel: UILabel!
    @IBOutlet weak var addNewIncomeTextfield: BunnyTextField!
    var model: IncomeCell?
    weak var delegate: BudgetDelegate?
    
    func setModelObject(modelObject: BunnyCell) {
        let incomeModel = modelObject as! IncomeCell
        self.model = incomeModel
        
        switch incomeModel.cellIdentifier {
        case Constants.CellIdentifiers.addIncome:
            BunnyUtils.prepareTextField(
                self.addNewIncomeTextfield,
                placeholderText: incomeModel.placeholder,
                textColor: Constants.Colors.darkGray,
                model: incomeModel
            )
            self.addNewIncomeTextfield.returnCompletion = { (text) in
                self.delegate?.addNewIncome(text)
            }
            break
        case Constants.CellIdentifiers.budgetIncome:
            self.incomeCategoryLabel.text = incomeModel.field
            self.incomeAmountLabel.text = incomeModel.value
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            break
        default:
            break
        }
    }
}
