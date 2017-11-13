//
//  ViewController.h
//  mockAPIExample
//
//  Created by MobMe on 10/11/17.
//  Copyright © 2017 MobMe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *textfieldUserRepoSearch;

@property (strong, nonatomic) IBOutlet UIButton *buttonFetchRepos_outlet;

@property (strong, nonatomic) IBOutlet UITableView *tableViewRepoList;

- (IBAction)buttonFetchRepos:(id)sender;

@end

