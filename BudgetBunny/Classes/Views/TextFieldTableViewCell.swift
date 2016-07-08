//
//  TextFieldTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/8/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var textfield: BunnyTextField!
    var model: TextFieldCell?
    weak var delegate: NSObjectProtocol?
    
    func setModelObject(modelObject: BunnyCell) {
        let textFieldModel = modelObject as! TextFieldCell
        self.model = textFieldModel
        
        let placeholderText = textFieldModel.textFieldPlaceholder
        let textColor = Constants.Colors.darkGray
        
        switch textFieldModel.cellIdentifier {
        case Constants.CellIdentifiers.addIncome:
            BunnyUtils.prepareTextField(
                self.textfield,
                placeholderText: placeholderText,
                textColor: textColor,
                model: textFieldModel
            )
            self.textfield.returnCompletion = { (text) in
                (self.delegate as! BudgetDelegate).addNewIncome(text)
            }
        default:
            break
        }
        
        // Selection color
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.lightGreen
        self.selectedBackgroundView = selectionColor
    }
    
    func performAction() {
        self.textfield.becomeFirstResponder()
        
        switch self.model!.cellIdentifier {
        case Constants.CellIdentifiers.addIncome:
            break
        default:
            break
        }
    }

}
