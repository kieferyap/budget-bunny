//
//  AddEditAccountTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/18/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

protocol PushViewControllerDelegate: class {
    func pushViewController(destinationViewController: UIViewController, isAnimated: Bool)
}

class AddEditAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var accountSwitch: UISwitch!
    var model: AddEditAccountCell = AddEditAccountCell()
    weak var delegate:PushViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setAccountModel(accountModel: AddEditAccountCell) {
        self.model = accountModel
        
        let selectionColor = UIView()
        selectionColor.backgroundColor = UIColor.whiteColor()
        
        field?.text = accountModel.field
        let placeholderText = accountModel.placeholder
        
        if (accountModel.cellIdentifier == Constants.CellIdentifiers.AddAccountFieldValue) {
            self.textfield.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: nil)
        }
        
        else if (accountModel.cellIdentifier == Constants.CellIdentifiers.AddAccountChevron) {
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            selectionColor.backgroundColor = Constants.Colors.LightGreen
            self.value?.text = placeholderText
        }
        
        else if (accountModel.cellIdentifier == Constants.CellIdentifiers.AddAccountSwitch) {
            self.information?.text = placeholderText
        }
        
        self.selectedBackgroundView = selectionColor;
    }
    
    func performAction() {

        if (self.model.cellIdentifier == Constants.CellIdentifiers.AddAccountFieldValue) {
            self.textfield.becomeFirstResponder()
        }
            
        else if (self.model.cellIdentifier == Constants.CellIdentifiers.AddAccountChevron) {
            let destinationViewController = CurrencyPickerTableViewController()
            delegate?.pushViewController(destinationViewController, isAnimated: true)
        }
            
        else if (self.model.cellIdentifier == Constants.CellIdentifiers.AddAccountSwitch) {
            self.accountSwitch.setOn(!accountSwitch.on, animated: true)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
