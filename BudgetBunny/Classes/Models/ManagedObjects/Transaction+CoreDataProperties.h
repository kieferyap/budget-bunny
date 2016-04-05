//
//  Transaction+CoreDataProperties.h
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Transaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSDate *datetime;
@property (nullable, nonatomic, retain) NSString *notes;
@property (nullable, nonatomic, retain) NSNumber *type;
@property (nullable, nonatomic, retain) NSManagedObject *accountId;
@property (nullable, nonatomic, retain) NSManagedObject *transferAccountId;
@property (nullable, nonatomic, retain) NSManagedObject *budgetId;
@property (nullable, nonatomic, retain) Category *categoryId;
@property (nullable, nonatomic, retain) NSManagedObject *transactionTargetId;

@end

NS_ASSUME_NONNULL_END
