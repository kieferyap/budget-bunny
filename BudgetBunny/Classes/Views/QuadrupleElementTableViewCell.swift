//
//  QuadrupleElementTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/10/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class QuadrupleElementTableViewCell: BunnyTableViewCell, BunnyTableViewCellProtocol {
    
    @IBOutlet weak var alphaUIElement: UIView!
    @IBOutlet weak var betaUIElement: UIView!
    @IBOutlet weak var gammaUIElement: UIView!
    @IBOutlet weak var deltaUIElement: UIView!
    
    func prepareTableViewCell(model: BunnyCell) {
        super.prepareTableViewCell(model) {
            // Transaction field value (e.g. "Income Category: Salary")
            self.addCellType(
                Constants.CellIdentifiers.transactionDoubleFieldValue,
                completion: {
                    let transactionModel = self.model as! QuadrupleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    let betaLabel = self.betaUIElement as! UILabel
                    let gammaLabel = self.gammaUIElement as! UILabel
                    let deltaLabel = self.deltaUIElement as! UILabel
                    
                    alphaLabel.text = transactionModel.alphaElementTitle
                    betaLabel.text = transactionModel.betaElementTitle
                    gammaLabel.text = transactionModel.gammaElementTitle
                    deltaLabel.text = transactionModel.deltaElementTitle
                    
                    let tintColor = transactionModel.cellSettings[Constants.AppKeys.keyTint]
                    let accessoryType = transactionModel.cellSettings[Constants.AppKeys.keyTableCellAccessoryType]
                    
                    if (tintColor != nil) {
                        gammaLabel.tintColor = tintColor as! UIColor
                        deltaLabel.tintColor = tintColor as! UIColor
                    }
                    
                    if (accessoryType != nil) {
                        self.accessoryType = accessoryType as! UITableViewCellAccessoryType
                    }
                    
                }, getValue: { () -> String in
                    return ""
                }, performAction: {
                    self.cellAction()
                }
            )
        }
    }
    
    private func cellAction() {
        let actionModel = model as! SingleElementCell
        self.performSelector(
            Selector(
                actionModel.cellSettings[Constants.AppKeys.keySelector] as! String
            )
        )
    }
    
    private func test() {
        print("TEST")
    }
}
