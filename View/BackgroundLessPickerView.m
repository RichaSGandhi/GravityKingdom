//
//  BackgroundLessPickerView.m
//
//  Created by Barry Allard on 2013-08-27.
//  Copyright (c) 2013 Barry Allard All rights reserved.
//  License: MIT

#import "BackgroundLessPickerView.h"
#import <QuartzCore/QuartzCore.h>

@implementation BackgroundLessPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (CALayer *)makeMask
{
    CALayer* mask = [[CALayer alloc] init];
    mask.backgroundColor = [UIColor blackColor].CGColor;
    mask.frame = CGRectInset(self.bounds, 10.0f, 10.0f);
    mask.cornerRadius = 5.0f;
    return mask;
}

- (void)updateMask
{
    self.layer.mask = [self makeMask]; 
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateMask];
}
@end