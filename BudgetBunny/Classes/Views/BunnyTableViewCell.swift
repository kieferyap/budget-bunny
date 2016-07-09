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

    var cellActions: [(
        cellIdentifier: String,
        completion: () -> Void,
        getValue: () -> String,
        performAction: () -> Void
    )] = []
    var model: BunnyCell!
    var delegate: AnyObject!
    
    func prepareTableViewCell(model: BunnyCell, completion: () -> Void) {
        self.setSelectedBackgroundColor(UIColor.whiteColor())
        self.model = model
        completion()
        self.checkForCellTypes(model.cellIdentifier)
    }
    
    func addCellType(
        cellIdentifier: String,
        completion: () -> Void,
        getValue: () -> String,
        performAction: () -> Void
    ) {
        self.cellActions.append((
            cellIdentifier: cellIdentifier,
            completion: completion,
            getValue: getValue,
            performAction: performAction
        ))
    }
    
    func setSelectedBackgroundColor(color: UIColor) {
        let selectionColor = UIView()
        selectionColor.backgroundColor = color
        self.selectedBackgroundView = selectionColor
    }
    
    func getValue() -> String {
        for action in self.cellActions {
            if action.cellIdentifier == model.cellIdentifier {
                return action.getValue()
            }
        }
    }
    
    func performAction() {
        for action in self.cellActions {
            if action.cellIdentifier == model.cellIdentifier {
                action.performAction()
                break
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
