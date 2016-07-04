//
//  AddEditBudgetTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/25/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class AddEditBudgetTableViewCell: UITableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var textfield: BunnyTextField!
    var model: AddEditBudgetCell?
    weak var delegate:AddEditBudgetDelegate?
    
    func setModelObject(modelObject: BunnyCell) {
        let budgetModel = modelObject as! AddEditBudgetCell
        self.model = budgetModel
        
        let selectionColor = UIView()
        selectionColor.backgroundColor = UIColor.whiteColor()
        
        let fieldText = budgetModel.field
        let placeholderText = budgetModel.placeholder
        
        switch budgetModel.cellIdentifier {
            
        case Constants.CellIdentifiers.addBudgetFieldValue:
            self.field.text = fieldText
            BunnyUtils.prepareTextField(
                self.textfield,
                placeholderText: placeholderText,
                textColor: Constants.Colors.darkGray,
                model: budgetModel
            )
            break
            
        case Constants.CellIdentifiers.addBudgetCategory:
            self.field.text = fieldText
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            break
            
        case Constants.CellIdentifiers.addBudgetNewCategory:
            self.textfield.text = ""
            BunnyUtils.prepareTextField(
                self.textfield,
                placeholderText: placeholderText,
                textColor: Constants.Colors.darkGray,
                model: budgetModel
            )
            self.textfield.returnCompletion = { (text) in
                self.delegate?.addNewCategory(text)
            }
            break
            
        default:
            break
        }
        
        self.selectedBackgroundView = selectionColor
    }
    
    func performAction() {
        switch self.model!.cellIdentifier {
            
        case Constants.CellIdentifiers.addBudgetFieldValue:
            self.textfield.becomeFirstResponder()
            break
            
        case Constants.CellIdentifiers.addBudgetCategory:
            // Once tapped, the category will be editable and deletable
            break
            
        case Constants.CellIdentifiers.addBudgetNewCategory:
            self.textfield.becomeFirstResponder()
            break
            
        default:
            break
        }
    }
}
