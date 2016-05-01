//
//  AccountViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = BunnyUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ACCOUNT)
        self.tempPrintAccounts()
        // Do any additional setup after loading the view.
    }
    
    func tempPrintAccounts() {
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Transaction")
        var accounts = [NSManagedObject]()
        
        //3
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            accounts = results as! [NSManagedObject]
            
            for account in accounts {
                print(account.valueForKey("amount"))
            }
            
            print(accounts)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
