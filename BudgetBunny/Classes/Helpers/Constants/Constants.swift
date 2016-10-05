import UIKit

struct Constants {
    struct Colors {
        static let darkGreen = UIColor(red: 38.0/255.0, green: 166.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        static let darkGray = UIColor(red: 108.0/255.0, green: 132.0/255.0, blue: 137.0/255.0, alpha: 1.0)
        static let normalGreen = UIColor(red: 0.0/255.0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        static let dangerColor = UIColor(red: 236.0/255.0, green: 100.0/255.0, blue: 75.0/255.0, alpha: 1.0)
        static let lightGreen = UIColor(red: 200.0/255.0, green: 247.0/255.0, blue: 197.0/255.0, alpha: 1.0)
        static let weakenedColor = UIColor(red: 245.0/255.0, green: 171.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        
        static let incomeColor = UIColor(red: 124.0/255.0, green: 179.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        static let expenseColor = UIColor(red: 211.0/255.0, green: 84.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }
    struct CellIdentifiers {
        static let anyCellIdentifier = ""
        static let addAccountFieldValue = "addAccountFieldValueCell"
        static let addAccountChevron = "addAccountChevronCell"
        static let addAccountAction = "addAccountActionCell"
        static let addAccountCurrency = "addAccountCurrencyCell"
        static let addAccountSwitch = "addAccountSwitchCell"
        static let account = "accountCell"
        
        static let addBudgetFieldValue = "addBudgetFieldValueCell"
        static let addBudgetCategory = "addBudgetCategoryCell"
        static let addBudgetNewCategory = "addBudgetNewCategoryCell"
        static let addBudgetAction = "addBudgetActionCell"
        static let budget = "budgetCell"
        static let incomeCategory = "incomeCategoryCell"
        static let addIncomeCategory = "addIncomeCategoryCell"
        static let budgetInexistence = "budgetInexistenceCell"
    }
    struct SourceInformation {
        static let accountNew = 0
        static let accountEditing = 1
        
        static let budgetNew = 0
        static let budgetEditing = 1
    }
    struct ViewControllers {
        static let addEditAccount = "AddEditAccountTableViewController"
        static let addEditBudget = "AddEditBudgetTableViewController"
        static let currencyPickerTable = "CurrencyPickerTableViewController"
        
        static let addAccountNavigation = "addAccountNavigationController"
        static let addBudgetNavigation = "addBudgetNavigationController"
    }
    struct KeyboardTypes {
        static let alphanumeric = 0
        static let decimal = 1
    }
    struct AppKeys {
        // Textfield constants
        static let keyKeyboardType = "keyboardType"
        static let keyMaxLength = "maxLength"
        static let keyTextFieldValue = "value"
        // Button constants
        static let keySelector = "selector"
        static let keyEnabled = "enabled"
        static let keyButtonColor = "color"
        static let keyManagedObject = "managedObject"
        // Navigation bar localization keys
        static let tabBarKeys = [
            "MENULABEL_ACCOUNT",
            "MENULABEL_BUDGETS",
            "MENULABEL_DASHBOARD",
            "MENULABEL_RECORDS"
        ]
    }
    struct App {
        static let trueString = "1"
        static let falseString = "0"
    }
    struct Storyboards {
        static let mainStoryboard = "Main"
    }
}