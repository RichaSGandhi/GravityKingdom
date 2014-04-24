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

static NSInteger const kBallSize = 25;

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
    }
    
}
//------------start of section of toolbar --> added by Pooya ----------------
- (IBAction)toolboxPopUp:(id)sender {
    
    // Here we need to pass a full frame
    CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Go", @"Close", nil]];
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
        [alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
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

//If the user chooses from the pickerview, it calls this function;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //Let's print in the console what the user had chosen;
    NSLog(@"picked number of points is : %@", [self.items objectAtIndex:row]);
}
//------------end of section of toolbar --> added by Pooya ----------------
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
    /*
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
    [self.bounceBehaviour addItem:ball];
     */
    UIView *square = [[UIView alloc] initWithFrame:
                      CGRectMake(x-25.0,0.0, 50.0, 50.0)];
    square.layer.masksToBounds = YES;
    square.backgroundColor = [UIColor redColor];
    
	[self.view addSubview:square];
    
    // Add some gravity
    [self.gravityBehavior addItem:square];
    
    // Add the collision
    [self.collisionBehavior addItem:square];
    
    // Add the bounce
    [self.bounceBehaviour addItem:square];
    
    //Add push behaviour
    //[self.pusher addItem:square];

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
