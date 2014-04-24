//
//  ViewController.m
//  GravityKingdom
//
//  Created by DIVMS on 4/6/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//

#import "ViewController.h"
#import <FacebookSDK/FBLoginView.h>
#import <Parse/Parse.h>
#import <Parse/PFQuery.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //FBLoginView *loginView = [[FBLoginView alloc] init];
    FBLoginView *loginView =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"basic_info", @"email", @"user_likes"]];
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), self.view.center.y+150);
    [self.view addSubview:loginView];
    loginView.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
    [self.playButton setHidden:YES];
    [self.PlayerNameText setHidden:YES];
}
-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    self.PlayerNameText.text = [NSString stringWithFormat:@"Hi %@!! Please press play to continue",[user first_name]];
    PFObject *playerObject = [PFObject objectWithClassName:@"PlayerObject"];
     playerObject[@"name"] = [user first_name];
   // PFQuery *queryName = [PFQuery queryWithClassName:@"playerObject"];
    ;
    //NSArray *name = [queryName findObjects];
    //if (name. == [user first_name] ){
    [playerObject saveInBackground];
   // }

    
    
}
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"user logged in");
    [self.playButton setHidden:NO];
    [self.PlayerNameText setHidden:NO];
}
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    NSLog(@"user logged out");
    [self.playButton setHidden:YES];
    [self.PlayerNameText setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
