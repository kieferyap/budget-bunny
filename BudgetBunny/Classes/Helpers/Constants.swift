import UIKit

struct Constants {
    struct Colors {
        static let NormalGreen = UIColor(red: 0.0/255.0, green: 177.0/255.0, blue: 106.0/255.0, alpha: 1.0)
        static let LightGreen = UIColor(red: 200.0/255.0, green: 247.0/255.0, blue: 197.0/255.0, alpha: 1.0)
        static let DarkGreen = UIColor(red: 38.0/255.0, green: 166.0/255.0, blue: 91.0/255.0, alpha: 1.0)
        static let DarkGray = UIColor(red: 108.0/255.0, green: 132.0/255.0, blue: 137.0/255.0, alpha: 1.0)
        static let DangerColor = UIColor(red: 236.0/255.0, green: 100.0/255.0, blue: 75.0/255.0, alpha: 1.0)
    }
    struct CellIdentifiers {
        static let AddAccountFieldValue = "addAccountFieldValueCell"
        static let AddAccountChevron = "addAccountChevronCell"
        static let AddAccountSwitch = "addAccountSwitchCell"
        static let AddAccountCurrency = "addAccountCurrencyCell"
        static let Account = "AccountCell"
    }
    struct ViewControllers {
        static let CurrencyPickerTable = "CurrencyPickerTableViewController"
    }
    struct Storyboards {
        static let MainStoryboard = "Main"
    }
}