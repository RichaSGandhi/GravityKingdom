//
//  UINavigationController+Rotation_IOS6.h
//  GravityKingdom
//
//  Created by Pooya Rahimian on 4/9/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UINavigationController (Rotation_IOS6)

- (BOOL)shouldAutorotate;
- (NSUInteger)supportedInterfaceOrientations;
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation;

@end
