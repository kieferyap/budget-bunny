//
//  Wishitem+CoreDataProperties.h
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/5/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Wishitem.h"

NS_ASSUME_NONNULL_BEGIN

@interface Wishitem (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *isBought;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSManagedObject *targetId;

@end

NS_ASSUME_NONNULL_END
