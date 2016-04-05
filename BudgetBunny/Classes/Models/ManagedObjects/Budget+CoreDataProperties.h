//
//  Budget+CoreDataProperties.h
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Budget.h"

NS_ASSUME_NONNULL_BEGIN

@interface Budget (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *dailyBudget;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) Account *accountId;
@property (nullable, nonatomic, retain) Category *budgetCategoryId;
@property (nullable, nonatomic, retain) Transaction *budgetTransactionId;

@end

NS_ASSUME_NONNULL_END
