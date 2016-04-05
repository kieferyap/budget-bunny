//
//  Account.h
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Record, Transaction;

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Account+CoreDataProperties.h"
