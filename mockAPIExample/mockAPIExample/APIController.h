//
//  APIController.h
//  mockAPIExample
//
//  Created by MobMe on 10/11/17.
//  Copyright © 2017 MobMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIController : NSObject

//api controllers fetch api
-(void)fetchGithubRepos:(NSDictionary*)params  WithUserName:(NSString *)userName withCompletion:(void(^)(NSArray *result))completionHandler withFailureResult:(void(^)(NSError *error ))failureCompletionHandler;

@end
