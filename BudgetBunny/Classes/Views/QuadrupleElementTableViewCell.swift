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
        
    }
}
