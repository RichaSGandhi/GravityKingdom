//
//  GameScene.m
//  GravityKingdom
//
//  Created by DIVMS on 4/23/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//

#import "GameScene.h"

#define BALL_CATEGORY   (0x00000001)
#define PIG_CATEGORY    ((0x00000001)<<1)
#define BLOCK_CATEGORY  ((0x00000001)<<2)


@implementation GameScene

UIBezierPath *path;
CGMutablePathRef myPath;
BOOL gameStarted;
int counter;

-(id)initWithSize:(CGSize)size
{
    counter = 0;
    
    if (self = [super initWithSize:size]) {
        //Setup your scene here
        //self.physicsBody= [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        //self.physicsBody.categoryBitMask = wallCategory;
        self.physicsBody.friction = 0.0f;
        
        //20 10 25 1.
        self.backgroundColor = [SKColor colorWithRed:0.20 green:0.10 blue:0.20 alpha:1.0];
        
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Gravity Kingdom!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        
        [self addChild:myLabel];
        
        
        SKSpriteNode* backBone = [[SKSpriteNode alloc] initWithColor:[UIColor brownColor] size:CGSizeMake(200, 15)];
        //110,50
        backBone.position = CGPointMake(120, 220);
        backBone.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:backBone.size];
        backBone.physicsBody.affectedByGravity = NO;
        backBone.physicsBody.mass = 1000;
        backBone.physicsBody.categoryBitMask = wallCategory;
        backBone.physicsBody.contactTestBitMask = 05;
        backBone.physicsBody.collisionBitMask = BLOCK_CATEGORY | wallCategory | objectCategory;
        [self addChild:backBone];
        
        
        SKSpriteNode *ball = [SKSpriteNode spriteNodeWithImageNamed:@"myBall.png"];
        
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
        
        ball.physicsBody.dynamic = YES;
        
        ball.position = CGPointMake(130, 230);
        ball.physicsBody.mass = 10;
        ball.physicsBody.affectedByGravity = NO;
        ball.physicsBody.categoryBitMask = BALL_CATEGORY;
        ball.physicsBody.contactTestBitMask = 01;
        [self addChild:ball];
        
        NSLog(@"Backbone mass is: %f", backBone.physicsBody.mass);
        //self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        //self.physicsWorld.contactDelegate = self;
    }
    
    path = [UIBezierPath bezierPath];
    
    return self;
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"In touchesBegan");
    
    // Uncomment below code to add shapes on click
    /*
     SKSpriteNode* square = [[SKSpriteNode alloc] initWithColor:[UIColor yellowColor] size:CGSizeMake(20, 20)];
     square.position = CGPointMake(40, 400);
     square.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:square.size];
     //square.physicsBody.restitution = 0.8;
     square.physicsBody.categoryBitMask = wallCategory;
     square.physicsBody.contactTestBitMask = 10;
     square.physicsBody.collisionBitMask = BLOCK_CATEGORY|wallCategory | objectCategory;
     
     [self addChild:square];  */
    
    CGPoint location;
    
    myPath = CGPathCreateMutable();
    for (UITouch *touch in touches) {
        location = [touch locationInNode:self];
        /*  //My code
         if(counter == 0) {
         CGPathMoveToPoint(myPath, NULL, location.x, location.y);
         counter++;
         } else {
         CGPathAddLineToPoint(myPath, NULL, location.x, location.y);
         counter++;
         }
         */
        
        // Pooyaz coode
        if(counter == 0) {
            [path moveToPoint:location];
            counter++;
        } else {
            [path addLineToPoint:location];
            counter++;
        }
        
    }
    if (counter >=3)
    {
        [path closePath];
        counter=0;
        
        
        SKShapeNode *shapeNode = [[SKShapeNode alloc] init];
        shapeNode.path = path.CGPath;
        shapeNode.fillColor = [SKColor yellowColor];
        shapeNode.strokeColor = [SKColor redColor];
        
        //shapeNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:shapeNode.size];
        CGPathRef pathCopy = CGPathCreateCopy(shapeNode.path);
        shapeNode.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:pathCopy];
        shapeNode.physicsBody.categoryBitMask = BLOCK_CATEGORY;
        shapeNode.physicsBody.dynamic = YES;
        shapeNode.physicsBody.contactTestBitMask = 10;
        shapeNode.physicsBody.collisionBitMask = BLOCK_CATEGORY|wallCategory | objectCategory;
        shapeNode.name = @"ship";
        //shapeNode.position = CGPointMake(50,80);
        
        //shapeNode.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:myPath];
        //shapeNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:shapeNode.frame.size];
        shapeNode.physicsBody.dynamic = YES;
        shapeNode.physicsBody.usesPreciseCollisionDetection = YES;
        shapeNode.physicsBody.affectedByGravity = YES;
        
        //shapeNode.physicsBody.density = 10.0;
        // shapeNode.physicsBody.categoryBitMask = objectCategory;
        // shapeNode.physicsBody.contactTestBitMask = 5;
        //shapeNode.physicsBody.collisionBitMask = wallCategory | objectCategory;
        
        [self addChild:shapeNode];
        
        
        [path removeAllPoints];
    }
    
}

-(void)update:(CFTimeInterval)currentTime
{
    //self.physicsBody = [SKPhysicsBody ];// bodyWithEdgeLoopFromRect:self.frame];
    /* Called before each frame is rendered */
}

-(void)didBeginContact:(SKPhysicsContact *)contact
{
    NSLog(@"In didBeginContact");
    if (gameStarted == NO)
        return;
    if(contact.bodyB == self.physicsBody || contact.bodyA == self.physicsBody)
        return;
    int test = PIG_CATEGORY | BLOCK_CATEGORY | wallCategory | objectCategory;
    
    
    if(contact.bodyA.categoryBitMask == PIG_CATEGORY && (contact.bodyB.categoryBitMask & test) > 0) {
        [contact.bodyA.node removeFromParent];
        SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"spark" ofType:@"sks"]];
        emitter.position = contact.contactPoint;
        [self addChild:emitter];
    }
    else if(contact.bodyB.categoryBitMask == PIG_CATEGORY && (contact.bodyA.categoryBitMask & test)>0) {
        [contact.bodyB.node removeFromParent];
        SKEmitterNode *emitter = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"spark" ofType:@"sks"]];
        emitter.position = contact.contactPoint;
        [self addChild:emitter];
    }
    
}


@end
