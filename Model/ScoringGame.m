//
//  ScoringGame.m
//  GravityKingdom
//
//  Created by DIVMS on 4/26/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//

#import "ScoringGame.h"

#define Hit_Points 100

@implementation ScoringGame

-(int) calculateScore:(int)noOfObstaclesHit
{
    int score = 0;
    score = noOfObstaclesHit * Hit_Points;
    
    return score;
}


@end
