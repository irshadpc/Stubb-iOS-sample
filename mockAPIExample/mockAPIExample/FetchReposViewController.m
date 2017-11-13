//
//  ViewController.m
//  mockAPIExample
//
//  Created by MobMe on 10/11/17.
//  Copyright © 2017 MobMe. All rights reserved.
//

#import "FetchReposViewController.h"
#import "FetchReposTableViewCell.h"
#import "APIController.h"
#import "DGActivityIndicatorView.h"

@interface ViewController ()
{
    NSArray * arrayUserRepos;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UI Design
    [self UIDesign];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//return number of count of arrays and 1 if the array is nil
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([arrayUserRepos count] !=0){
        return [arrayUserRepos count];
    }
    else{
        return 1;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"fetchRepos";
    FetchReposTableViewCell * cell =[self.tableViewRepoList dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell = [[FetchReposTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];}
    //storing each value of index path in nsdictionary
    NSDictionary * dictionaryUserRepo = [arrayUserRepos objectAtIndex:indexPath.row];
    //getting value of key = name
    cell.labelReposName.text=[dictionaryUserRepo valueForKey:@"name"];
    return cell;
}
//for fething user repos
- (IBAction)buttonFetchRepos:(id)sender {
    //initialising an object of apiController
    APIController * apiController = [[APIController alloc]init];
    //params to be send
    NSDictionary * githubParams = [[NSDictionary alloc]initWithObjectsAndKeys:@"all",@"visibility",@"owner",@"affiliation",@"all",@"type",@"full_name",@"sort",@"asc",@"direction", nil];
    //activity indicator
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor redColor] size:40.0f];
    activityIndicatorView.center = self.view.center;
    [self.view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    //api controllers api
    [apiController fetchGithubRepos:githubParams  WithUserName:_textfieldUserRepoSearch.text withCompletion:^(NSArray *result) {
        [activityIndicatorView stopAnimating];
        //storing result in array
        arrayUserRepos = result;
        //reloading data
        [_tableViewRepoList reloadData];
    } withFailureResult:^(NSError *error) {
        [activityIndicatorView stopAnimating];
        //initalising array with nil in the case of error
        arrayUserRepos=nil;
        //error
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Sorry"
                                     message:@"User not found"
                                     preferredStyle:UIAlertControllerStyleAlert];
    
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
        [_tableViewRepoList reloadData];
    }];
}
-(void)UIDesign{
    //to remove the extra lines of uitableview
     self.tableViewRepoList.tableFooterView = [UIView new];
    //fetch button
    _buttonFetchRepos_outlet.layer.cornerRadius=3.0f;
    _buttonFetchRepos_outlet.layer.masksToBounds=YES;
    _buttonFetchRepos_outlet.layer.borderWidth= 0.1f;
}
@end
