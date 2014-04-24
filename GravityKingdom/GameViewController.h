//
//  GameViewController.h
//  GravityKingdom
//
//  Created by DIVMS on 4/9/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOS7AlertView.h"
#import <SpriteKit/SpriteKit.h>

@interface GameViewController : UIViewController <CustomIOS7AlertViewDelegate>
{
    NSArray * _items;
}

@property(nonatomic,strong) NSArray * items;
@end
