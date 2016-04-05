//
//  Account+CoreDataProperties.h
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Account.h"

NS_ASSUME_NONNULL_BEGIN

@interface Account (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *currency;
@property (nullable, nonatomic, retain) NSNumber *isDefault;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSManagedObject *accountBudgetId;
@property (nullable, nonatomic, retain) Record *accountRecordId;
@property (nullable, nonatomic, retain) NSManagedObject *accountTargetId;
@property (nullable, nonatomic, retain) Transaction *accountTransactionId;
@property (nullable, nonatomic, retain) Transaction *accountTransferTransactionId;

@end

NS_ASSUME_NONNULL_END
