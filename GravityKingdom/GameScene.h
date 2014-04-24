//
//  GameScene.h
//  GravityKingdom
//
//  Created by DIVMS on 4/23/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

static const uint8_t objectCategory = 1;
static const uint8_t wallCategory = 2;

@interface GameScene : SKScene <SKPhysicsContactDelegate>
@property SKEmitterNode *fire;
@property SKEmitterNode *spark;

@end
