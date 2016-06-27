struct ScreenConstants {
    struct Account {
        static let sectionCount = 1
        static var accountMaxCount = 20
    }
    struct AddEditAccount {
        static let idxAccountInfoGroup = 0
        static let idxNameCell = 0
        static let idxCurrencyCell = 1
        static let idxAmountCell = 2
        
        static let idxAccountActionsGroup = 1
        static let idxDefaultCell = 0
        static let idxDeleteCell = 1
        
        static let accountNameMaxLength = 25
        static let initialAmountMaxLength = 15
        
        static let defaultCellHeight = 44.0
        static let accountCellHeight = 60.0
        
        static let keyHeight = "height"
        static let keyManagedObject = "managedObject"
        
        static let selectorDelete = "deleteAccount"
        static let selectorSetDefault = "setDefault"
        static let separatorCountryCode = ": "
        static let separatorCodeSymbol = " ("
        static let separatorSymbol = ")"
        
        static let trueString = "1"
        static let falseString = "0"
    }
    struct Currency {
        static let sectionCount = 1
        static let countrySearchParameter = "SELF.country CONTAINS[c] %@ OR "
        static let codeSearchParameter = "SELF.currencyCode CONTAINS[c] %@ OR "
        static let symbolSearchParameter = "SELF.currencySymbol CONTAINS[c] %@"
    }
    struct Budget {
        static let monthly = 0
        static let weekly = 1
        static let daily = 2
    }
    struct AddEditBudget {
        static let sectionCount = 2
        static let idxInformationGroup = 0
        static let idxCategoryGroup = 1
        static let idxNameCell = 0
        static let idxAmountCell = 1
        
        static let budgetNameMaxLength = 25
        static let budgetAmountMaxLength = 15
        static let categoryNameMaxLength = 25
    }
}