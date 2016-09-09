//
//  SingleElementTableViewCell.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/9/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class SingleElementTableViewCell: BunnyTableViewCell, BunnyTableViewCellProtocol {

    @IBOutlet weak var alphaUIElement: UIView!
    
    func prepareTableViewCell(model: BunnyCell) {
        super.prepareTableViewCell(model) {
            
            // "Set as Default", "Delete Account" in the edit account screen
            self.addCellType(
                Constants.CellIdentifiers.addAccountAction,
                completion: {
                    let buttonModel = self.model as! SingleElementCell
                    let alphaButton = self.alphaUIElement as! UIButton
                    
                    BunnyUtils.prepareButton(
                        alphaButton,
                        text: buttonModel.alphaElementTitle,
                        model: buttonModel,
                        target: self
                    )
                },
                getValue: {
                    // A button does not have a return value
                    return ""
                },
                performAction:  {
                    let buttonModel = model as! SingleElementCell
                    self.performSelector(
                        Selector(
                            buttonModel.cellSettings[Constants.AppKeys.keySelector] as! String
                        )
                    )
                }
            )
            
            // "Add new income" cell in the Budget Screen
            self.addCellType(
                Constants.CellIdentifiers.addIncome,
                completion: {
                    let budgetModel = self.model as! SingleElementCell
                    let alphaButton = self.alphaUIElement as! UIButton
                    
                    BunnyUtils.prepareButton(alphaButton,
                        text: budgetModel.alphaElementTitle,
                        model: budgetModel,
                        target: self
                    )
                },
                getValue: { () -> String in
                    return ""
                },
                performAction: {
                    let buttonModel = model as! SingleElementCell
                    self.performSelector(
                        Selector(
                            buttonModel.cellSettings[Constants.AppKeys.keySelector] as! String
                        )
                    )
                }
            )
            
            // "No Income Categories"/"No Budgets" cells in the Budget Screen
            self.addCellType(
                Constants.CellIdentifiers.budgetInexistence,
                completion: {
                    let noBudgetModel = self.model as! SingleElementCell
                    let alphaLabel = self.alphaUIElement as! UILabel
                    alphaLabel.text = noBudgetModel.alphaElementTitle
                    self.userInteractionEnabled = false
                },
                getValue: { () -> String in
                    return ""
                },
                performAction: {
                }
            )
            
            // Adding a new budget category
            self.addCellType(
                Constants.CellIdentifiers.addBudgetNewCategory,
                completion: {
                    let budgetModel = self.model as! SingleElementCell
                    let alphaTextField = self.alphaUIElement as! BunnyTextField
                    alphaTextField.text = ""
                    
                    BunnyUtils.prepareTextField(
                        alphaTextField,
                        placeholderText: budgetModel.alphaElementTitle,
                        textColor: Constants.Colors.darkGray,
                        model: budgetModel
                    )
                    alphaTextField.returnCompletion = { (text) in
                        (self.delegate as! AddEditBudgetDelegate).addNewCategory(text)
                    }
                },
                getValue: { () -> String in
                    return ""
                },
                performAction: {
                    let alphaTextField = self.alphaUIElement as! BunnyTextField
                    alphaTextField.becomeFirstResponder()
                }
            )
        }
    }
    
    // Button selectors
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
                    (self.delegate as! AddEditAccountDelegate).setAsDefault()
                }
            }
        })
    }
    
    func deleteAccount() {
        BunnyUtils.keyExistsForCellSettings(self.model!, key: Constants.AppKeys.keyEnabled, completion: { (object) in
            let isEnabled = object as! Bool
            if isEnabled {
                BunnyUtils.keyExistsForCellSettings(self.model!, key: ScreenConstants.AddEditAccount.keyManagedObject) { (object) in
                    (self.delegate as! AddEditAccountDelegate).deleteAccount(object as! NSManagedObject)
                }
            }
        })
    }
    
    func presentNewIncomeAlert() {
        (self.delegate as! BudgetDelegate).presentNewIncomeAlert()
    }
    
}
