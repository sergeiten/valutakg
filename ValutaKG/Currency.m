//
//  Currency.m
//  valutakg
//
//  Created by Sergei Ten on 7/21/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import "Currency.h"

@implementation Currency

- (id)initWithServerResponse:(NSDictionary *)response {
    self = [super init];
    
    if (self) {
        self.currencyFlag = [response objectForKey:@"title_alias"];
        self.currencyLabel = [response objectForKey:@"title"];
        self.rateBuy = [[response objectForKey:@"rates"] objectForKey:@"buy_rate"];
        self.rateSell = [[response objectForKey:@"rates"] objectForKey:@"sell_rate"];
    }
    
    return self;
}

@end
