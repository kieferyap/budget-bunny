import UIKit

struct ModelConstants {
    struct Entities {
        static let account = "Account"
        static let transaction = "Transaction"
        static let budget = "Budget"
        static let category = "Category"
    }
    struct Account {
        static let amount = "amount"
        static let currency = "currency"
        static let isDefault = "isDefault"
        static let name = "name"
    }
    struct TransactionTypes {
        static let expense = 0
        static let income = 1
        static let transfer = 2
        static let resetAmount = 3
    }
    struct Budget {
        static let name = "name"
        static let monthlyBudget = "monthlyBudget"
        static let monthlyRemainingBudget = "monthlyRemainingBudget"
    }
    struct Category {
        static let name = "name"
        static let isIncome = "isIncome"
        static let monthlyAmount = "monthlyAmount"
        static let budgetId = "budgetId"
    }
    struct Record {
    }
    struct Target {
    }
    struct Transaction {
        static let amount = "amount"
        static let datetime = "datetime"
        static let notes = "notes"
        static let type = "type"
        static let accountId = "accountId"
    }
    struct WishItem {
    }
}