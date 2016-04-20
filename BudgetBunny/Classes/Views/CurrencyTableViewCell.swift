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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCurrencyModel(currencyModel: Currency) {
        
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.LightGreen
        
        self.currencyCodeLabel.text = currencyModel.currencyCode
        self.currencySymbolLabel.text = currencyModel.currencySymbol
        self.countryLabel.text = currencyModel.country
        self.model = currencyModel
        self.identifier = currencyModel.identifier
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
