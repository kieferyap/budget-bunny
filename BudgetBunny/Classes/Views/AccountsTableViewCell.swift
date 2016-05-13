//
//  AccountsTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 5/12/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class AccountsTableViewCell: UITableViewCell {

    @IBOutlet weak var checkmark: UILabel!
    @IBOutlet weak var accountName: UILabel!
    @IBOutlet weak var amount: UILabel!
    var model: AccountCell?
    
    func setAccountModel(model: AccountCell) {
        
        // Prepare UI elements
        self.model = model
        let checkmark = model.isDefault == true ? "✔︎" : ""
        let accountName = model.accountName
        let amount = model.amount
        
        // Set UI elements
        self.checkmark.text = checkmark
        self.accountName.text = accountName
        self.amount.text = amount
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        // UI element
        self.checkmark.textColor = Constants.Colors.NormalGreen
        self.amount.textColor = Constants.Colors.DarkGray
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.LightGreen
        self.selectedBackgroundView = selectionColor;
    }
    
    
}
