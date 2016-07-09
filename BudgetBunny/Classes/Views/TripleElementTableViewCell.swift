//
//  TripleElementTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/10/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class TripleElementTableViewCell: BunnyTableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var alphaUIElement: UIView!
    @IBOutlet weak var betaUIElement: UIView!
    @IBOutlet weak var gammaUIElement: UIView!
    
    func prepareTableViewCell(model: BunnyCell) {
        super.prepareTableViewCell(model) {
            
            self.addCellType(
                Constants.CellIdentifiers.addAccountSwitch,
                completion: {
                    let accountModel = self.model as! TripleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaDescriptionLabel = self.betaUIElement as! UILabel
                    let gammaSwitch = self.gammaUIElement as! UISwitch
                    
                    alphaLabel.text = accountModel.alphaElementTitle
                    betaDescriptionLabel.text = accountModel.betaElementTitle
                    gammaSwitch.on =
                        accountModel.gammaElementTitle == ScreenConstants.AddEditAccount.trueString ?
                        true : false

                }
            )
            
        }
    }
}
