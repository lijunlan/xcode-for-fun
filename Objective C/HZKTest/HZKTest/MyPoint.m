//
//  Point.m
//  HZKTest
//
//  Created by SDLL18 on 15/3/18.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import "MyPoint.h"

@implementation MyPoint
@synthesize x;
@synthesize y;

-(id)initWithX:(NSInteger)xVal withY:(NSInteger)yVal{
    if (self = [super init]) {
        self.x = xVal;
        self.y = yVal;
    }
    return self;
}

@end
