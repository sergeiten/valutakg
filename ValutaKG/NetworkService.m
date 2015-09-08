//
//  NetworkService.m
//  valutakg
//
//  Created by Sergei Ten on 7/21/15.
//  Copyright (c) 2015 Sergei Ten. All rights reserved.
//

#import "NetworkService.h"
#import "XMLDictionary.h"
#import "Currency.h"

@implementation NetworkService

#pragma mark - Singleton
+ (NetworkService *) sharedNetworkService {
    static NetworkService *sharedNetworkService;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedNetworkService = [[NetworkService alloc] init];
    });
    
    return sharedNetworkService;
}

#pragma mark - Methods
- (void) currentRatessuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *, NSInteger))failure {
    self.requestOperationManager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [self.requestOperationManager GET:@"api/" parameters:NULL success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseXmlData = [NSDictionary dictionaryWithXMLParser:(NSXMLParser *)responseObject];
        NSDictionary *responseCurrencies = [responseXmlData objectForKey:@"currency"];
        NSMutableArray *currencies = [[NSMutableArray alloc] init];
                
        for (NSDictionary *data in responseCurrencies) {
            Currency *currency = [[Currency alloc] initWithServerResponse:data];
            
            [currencies addObject:currency];
        }
        
        if (success) {
            success(currencies);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error.localizedDescription);
        
        if (failure) {
            failure(error, operation.response.statusCode);
        }
    }];
}

@end
