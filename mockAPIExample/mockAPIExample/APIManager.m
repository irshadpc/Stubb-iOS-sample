//
//  APIManager.m
//  mockAPIExample
//
//  Created by MobMe on 10/11/17.
//  Copyright © 2017 MobMe. All rights reserved.
//

#import "APIManager.h"
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"

@interface APIManager()

@property(strong,nonatomic) AFHTTPSessionManager *requestManager;

@end

@implementation APIManager

+(instancetype)sharedManager{
    return [self sharedApiObject];
}

+ (id)sharedApiObject {
    static APIManager *sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

-(AFHTTPSessionManager *)requestManager{
    if (_requestManager==nil){
        _requestManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        [securityPolicy setValidatesDomainName:NO];
        _requestManager.securityPolicy = securityPolicy;
        _requestManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        _requestManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return _requestManager;
}
//fetch api
-(void)fetchGithubRepos:(NSDictionary *)params  WithUserName:(NSString *)userName withCompletion:(void(^)(NSArray *result))completionHandler withFailureResult:(void(^)(NSError *error ))failureCompletionHandler{
    //url of github for fetching repos
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/users/%@/repos",userName]];
    [[self requestManager]GET:URL.absoluteString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
       NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        completionHandler(jsonArray);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         failureCompletionHandler(error);
    }];
}
@end
