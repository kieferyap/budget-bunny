//
//  AddEditAccountTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/18/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import CoreData
import UIKit

class AddEditAccountTableViewCell: UITableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var textfield: BunnyTextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var accountSwitch: UISwitch!
    var model: AddEditAccountCell?
    weak var delegate:AddEditAccountDelegate?

    func setModelObject(modelObject: BunnyCell) {
        let accountModel = modelObject as! AddEditAccountCell
        self.model = accountModel
        
        let selectionColor = UIView()
        selectionColor.backgroundColor = UIColor.whiteColor()
        
        let fieldText = accountModel.field
        let placeholderText = accountModel.placeholder
        
        switch accountModel.cellIdentifier {
        case Constants.CellIdentifiers.addAccountFieldValue:
            self.field.text = fieldText
            BunnyUtils.prepareTextField(
                self.textfield,
                placeholderText: placeholderText,
                textColor: Constants.Colors.darkGray,
                model: accountModel
            )
            break
            
        case Constants.CellIdentifiers.addAccountChevron:
            self.field.text = fieldText
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            selectionColor.backgroundColor = Constants.Colors.lightGreen
            self.value.text = placeholderText
            self.value.adjustsFontSizeToFitWidth = true
            self.value.textColor = Constants.Colors.darkGray
            break
            
        case Constants.CellIdentifiers.addAccountAction:
            BunnyUtils.prepareButton(
                self.actionButton,
                text: fieldText,
                model: accountModel,
                target: self
            )
            break
            
        case Constants.CellIdentifiers.addAccountSwitch:
            self.field.text = fieldText
            self.value.text = placeholderText
            self.value.adjustsFontSizeToFitWidth = true

        default:
            break
        }
        
        self.selectedBackgroundView = selectionColor;
    }
    
    func performAction() {
        switch self.model!.cellIdentifier {
        case Constants.CellIdentifiers.addAccountFieldValue:
            self.textfield.becomeFirstResponder()
            break
            
        case Constants.CellIdentifiers.addAccountChevron:
            self.delegate?.pushCurrencyViewController()
            break
            
        case Constants.CellIdentifiers.addAccountAction:
            self.actionButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            break
            
        case Constants.CellIdentifiers.addAccountSwitch:
            self.accountSwitch.setOn(!accountSwitch.on, animated: true)
            break
            
        default:
            break
        }
    }
    
    func setDefault() {
        BunnyUtils.keyExistsForCellSettings(self.model!, key: Constants.AppKeys.keyEnabled, completion: { (object) in
            let isEnabled = object as! Bool
            if isEnabled {
                BunnyUtils.keyExistsForCellSettings(self.model!, key: ScreenConstants.AddEditAccount.keyManagedObject) { (object) in
                    let managedObject = object as! NSManagedObject
                    let activeRecord = BunnyModel.init(tableName: ModelConstants.Entities.account)
                    activeRecord.selectAllObjects({ (fetchedObjects) -> Void in
                        // For each element
                        for object in fetchedObjects {
                            // If the element is the currently selected element, set isDefault to true.
                            if object == managedObject {
                                object.setValue(true, forKey: ModelConstants.Account.isDefault)
                            }
                                
                            // Else, if the element is the previously default account, set isDefault to false.
                            else if object.valueForKey(ModelConstants.Account.isDefault) as! Bool == true {
                                object.setValue(false, forKey: ModelConstants.Account.isDefault)
                            }
                        }
                        
                        // Save the model, reload the data, etc.
                        activeRecord.save()
                    })
                    self.delegate?.setAsDefault()
                }
            }
        })
    }
    
    func deleteAccount() {
        BunnyUtils.keyExistsForCellSettings(self.model!, key: Constants.AppKeys.keyEnabled, completion: { (object) in
            let isEnabled = object as! Bool
            if isEnabled {
                let alertController = AccountUtils.accountDeletionPopup({
                    BunnyUtils.keyExistsForCellSettings(self.model!, key: ScreenConstants.AddEditAccount.keyManagedObject) { (object) in
                        let activeRecord = BunnyModel.init(tableName: ModelConstants.Entities.account)
                        activeRecord.deleteObject(object as! NSManagedObject, completion: {
                            self.delegate?.popViewController()
                        })
                    }
                })
                self.delegate?.presentViewController(alertController)
            }
        })
    }
    
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

}
