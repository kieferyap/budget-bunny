import UIKit

struct ModelConstants {
    struct Entities {
        static let account = "Account"
        static let transaction = "Transaction"
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
    }
    struct Category {
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