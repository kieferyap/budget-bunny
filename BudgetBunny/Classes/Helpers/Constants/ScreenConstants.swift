struct ScreenConstants {
    struct Account {
        static let sectionCount = 1
        static var accountMaxCount = 20 //var because it's changed during testing
        static let idxAccountSection = 0
    }
    struct AddEditAccount {
        static let idxAccountInfoSection = 0
        static let idxNameCell = 0
        static let idxCurrencyCell = 1
        static let idxAmountCell = 2
        
        static let idxAccountActionsSection = 1
        static let idxDefaultCell = 0
        static let idxDeleteCell = 1
        
        static let sectionCount = 2
        static let accountNameMaxLength = 25
        static let initialAmountMaxLength = 15
        
        static let defaultCellHeight = 44.0
        static let accountCellHeight = 60.0
        
        static let keyHeight = "height"
        
        static let selectorDelete = "deleteAccount"
        static let selectorSetDefault = "setDefault"
        static let separatorCountryCode = ": "
        static let separatorCodeSymbol = " ("
        static let separatorSymbol = ")"
    }
    struct Currency {
        static let sectionCount = 1
        static let countrySearchParameter = "SELF.country CONTAINS[c] %@ OR "
        static let codeSearchParameter = "SELF.currencyCode CONTAINS[c] %@ OR "
        static let symbolSearchParameter = "SELF.currencySymbol CONTAINS[c] %@"
    }
    struct Budget {
        static let idxMonthly = 0
        static let idxWeekly = 1
        static let idxDaily = 2
        
        static let sectionCount = 2
        static let idxBudgetSection = 0
        static let idxIncomeSection = 1
        
        static let weakenedPercentage: Float = 0.5
        static let dangerPercentage: Float = 0.25
        
        static var incomeMaxCount = 20
        static let incomeNameMaxLength = 25
        
        static var budgetMaxCount = 20
        static let selectorAddNewIncome = "presentNewIncomeAlert"
    }
    struct AddEditBudget {
        static let sectionCount = 2
        static let sectionCountWithDelete = 3
        
        static let idxInformationGroup = 0
        static let idxCategoryGroup = 1
        static let idxActionsGroup = 2
        
        static let idxNameCell = 0
        static let idxAmountCell = 1
        static let idxDeleteCell = 0
        
        static let budgetNameMaxLength = 25
        static let budgetAmountMaxLength = 15
        static let categoryNameMaxLength = 25
        
        static var categoryMaxCount = 20
        
        static let selectorDelete = "deleteBudget"
    }
    struct AddTransaction {
        static let sectionCount = 3
        static let sectionCountMore = 4
        
        static let idxTransactionInformation = 0
        static let idxTypeInformation = 1
        static let idxOtherActions = 2
        
        static let idxTransactionDetails = 2
        static let idxOtherActionsMore = 3
        
        static let idxAmountCell = 0
        static let idxNameCell = 1
        static let idxTypeSegmentControlCell = 2
        
        static let idxTransactionInfoCell = 0
        
        static let idxSaveTransactionCell = 0
        static let idxSaveAddProfile = 1
        static let idxShowMoreDetailsCell = 2
        
        static let idxAccountCell = 0
        static let idxRecurringExpenseCell = 1
        static let idxRepeatEveryCell = 2
        
        static let transactionNameMaxCount = 30
        static let transactionAmountMaxCount = 10
        
        static let segmentedControlIdxExpense = 0
        static let segmentedControlIdxIncome = 1
        static let segmentedControlIdxTransfer = 2
        
        static let segmentedControlIdxNew = 0
        static let segmentedControlIdxProfile = 1
        static let segmentedControlIdxRecurring = 2
        
        static let selectorSaveTransaction = "saveTransaction"
        static let selectorSaveAndAddAsProfile = "saveAndAddAsProfile"
        static let selectorShowMoreDetails = "showMoreDetails"
    }
}