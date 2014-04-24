//
//  GameViewController.m
//  GravityKingdom
//
//  Created by DIVMS on 4/9/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//

#import "GameViewController.h"
#import "BackgroundLessPickerView.h"
#import "GameScene.h"


@interface GameViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *bounceBehaviour;
@property (nonatomic, strong) UIDynamicItemBehavior *bounceBehaviourForBall;
@property (nonatomic, strong) UIPushBehavior *pusher;

@end

@implementation GameViewController
@synthesize items = _items;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	SKView * skView = (SKView *)self.view;
    if(!skView.scene)
    {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
    
        // Create and configure the scene.
        SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;

        // Present the scene.
        [skView presentScene:scene];
        skView = (SKView *)self.view;
        skView.scene.physicsWorld.gravity = CGVectorMake(0, skView.scene.physicsWorld.gravity.dy);

        //init items array with number of points
        self.items = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];

        
    }
    
}
- (IBAction)toolboxPopUp:(id)sender {
    
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    

    // Add some custom content to the alert view

    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Go", @"Close", nil]];
    [alertView setDelegate:self];
    
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // launch the dialog
    [alertView show];
}

- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
    [alertView close];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    BackgroundLessPickerView *myPickerView = [[BackgroundLessPickerView alloc] initWithFrame:CGRectMake(0, 0, 290, 230)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
     [myPickerView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Picker"]]];
    [demoView addSubview:myPickerView];
    
    return demoView;
}
#pragma mark - UIPickerView DataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.items count];
}

#pragma mark - UIPickerView Delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30.0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.items objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"picked number of points is : %@", [self.items objectAtIndex:row]);

}

#pragma mark - Gesture Recognizer

- (void)onTap:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint pt = [gesture locationInView:self.view];
        [self dropBallAtX:pt.x];
    }
}

#pragma mark - Helpers

- (void)dropBallAtX:(CGFloat)x
{
    int kBallSize=25;
    UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(x - (kBallSize/2), 0, kBallSize, kBallSize)];
    ball.backgroundColor = [UIColor redColor];
    ball.layer.cornerRadius = kBallSize/2;
    ball.layer.masksToBounds = YES;
    [self.view addSubview:ball];
    
    // Add some gravity
    [self.gravityBehavior addItem:ball];
    
    // Add the collision
    [self.collisionBehavior addItem:ball];
    
    // Add the bounce
    self.bounceBehaviourForBall.friction = 0.0;
    [self.bounceBehaviourForBall addItem:ball];

}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
