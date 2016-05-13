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
    @IBOutlet weak var symbol: UILabel!
    @IBOutlet weak var amount: UILabel!
    var model: AccountCell?
    
    func setAccountModel(model: AccountCell) {
        // Set selected color
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.LightGreen
        self.selectedBackgroundView = selectionColor;
        
        // Prepare UI elements
        self.model = model
        let checkmark = model.isDefault == true ? "C" : ""
        let accountName = model.accountName
        let amount = model.amount
        let symbol = model.currencySymbol
        
        // Set UI elements
        self.checkmark.text = checkmark
        self.accountName.text = accountName
        self.amount.text = amount
        self.symbol.text = symbol
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    
}
