//
//  Category+CoreDataProperties.h
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface Category (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *isIncome;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSManagedObject *budgetId;
@property (nullable, nonatomic, retain) NSManagedObject *categoryTransactionId;

@end

NS_ASSUME_NONNULL_END
