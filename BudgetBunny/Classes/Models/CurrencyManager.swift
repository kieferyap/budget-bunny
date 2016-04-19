//
//  CurrencyManager.swift
//  BudgetBunny
//
//  Created by Kiefer Yap on 4/19/16.
//  Copyright © 2016 Kiefer Yap. All rights reserved.
//

import UIKit

class CurrencyManager: NSObject {

    var currencyDictionary: NSDictionary = [:]
    
    func setCurrencyList() {
        var countryInfo: NSMutableDictionary = [:]
        var currencies: NSMutableArray = []
        
    }
    
}


/*


#import "CurrencyManager.h"
#import "Currency.h"

@interface CurrencyManager()

@property (strong, nonatomic) NSDictionary* currencyDictionary;

@end

@implementation CurrencyManager

@synthesize validCurrencies = _validCurrencies;
@synthesize currencyDictionary = _currencyDictionary;

// Don't return a mutable array
- (NSArray *)validCurrencies {
return [_validCurrencies copy];
}


- (CurrencyManager *) init {
self = [super init];
if ( self ) {

NSMutableDictionary* countryInfo = [[NSMutableDictionary alloc] init];
NSMutableArray* keptCurrencies = [[NSMutableArray alloc] init];
NSArray* countries = [NSLocale availableLocaleIdentifiers];

for ( NSString* country in countries ) {
Currency* currency = [[Currency alloc] initWithLocaleIdentifier:country];

if ( currency ) {
if ( ![countryInfo objectForKey:currency.name] ) {
[countryInfo setObject:currency forKey:currency.name];
[keptCurrencies addObject:currency.name];

}
}

}

_validCurrencies = [keptCurrencies sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
_currencyDictionary = countryInfo;
}
return self;
}

-(int)currencyCount {
return self.validCurrencies.count;
}


-(NSString *)titleForPickerForRow:(NSInteger)row {

Currency* currencyItem = [self.currencyDictionary objectForKey:[self.validCurrencies objectAtIndex:row]];
return currencyItem.pickerTitle;
}
-(Currency *)infoForCurrencyAtRow:(NSInteger)row {
return [self.currencyDictionary objectForKey:[self.validCurrencies objectAtIndex:row]];

}
-(Currency *)infoForCurrencyWithName:(NSString *)name {
return [self.currencyDictionary objectForKey:name];
}



*/