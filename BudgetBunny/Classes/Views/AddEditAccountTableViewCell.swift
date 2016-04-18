//
//  AddEditAccountTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/18/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class AddEditAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var isDefaultSwitch: UISwitch!
    var accountModel: AddEditAccountCell = AddEditAccountCell()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setAccountModel(accountModel: AddEditAccountCell) {
        NSLog("Got in AccountModel setter.");
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
