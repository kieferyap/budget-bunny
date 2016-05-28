import UIKit

struct Constants {
    struct Colors {
        static let normalGreen = UIColor(red: 0.0/255.0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        static let lightGreen = UIColor(red: 200.0/255.0, green: 247.0/255.0, blue: 197.0/255.0, alpha: 1.0)
        static let darkGreen = UIColor(red: 38.0/255.0, green: 166.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        static let darkGray = UIColor(red: 108.0/255.0, green: 132.0/255.0, blue: 137.0/255.0, alpha: 1.0)
        static let dangerColor = UIColor(red: 236.0/255.0, green: 100.0/255.0, blue: 75.0/255.0, alpha: 1.0)
    }
    struct CellIdentifiers {
        static let addAccountFieldValue = "addAccountFieldValueCell"
        static let addAccountChevron = "addAccountChevronCell"
        static let addAccountAction = "addAccountActionCell"
        static let addAccountCurrency = "addAccountCurrencyCell"
        static let addAccountSwitch = "addAccountSwitchCell"
        static let account = "AccountCell"
    }
    struct SourceInformation {
        static let accountNew = 0
        static let accountEditing = 1
    }
    struct ViewControllers {
        static let addEditTable = "AddEditAccountTableViewController"
        static let currencyPickerTable = "CurrencyPickerTableViewController"
    }
    struct Storyboards {
        static let mainStoryboard = "Main"
    }    
}