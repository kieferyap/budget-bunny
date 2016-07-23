//
//  UncoveredContentViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 7/23/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class UncoveredContentViewController: UIViewController {
    var activeField: UIView?
    var changedY = false
    var keyboardHeight: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UncoveredContentViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UncoveredContentViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    func keyboardWillShow(sender: NSNotification) {
        let kbSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue().size
        
        keyboardHeight = kbSize!.height
        var aRect = self.view.frame;
        aRect.size.height = aRect.size.height - kbSize!.height - CGFloat(20);
        
        self.view.frame.origin.y -= keyboardHeight
        changedY = true
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if changedY {
            self.view.frame.origin.y += keyboardHeight
        }
        BunnyUtils.delayTask(0.5) {
            self.changedY = false
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    @IBAction func textFieldEditingDidBegin(sender: UITextField){
        activeField = sender
    }
    
    @IBAction func textFieldEditingDidEnd(sender: UITextField) {
        activeField = nil
    }
}