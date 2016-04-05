//
//  Target+CoreDataProperties.h
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Target.h"

NS_ASSUME_NONNULL_BEGIN

@interface Target (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *actualAmount;
@property (nullable, nonatomic, retain) NSNumber *targetAmount;
@property (nullable, nonatomic, retain) Account *accountId;
@property (nullable, nonatomic, retain) Transaction *transactionId;
@property (nullable, nonatomic, retain) Wishitem *targetWishitemId;

@end

NS_ASSUME_NONNULL_END
