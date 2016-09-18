//
//  BudgetTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/4/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell,  BunnyTableViewCellProtocol {

    @IBOutlet weak var budgetName: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var remainingAmount: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var progressHeight: NSLayoutConstraint!
    var model: BudgetCell?
    
    func prepareTableViewCell(model: BunnyCell) {
        let budgetModel = model as! BudgetCell
        self.model = budgetModel
        
        // Set the labels
        self.budgetName.text = budgetModel.alphaElementTitle
        self.totalAmount.text = budgetModel.gammaElementTitle
        self.remainingAmount.text = budgetModel.betaElementTitle
        
        // Set label overflow
        self.budgetName.adjustsFontSizeToFitWidth = true
        self.totalAmount.adjustsFontSizeToFitWidth = true
        self.remainingAmount.adjustsFontSizeToFitWidth = true
        
        // Set the progress bar
        let percentage = Float(budgetModel.remainingAmount/budgetModel.budgetAmount)
        self.progressBar.progress = percentage
        self.progressBar.layer.cornerRadius = 5.0
        self.progressBar.layer.masksToBounds = true
        self.progressHeight.constant = 10.0
        
        // Set progress bar tint
        var tintColor = Constants.Colors.normalGreen
        var trackTintColor = Constants.Colors.normalGreen.colorWithAlphaComponent(0.25)
        if percentage <= ScreenConstants.Budget.dangerPercentage {
            tintColor = Constants.Colors.dangerColor
            trackTintColor = Constants.Colors.dangerColor.colorWithAlphaComponent(0.25)
        }
        else if percentage <= ScreenConstants.Budget.weakenedPercentage {
            tintColor = Constants.Colors.weakenedColor
            trackTintColor = Constants.Colors.weakenedColor.colorWithAlphaComponent(0.25)
        }
        self.progressBar.tintColor = tintColor
        self.progressBar.trackTintColor = trackTintColor
        
        // Selection color
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.lightGreen
        self.selectedBackgroundView = selectionColor
    }
}
