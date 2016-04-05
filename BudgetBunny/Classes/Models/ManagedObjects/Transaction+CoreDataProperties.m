//
//  Transaction+CoreDataProperties.m
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Transaction+CoreDataProperties.h"

@implementation Transaction (CoreDataProperties)

@dynamic amount;
@dynamic datetime;
@dynamic notes;
@dynamic type;
@dynamic accountId;
@dynamic transferAccountId;
@dynamic budgetId;
@dynamic categoryId;
@dynamic transactionTargetId;

@end
