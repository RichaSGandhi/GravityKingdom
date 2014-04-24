//
//  DataClass.m
//  GravityKingdom
//
//  Created by Pooya Rahimian on 4/24/14.
//  Copyright (c) 2014 uiowa. All rights reserved.
//

#import "DataClass.h"
static DataClass *instance =nil;
@implementation DataClass
@synthesize item;

+(DataClass *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [DataClass new];
        }
    }
    return instance;
}
@end
