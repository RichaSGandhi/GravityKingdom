//
//  GameScene.m
//  GravityKingdom
//
//  Created by DIVMS on 4/23/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//

#import "GameScene.h"
#import "GameViewController.h"
#import "GameViewController.h"
#import "SharedModel.h"


#define BALL_CATEGORY   (0x00000001)
#define SHAPE_CATEGORY    ((0x00000001)<<2)
#define BLOCK_CATEGORY  ((0x00000001)<<2)


@implementation GameScene

UIBezierPath *path;
CGMutablePathRef myPath;
BOOL gameStarted;
int counter;
int shape;
SKSpriteNode *ball;
SKShapeNode *shapeNode;

-(id)initWithSize:(CGSize)size
{
    counter = 0;
    
    if (self = [super initWithSize:size]) {
        //Setup your scene here
        //self.physicsBody= [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        //self.physicsBody.categoryBitMask = wallCategory;
        self.physicsBody.friction = 0.0f;
        
        self.backgroundColor = [SKColor colorWithRed:0.20 green:0.10 blue:0.20 alpha:1.0];
        
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Gravity Kingdom!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
        
        
        SKSpriteNode* backBone = [[SKSpriteNode alloc] initWithColor:[UIColor brownColor] size:CGSizeMake(200, 15)];
        backBone.position = CGPointMake(120, 220);
        backBone.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:backBone.size];
        backBone.physicsBody.affectedByGravity = NO;
        backBone.physicsBody.mass = 10000000;
        backBone.physicsBody.categoryBitMask = wallCategory;
        backBone.physicsBody.contactTestBitMask = 05;
        backBone.physicsBody.collisionBitMask = BLOCK_CATEGORY | wallCategory | objectCategory;
        [self addChild:backBone];
        
        
        ball = [SKSpriteNode spriteNodeWithImageNamed:@"myBall.png"];
        
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
        
        ball.physicsBody.dynamic = YES;
        
        ball.position = CGPointMake(130, 230);
        ball.physicsBody.affectedByGravity = YES;
        ball.physicsBody.categoryBitMask = BALL_CATEGORY;
        ball.physicsBody.contactTestBitMask = 01;
        ball.physicsBody.friction = 0.05;
        [self addChild:ball];
        self.physicsWorld.contactDelegate = self;

    }
    
    path = [UIBezierPath bezierPath];
    
    return self;
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    CGPoint location;
    SharedModel* sm = [SharedModel sharedInstance];
    myPath = CGPathCreateMutable();
    for (UITouch *touch in touches) {
        location = [touch locationInNode:self];

        if(counter == 0) {
            [path moveToPoint:location];
            counter++;
        } else {
            [path addLineToPoint:location];
            counter++;
        }
        
    }

    if (counter >= (int)sm.pickerValue)
    {
        [path closePath];
        counter=0;
        
        
        shapeNode = [[SKShapeNode alloc] init];
        shapeNode.path = path.CGPath;
        shapeNode.fillColor = [SKColor yellowColor];
        shapeNode.strokeColor = [SKColor redColor];

        CGPathRef pathCopy = CGPathCreateCopy(shapeNode.path);
        shapeNode.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:pathCopy];
        shapeNode.physicsBody.categoryBitMask = SHAPE_CATEGORY;
        shapeNode.physicsBody.dynamic = YES;
        shapeNode.physicsBody.contactTestBitMask = 01;
        shapeNode.physicsBody.collisionBitMask = SHAPE_CATEGORY|wallCategory | objectCategory;
        shapeNode.name = @"ship";

        shapeNode.physicsBody.dynamic = YES;
        shapeNode.physicsBody.usesPreciseCollisionDetection = YES;
        shapeNode.physicsBody.affectedByGravity = YES;
        self.fire = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"AnimFire" ofType:@"sks"]];
        self.fire.position = CGPointMake(shapeNode.frame.size.width, shapeNode.frame.size.height);
        
        self.fire.particleColor = [SKColor redColor];
        self.fire.particleLifetime = 0.01;
        SKAction *fadeAway =   [SKAction fadeOutWithDuration:0.75];
        SKAction *removeNode = [SKAction removeFromParent];
        
        SKAction *sequence = [SKAction sequence:@[fadeAway, removeNode]];
        [self addChild:self.fire];
        //[particles setObject:fire forKey:shapeNode];
        //[self addChild:shapeNode];
        [self.fire runAction: sequence];
        [self addChild:shapeNode];
        
        
        [path removeAllPoints];
    }
    
}

-(void)update:(CFTimeInterval)currentTime
{

}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
   // NSLog(@"In didBeginContact");
    //if (gameStarted == NO)
    // return;
    //if(contact.bodyB == self.physicsBody || contact.bodyA == self.physicsBody)
    //return;
    //int test = BALL_CATEGORY | BLOCK_CATEGORY | wallCategory | objectCategory;
    
    
     /*if(contact.bodyA.categoryBitMask == BALL_CATEGORY && contact.bodyB.categoryBitMask == SHAPE_CATEGORY){
     //if(contact.bodyA == ball.physicsBody && contact.bodyB == shapeNode.physicsBody) {
     //[contact.bodyA.node removeFromParent];
     NSLog(@"ball contact shape");
     self.spark = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"AnimSpark" ofType:@"sks"]];
     self.spark.position = contact.contactPoint;
     self.spark.particleLifetime = 0.05;
     [self addChild:self.spark];
     }
     else */if(contact.bodyB.categoryBitMask == BALL_CATEGORY && contact.bodyA.categoryBitMask == SHAPE_CATEGORY) {
         //[contact.bodyB.node removeFromParent];
         self.spark = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"AnimSpark" ofType:@"sks"]];
         self.spark.particleBirthRate = 100;
         self.spark.position = contact.contactPoint;
         [self addChild:self.spark];
     }
    SKAction *fadeAway =   [SKAction fadeOutWithDuration:0.40];
    SKAction *removeNode = [SKAction removeFromParent];
    
    SKAction *sequence = [SKAction sequence:@[fadeAway, removeNode]];
    [self.spark runAction: sequence];
}


@end
