//
//  NetworkService.h
//  valutakg
//
//  Created by Sergei Ten on 7/21/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractNetworkService.h"

@interface NetworkService : AbstractNetworkService

#pragma mark - Singleton
+ (NetworkService *) sharedNetworkService;

#pragma mark - Methods
- (void)currentRatessuccess:(void (^)(NSArray *currencies))success failure:(void (^)(NSError *error, NSInteger statusCode))failure;

@end
