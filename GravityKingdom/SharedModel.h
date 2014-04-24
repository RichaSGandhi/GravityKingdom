//
//  SharedModel.h
//  SimpleNav
//
//  Created by James Cremer on 2/20/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedModel : NSObject

+(SharedModel *) sharedInstance;

@property (nonatomic) NSInteger *pickerValue;
@property (strong, nonatomic) NSString *prop2;
@end
