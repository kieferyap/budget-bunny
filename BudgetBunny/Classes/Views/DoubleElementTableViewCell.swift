//
//  DoubleElementTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/10/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class DoubleElementTableViewCell: BunnyTableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var alphaUIElement: UIView!
    @IBOutlet weak var betaUIElement: UIView!
    
    func prepareTableViewCell(model: BunnyCell) {
        super.prepareTableViewCell(model) {
            
            self.addCellType(
                Constants.CellIdentifiers.addAccountFieldValue,
                completion: {
                    let accountModel = model as! DoubleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaTextField = self.betaUIElement as! BunnyTextField
                    
                    alphaLabel.text = accountModel.alphaElementTitle
                    BunnyUtils.prepareTextField(
                        betaTextField,
                        placeholderText: accountModel.betaElementTitle,
                        textColor: Constants.Colors.darkGray,
                        model: accountModel
                    )
                    
                    betaTextField.placeholder = accountModel.betaElementTitle
                }
            )
            
            self.addCellType(
                Constants.CellIdentifiers.addAccountChevron,
                completion: {
                    let accountModel = model as! DoubleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaLabel = self.betaUIElement as! UILabel
                    
                    alphaLabel.text = accountModel.alphaElementTitle
                    betaLabel.text = accountModel.betaElementTitle
                    
                    betaLabel.adjustsFontSizeToFitWidth = true
                    betaLabel.textColor = Constants.Colors.darkGray
                    
                    self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
                    self.setSelectedBackgroundColor(Constants.Colors.lightGreen)
                }
            )
            
        }
    }
    
    /*
 
     func getValue() -> String {
     var returnValue: String = ""
     
     switch self.model!.cellIdentifier {
     case Constants.CellIdentifiers.addAccountFieldValue:
     returnValue = self.textfield.text!
     break
     
     case Constants.CellIdentifiers.addAccountSwitch:
     returnValue = self.accountSwitch.on ?
     ScreenConstants.AddEditAccount.trueString :
     ScreenConstants.AddEditAccount.falseString
     break
     
     default:
     break
     }
     
     return returnValue
     }

    */
}
