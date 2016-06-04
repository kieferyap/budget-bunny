//
//  AddEditAccountTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/18/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import CoreData
import UIKit

class AddEditAccountTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var field: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var accountSwitch: UISwitch!
    var model: AddEditAccountCell?
    var fieldMaxLength: Int = 0
    weak var delegate:AddEditAccountDelegate?
    let constants = ScreenConstants.AddEditAccount.self
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setAccountModel(accountModel: AddEditAccountCell) {
        self.model = accountModel
        
        let selectionColor = UIView()
        selectionColor.backgroundColor = UIColor.whiteColor()
        
        let fieldText = accountModel.field
        let placeholderText = accountModel.placeholder
        
        switch accountModel.cellIdentifier {
        case Constants.CellIdentifiers.addAccountFieldValue:
            self.field.text = fieldText
            self.textfield.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: nil)
            self.textfield.textColor = Constants.Colors.darkGray
            
            BunnyUtils.keyExistsForCellSettings(accountModel,
                                                key: constants.keyMaxLength,
                                                completion: { (object) in
                self.fieldMaxLength = object as! Int
                self.textfield.delegate = self
            })
            
            BunnyUtils.keyExistsForCellSettings(accountModel,
                                                key: constants.keyTextFieldValue,
                                                completion: { (object) in
                let textValue = object as? String
                if textValue != "" {
                    self.textfield.text = object as? String
                }
            })
            
            let keyboardType = accountModel.cellSettings[constants.keyIsNumpad]
            if keyboardType != nil {
                self.textfield.keyboardType = UIKeyboardType.DecimalPad
            }
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
            self.actionButton.setTitle(fieldText, forState: UIControlState.Normal)
            self.actionButton.exclusiveTouch = true // I have tried everything. BunnyButton crashes, the category doesn't get called, etc. There is no way to set the exclusiveTouch of all UIButtons to true. Welp. Guess I'll have to set EVERY SINGLE BUTTON'S EXCLUSIVE TOUCH TO TRUE THEN. If I don't, users will be able to press two buttons at once and execute BOTH functions at the same time. (which is actually a pretty cool bug if you think about it. Anyway, this comment is getting too long, so I'll stop here.
            
            BunnyUtils.keyExistsForCellSettings(accountModel, key: constants.keyButtonColor, completion: { (object) in
                self.actionButton.tintColor = object as! UIColor
            })
            
            BunnyUtils.keyExistsForCellSettings(accountModel, key: constants.keyEnabled, completion: { (object) in
                let isEnabled = object as! Bool
                self.actionButton.enabled = isEnabled
                
                if isEnabled {
                    let selectorName = self.model!.cellSettings[self.constants.keySelector] as! String
                    self.actionButton.addTarget(self, action: Selector(selectorName), forControlEvents: UIControlEvents.TouchUpInside)
                }
            })
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
        BunnyUtils.keyExistsForCellSettings(self.model!, key: constants.keyEnabled, completion: { (object) in
            let isEnabled = object as! Bool
            if isEnabled {
                BunnyUtils.keyExistsForCellSettings(self.model!, key: self.constants.keyManagedObject) { (object) in
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
        BunnyUtils.keyExistsForCellSettings(self.model!, key: constants.keyEnabled, completion: { (object) in
            let isEnabled = object as! Bool
            if isEnabled {
                let alertController = AccountUtils.accountDeletionPopup({
                    BunnyUtils.keyExistsForCellSettings(self.model!, key: self.constants.keyManagedObject) { (object) in
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
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        var shouldChangeCharacter = newLength <= self.fieldMaxLength
        
        if text.rangeOfString(".") != nil && string == "." {
            shouldChangeCharacter = false
        }
        
        return shouldChangeCharacter
    }

}
