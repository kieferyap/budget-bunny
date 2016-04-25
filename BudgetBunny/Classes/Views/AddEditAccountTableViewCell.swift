//
//  AddEditAccountTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/18/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

protocol PushViewControllerDelegate: class {
    func pushCurrencyViewController()
}

class AddEditAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var accountSwitch: UISwitch!
    var model = AddEditAccountCell()
    weak var delegate:PushViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setAccountModel(accountModel: AddEditAccountCell) {
        self.model = accountModel
        
        let selectionColor = UIView()
        selectionColor.backgroundColor = UIColor.whiteColor()
        
        self.field?.text = accountModel.field
        let placeholderText = accountModel.placeholder
        
        switch accountModel.cellIdentifier {
        case Constants.CellIdentifiers.AddAccountFieldValue:
            self.textfield.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: nil)
            let keyboardType = accountModel.cellSettings[KEY_IS_NUMPAD]
            if keyboardType != nil {
                self.textfield.keyboardType = UIKeyboardType.DecimalPad
            }
            break
            
        case Constants.CellIdentifiers.AddAccountChevron:
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            selectionColor.backgroundColor = Constants.Colors.LightGreen
            self.value?.text = placeholderText
            break
            
        case Constants.CellIdentifiers.AddAccountSwitch:
            self.information?.text = placeholderText
            break
            
        default:
            break
        }
        
        self.selectedBackgroundView = selectionColor;
    }
    
    func performAction() {
        switch self.model.cellIdentifier {
        case Constants.CellIdentifiers.AddAccountFieldValue:
            self.textfield.becomeFirstResponder()
            break
            
        case Constants.CellIdentifiers.AddAccountChevron:
            self.delegate?.pushCurrencyViewController()
            break
            
        case Constants.CellIdentifiers.AddAccountSwitch:
            self.accountSwitch.setOn(!accountSwitch.on, animated: true)
            break
            
        default:
            break
        }
    }

}
