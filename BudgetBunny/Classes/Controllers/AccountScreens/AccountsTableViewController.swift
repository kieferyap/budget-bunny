//
//  AccountViewController.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/13/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit
import CoreData

class AccountsTableViewController: UITableViewController {
    
    var accountTable: [AccountCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = BunnyUtils.uncommentedLocalizedString(StringConstants.MENULABEL_ACCOUNT)
        self.loadData()
    }
    
    func loadData() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Account")
        var accounts = [NSManagedObject]()
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            accounts = results as! [NSManagedObject]
            
            for account in accounts {
                let isDefaultString: String = account.valueForKey("isDefault") as! String
                let currencyIdentifier: String = account.valueForKey("currency") as! String
                let accountName: String = account.valueForKey("name") as! String
                
                let isDefault = isDefaultString == "1" ? true : false
                let currency = Currency()
                currency.setAttributes(currencyIdentifier)
                let currencySymbol = currency.currencySymbol
                
                let amount = ""
                let cellIdentifier = ""
                let cellSettings = [:]
                
                let accountItem = AccountCell(isDefault: isDefault, accountName: accountName, currencySymbol: currencySymbol, amount: amount, cellIdentifier: cellIdentifier, cellSettings: cellSettings)

                self.accountTable.append(accountItem!)
            }
            
            print(accounts)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
//    func tempPrintAccounts() {
//        //1
//        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let managedContext = appDelegate.managedObjectContext
//        
//        //2
//        let fetchRequest = NSFetchRequest(entityName: "Account")
//        var accounts = [NSManagedObject]()
//        
//        //3
//        do {
//            let results = try managedContext.executeFetchRequest(fetchRequest)
//            accounts = results as! [NSManagedObject]
//            
//            for account in accounts {
//                print(account.valueForKey("currency"))
//                print(account.valueForKey("isDefault"))
//                print(account.valueForKey("name"))
//            }
//            
//            print(accounts)
//        } catch let error as NSError {
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 0
//    }
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//       
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
