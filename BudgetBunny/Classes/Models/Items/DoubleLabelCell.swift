//
//  DoubleLabelCell
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/3/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DoubleLabelCell: BunnyCell {

    var labelTitle: String = ""
    var labelValue: String = ""
    
    init(labelTitleKey: String, labelValueKey: String, cellIdentifier: String, cellSettings: NSDictionary) {
        super.init(cellIdentifier: cellIdentifier, cellSettings: cellSettings)
        self.labelTitle = BunnyUtils.uncommentedLocalizedString(labelTitleKey)
        self.labelValue = BunnyUtils.uncommentedLocalizedString(labelValueKey)
    }
    
}
