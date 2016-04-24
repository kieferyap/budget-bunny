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
    }
    
    func setCurrencyModel(currencyModel: Currency, selectedCountryName: NSString) {
        // Set selected color
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.LightGreen
        self.selectedBackgroundView = selectionColor;
        
        // Set models
        let countryName = currencyModel.country
        self.model = currencyModel
        self.identifier = currencyModel.identifier
        
        // Set labels
        self.currencyCodeLabel.text = currencyModel.currencyCode
        self.currencySymbolLabel.text = currencyModel.currencySymbol
        self.countryLabel.text = countryName
        
        // Set checkmark
        if selectedCountryName.isEqualToString(countryName) {
            self.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
            self.accessoryType = UITableViewCellAccessoryType.None
        }
    }
}
