//
//  SharedModel.m
//  SimpleNav
//
//  Created by James Cremer on 2/20/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "SharedModel.h"

@implementation SharedModel

static SharedModel* theSharedInstance;

+(SharedModel *) sharedInstance {
	if (!theSharedInstance)
		theSharedInstance = [[SharedModel alloc] init];
	return theSharedInstance;
}

@end
