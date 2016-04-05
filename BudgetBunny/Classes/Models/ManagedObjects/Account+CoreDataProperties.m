//
//  Account+CoreDataProperties.m
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Account+CoreDataProperties.h"

@implementation Account (CoreDataProperties)

@dynamic currency;
@dynamic isDefault;
@dynamic name;
@dynamic accountBudgetId;
@dynamic accountRecordId;
@dynamic accountTargetId;
@dynamic accountTransactionId;
@dynamic accountTransferTransactionId;

@end
