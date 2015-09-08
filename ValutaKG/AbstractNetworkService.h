//
//  AbstractNetworkService.h
//  DocsMT-iOS
//
//  Created by Sergei Ten on 7/5/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface AbstractNetworkService : NSObject

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;

@end
