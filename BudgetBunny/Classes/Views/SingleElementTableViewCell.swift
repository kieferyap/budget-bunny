//
//  SingleElementTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/9/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class SingleElementTableViewCell: BunnyTableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var alphaUIElement: UIView!
    
    func prepareTableViewCell(model: BunnyCell) {
        super.prepareTableViewCell(model) {
            
            self.addCellType(
                Constants.CellIdentifiers.addAccountAction,
                completion: {
                    let accountModel = model as! DoubleElementCell
                    let alphaButton = self.alphaUIElement as! UIButton
                    
                    BunnyUtils.prepareButton(
                        alphaButton,
                        text: accountModel.alphaElementTitle,
                        model: accountModel,
                        target: self
                    )
                }
            )
            
        }
    }
    
}
