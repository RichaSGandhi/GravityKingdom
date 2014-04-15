//
//  GameViewController.m
//  GravityKingdom
//
//  Created by DIVMS on 4/9/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravityBehavior;
@property (nonatomic, strong) UICollisionBehavior *collisionBehavior;
@property (nonatomic, strong) UIDynamicItemBehavior *bounceBehaviour;
@property (nonatomic, strong) UIPushBehavior *pusher;

@end

@implementation GameViewController

static NSInteger const kBallSize = 40;

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
	// Do any additional setup after loading the view.
    
    
    // tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    // Gravity
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[ ]];
    self.gravityBehavior.magnitude = 10.8;
    [self.animator addBehavior:self.gravityBehavior];
    
    // Collision
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ ]];
    [self.collisionBehavior addBoundaryWithIdentifier:@"bottom"
                                            fromPoint:CGPointMake(0, 300)
                                              toPoint:CGPointMake(568, 300)];
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    self.collisionBehavior.collisionDelegate = self;
    [self.animator addBehavior:self.collisionBehavior];
    
    // Bounce
    self.bounceBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[ ]];
    self.bounceBehaviour.elasticity = 0.50;
    [self.animator addBehavior:self.bounceBehaviour];
    
    self.pusher = [[UIPushBehavior alloc] initWithItems:@[]
                                                   mode:UIPushBehaviorModeInstantaneous];
    self.pusher.pushDirection = CGVectorMake(0.5, 0.0);
    self.pusher.active = YES;
    // Because push is instantaneous, it will only happen once
    [self.animator addBehavior:self.pusher];

    
    //-------- add object
    
    UIView *ball = [[UIView alloc] initWithFrame:CGRectMake(100 - (kBallSize/2), 0, kBallSize, kBallSize)];
    ball.backgroundColor = [UIColor greenColor];
    ball.layer.cornerRadius = kBallSize/2;
    ball.layer.masksToBounds = YES;
    [self.view addSubview:ball];
    
    // Add some gravity
    [self.gravityBehavior addItem:ball];
    
    // Add the collision
    [self.collisionBehavior addItem:ball];
    
    // Add the bounce
    [self.bounceBehaviour addItem:ball];
    
    //Add push behaviour
    //[self.pusher addItem:ball];
    
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
