//
//  BunnyTextField.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 6/6/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class BunnyTextField: UITextField, UITextFieldDelegate {

    var type: Int = 0
    var maxLength: Int = 0
    var returnCompletion: (text: String) -> Void = { (text) in return () }
    
    func setKeyboardProperties(type: Int, maxLength: Int, text: String) {
        // UI Testing is underway: disable autocorrect
        let environment = NSProcessInfo.processInfo().environment;
        if environment["isTesting"] == ScreenConstants.AddEditAccount.trueString {
            self.autocorrectionType = UITextAutocorrectionType.No
        }
        
        switch type {
        case Constants.KeyboardTypes.decimal:
            self.keyboardType = UIKeyboardType.DecimalPad
            break
        default:
            self.keyboardType = UIKeyboardType.Alphabet
            break
        }
        
        self.text = ""
        if text != "" {
            self.text = text
        }
        self.type = type
        self.maxLength = maxLength
        self.returnKeyType = UIReturnKeyType.Done
        self.delegate = self
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        
        let newLength = text.characters.count + string.characters.count - range.length
        var shouldChangeCharacter = newLength <= self.maxLength
        
        if self.type == Constants.KeyboardTypes.decimal {
            if text.rangeOfString(".") != nil && string == "." {
                shouldChangeCharacter = false
            }
        }
        
        return shouldChangeCharacter
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.returnCompletion(text: self.text!)
        return true
    }
    
}
