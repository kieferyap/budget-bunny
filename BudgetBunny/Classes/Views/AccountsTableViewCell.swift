//
//  AccountsTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/12/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {

    @IBOutlet weak var isDefaultLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var isDefaultLabelWidth: NSLayoutConstraint!
    
    var model: AccountCell?
    
    func setAccountModel(model: AccountCell) {
        
        // Prepare UI elements
        let defaultString = BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_DEFAULT)
        self.model = model
        let isDefaultText = model.isDefault == true ? defaultString : ""
        let accountName = model.accountName
        let amount = model.amount
        
        // Set UI elements
        self.isDefaultLabel.text = isDefaultText
        self.accountNameLabel.text = accountName
        self.amountLabel.text = amount
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        // Colors
        self.isDefaultLabelWidth.constant = 0.0
        self.amountLabel.textColor = Constants.Colors.DarkGray
        if isDefaultText != "" {
            self.isDefaultLabel.layer.cornerRadius = 6.0
            self.isDefaultLabel.layer.masksToBounds = true
            self.isDefaultLabel.layer.borderWidth = 2.0
            self.isDefaultLabel.layer.borderColor = Constants.Colors.DarkGreen.CGColor
            self.isDefaultLabel.textColor = Constants.Colors.DarkGreen
            self.isDefaultLabelWidth.constant = 75.0
        }
        
        // Text overflow
        self.accountNameLabel.adjustsFontSizeToFitWidth = true
        self.amountLabel.adjustsFontSizeToFitWidth = true
        
        // Selection color
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.LightGreen
        self.selectedBackgroundView = selectionColor;
    }
    
    
}
