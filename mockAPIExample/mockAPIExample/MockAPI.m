//
//  MockAPI.m
//  mockAPIExample
//
//  Created by MobMe on 10/11/17.
//  Copyright © 2017 MobMe. All rights reserved.
//

#import "MockAPI.h"

@implementation MockAPI

+(instancetype)sharedManager{
    return [self sharedApiObject];
}

+ (id)sharedApiObject {
    static MockAPI *sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}
//initalising with mock data for mock response
-(NSArray *)fetchGithubRepos{
    NSDictionary *dictionaryAPIResponse1 = [NSDictionary dictionaryWithObjectsAndKeys:@"asus_repo",@"name",@"0",@"open_issues",@"User",@"type",@"1",@"has_downloads", nil];
    NSDictionary *dictionaryAPIResponse2 = [NSDictionary dictionaryWithObjectsAndKeys:@"kurian",@"name",@"1",@"open_issues",@"User",@"type",@"4",@"has_downloads", nil];
    NSArray * arrayAPIResponse = [NSArray arrayWithObjects:dictionaryAPIResponse1,dictionaryAPIResponse2, nil];
    return arrayAPIResponse;
}

@end
