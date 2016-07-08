//
//  DoubleLabelTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class DoubleLabelTableViewCell: UITableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    var model: DoubleLabelCell?
    
    func setModelObject(modelObject: BunnyCell) {
        let doubleCellModel = modelObject as! DoubleLabelCell
        self.model = doubleCellModel
        
        switch doubleCellModel.cellIdentifier {
        case Constants.CellIdentifiers.budgetIncome:
            self.titleLabel.text = doubleCellModel.labelTitle
            self.valueLabel.text = doubleCellModel.labelValue
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            break
        default:
            break
        }
        
        // Selection color
        let selectionColor = UIView()
        selectionColor.backgroundColor = Constants.Colors.lightGreen
        self.selectedBackgroundView = selectionColor
    }
    
    func performAction() {
        switch self.model!.cellIdentifier {
        case Constants.CellIdentifiers.budgetIncome:
            break
        default:
            break
        }
    }
}
