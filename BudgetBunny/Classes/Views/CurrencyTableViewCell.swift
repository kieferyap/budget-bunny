//
//  CurrencyTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/20/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencySymbolLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    var model = Currency()
    var identifier: String = ""
    var isDefaultCurrency: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCurrencyModel(currencyModel: Currency, selectedCountryName: NSString) {
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.LightGreen
        let countryName = currencyModel.country
        
        self.currencyCodeLabel.text = currencyModel.currencyCode
        self.currencySymbolLabel.text = currencyModel.currencySymbol
        self.countryLabel.text = countryName
        self.model = currencyModel
        self.identifier = currencyModel.identifier
        
        if selectedCountryName.isEqualToString(countryName) {
            self.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
            self.accessoryType = UITableViewCellAccessoryType.None
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
