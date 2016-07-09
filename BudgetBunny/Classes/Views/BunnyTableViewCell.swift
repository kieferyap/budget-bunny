//
//  BunnyTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/9/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

protocol BunnyTableViewCellProtocol: class {
    func prepareTableViewCell(model: BunnyCell)
}

class BunnyTableViewCell: UITableViewCell {

    var cellActions: [(cellIdentifier: String, completion: () -> Void, getValue: () -> String)] = []
    var model: BunnyCell!
    var delegate: AnyObject!
    
    func prepareTableViewCell(model: BunnyCell, completion: () -> Void) {
        self.setSelectedBackgroundColor(UIColor.whiteColor())
        self.model = model
        completion()
        self.checkForCellTypes(model.cellIdentifier)
    }
    
    func addCellType(cellIdentifier: String, completion: () -> Void, getValue: () -> String) {
        self.cellActions.append((cellIdentifier: cellIdentifier, completion: completion, getValue: getValue))
    }
    
    func setSelectedBackgroundColor(color: UIColor) {
        let selectionColor = UIView()
        selectionColor.backgroundColor = color
        self.selectedBackgroundView = selectionColor
    }
    
    func getValue(cellIdentifier: String) -> String {
        for action in self.cellActions {
            if action.cellIdentifier == cellIdentifier {
                return action.getValue()
            }
        }
    }
    
    private func checkForCellTypes(cellIdentifier: String) {
        for action in self.cellActions {
            if action.cellIdentifier == cellIdentifier {
                action.completion()
                break
            }
        }
    }
    
}
