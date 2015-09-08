//
//  Currency.h
//  valutakg
//
//  Created by Sergei Ten on 7/21/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property (strong, nonatomic) NSString *currencyFlag;
@property (strong, nonatomic) NSString *currencyLabel;
@property (strong, nonatomic) NSString *rateBuy;
@property (strong, nonatomic) NSString *rateSell;

- (id)initWithServerResponse:(NSDictionary *)response;

@end
