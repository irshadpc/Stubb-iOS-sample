//
//  APIController.m
//  mockAPIExample
//
//  Created by MobMe on 10/11/17.
//  Copyright © 2017 MobMe. All rights reserved.
//

#import "APIController.h"
#import "APIManager.h"
#import "MockAPI.h"


#define boolMockAPI @"no"

@implementation APIController

-(void)fetchGithubRepos:(NSDictionary*)params  WithUserName:(NSString *)userName withCompletion:(void(^)(NSArray *result))completionHandler withFailureResult:(void(^)(NSError *error ))failureCompletionHandler{
    //check whether to use mock response or real response
    if([boolMockAPI isEqualToString:@"YES"]){
        //initalise mockAPI object
        MockAPI * mockAPI =[MockAPI sharedManager];
    NSArray *mockResponse=  [mockAPI fetchGithubRepos];
    completionHandler(mockResponse);
    }
    else{
        //initialise APImanagers object
    APIManager * apiManager = [APIManager sharedManager];
    [apiManager fetchGithubRepos:params  WithUserName:userName withCompletion:^(NSArray *result) {
        completionHandler(result);
    } withFailureResult:^(NSError *error) {
        failureCompletionHandler(error);
    }];
    }
}
@end
