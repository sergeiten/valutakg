//
//  AbstractNetworkService.m
//  DocsMT-iOS
//
//  Created by Sergei Ten on 7/5/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import "AbstractNetworkService.h"

@implementation AbstractNetworkService

static NSString* baseURL = @"http://m.valuta.kg/";

#pragma mark - Methods
- (id)init {
    self = [super init];
    
    if (self) {
        NSURL *url = [NSURL URLWithString:baseURL];
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
        self.requestOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/xml", nil];
    }
    
    return self;
}

@end
