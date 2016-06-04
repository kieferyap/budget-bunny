//
//  BunnyUtils.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/26/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class BunnyUtils: NSObject {

    // Returns an uncommented localized string, given the key. The comments are normally used for your localization team, but, well...)
    class func uncommentedLocalizedString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    // When called, this method adds a listener in the view controller which dismisses the keyboard whenever places other than the keyboard (or the textarea/textfield) have been tapped. Pretty handy, huh?
    class func addKeyboardDismisserListener(viewController: UIViewController) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: viewController, action:#selector(UIViewController.dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        viewController.view.addGestureRecognizer(tapRecognizer)
    }
    
    // The table cells can be customized by slapping on a special NSDictionary. This method simply checks if the cells' dictionary possess the specified key, and executes a completion handler if it does.
    class func keyExistsForCellSettings(cell: BunnyCell, key: String, completion: (object: AnyObject) -> Void) {
        if cell.cellSettings[key] != nil {
            completion(object: cell.cellSettings[key]!)
        }
    }
    
    // Method name is self-explanatory. I'm not a huge fan of the whole Copy-Paste Design Pattern, so this factory method will have to do. When summoned, this method will deal 65536 damage to all your enemies.
    class func showAlertWithOKButton(viewController: UIViewController, title: String, message: String) {
        let okMessage = BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_OK)
        
        let alertController = UIAlertController.init(title: title,
                                                message: message,
                                         preferredStyle: UIAlertControllerStyle.Alert)

        let okAction = UIAlertAction.init(title: okMessage, style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(okAction)
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // This is one of my favorite methods. It basically checks if the table has anything in it. If it doesn't, it tells the table view to display a certain text. (Think, "No files found.") Else, it returns the number of table rows.
    class func tableRowsWithLoadingTitle(titleKey: String, tableModel: NSArray, tableView: UITableView, completion: () -> Int) -> Int {
        
        let emptyTableLabel = UILabel.init(frame: CGRectMake(0, 0, tableView.bounds.size.height, tableView.bounds.size.width))
        var labelString: String = BunnyUtils.uncommentedLocalizedString(titleKey)
        var rows: Int = 0
        var separatorStyle = UITableViewCellSeparatorStyle.None
        var isTableScrollable = false
        
        if tableModel.count > 0 {
            labelString = ""
            separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            isTableScrollable = true
            
            rows = completion()
        }
        
        // Set empty table label
        emptyTableLabel.text = labelString
        emptyTableLabel.textAlignment = NSTextAlignment.Center
        emptyTableLabel.sizeToFit()
        emptyTableLabel.numberOfLines = 0
        emptyTableLabel.textColor = UIColor.lightGrayColor()
        
        // Add table label to table view's background view
        tableView.backgroundView = emptyTableLabel
        tableView.separatorStyle = separatorStyle
        tableView.scrollEnabled = isTableScrollable
        
        return rows
    }
    
    class func preserveValue(value: NSObject, completion: () -> Void) -> NSObject {
        let temporaryValue = value
        completion()
        return temporaryValue
    }
    
}
