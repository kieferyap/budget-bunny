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

    class func uncommentedLocalizedString(key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    class func addKeyboardDismisserListener(viewController: UIViewController) {
        let tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: viewController, action:#selector(UIViewController.dismissKeyboard))
        tapRecognizer.cancelsTouchesInView = false
        viewController.view.addGestureRecognizer(tapRecognizer)
    }
    
    class func isKeyExistingForAddEditAccountCell(cell: BunnyCell, key: String) -> Bool {
        return cell.cellSettings[key] != nil
    }
    
    class func showAlertWithOKButton(viewController: UIViewController, title: String, message: String) {
        let okMessage = BunnyUtils.uncommentedLocalizedString(StringConstants.LABEL_OK)
        
        let alertController = UIAlertController.init(title: title,
                                                message: message,
                                         preferredStyle: UIAlertControllerStyle.Alert)

        let okAction = UIAlertAction.init(title: okMessage, style: UIAlertActionStyle.Default, handler: nil)
        
        alertController.addAction(okAction)
        viewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
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
    
    class func setAllValues(tableName: String, managedContext: NSManagedObjectContext, key: String, value: NSObject) -> Bool {
        let request = NSFetchRequest()
        request.entity = NSEntityDescription.entityForName(tableName, inManagedObjectContext: managedContext)
        
        do {
            let objects = try managedContext.executeFetchRequest(request) as! [NSManagedObject]
            for object in objects {
                object.setValue(value, forKey: key)
            }
        } catch let error as NSError {
            print("Could not find user: \(error), \(error.userInfo)")
            return false
        }
        
        return true
    }
    
}
