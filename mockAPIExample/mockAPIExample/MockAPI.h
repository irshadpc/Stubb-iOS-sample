//
//  MockAPI.h
//  mockAPIExample
//
//  Created by MobMe on 10/11/17.
//  Copyright © 2017 MobMe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MockAPI : NSObject

+(instancetype)sharedManager;
+ (id)sharedApiObject;
//to return the mock request
-(NSArray *)fetchGithubRepos;

@end
