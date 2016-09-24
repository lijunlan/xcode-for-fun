//
//  Point.h
//  HZKTest
//
//  Created by SDLL18 on 15/3/18.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#ifndef HZKTest_Point_h
#define HZKTest_Point_h
#import <UIKit/UIKit.h>

@interface MyPoint : NSObject
@property (nonatomic) NSInteger x;
@property (nonatomic) NSInteger y;

-(id)initWithX: (NSInteger) xVal withY: (NSInteger) yVal;

@end

#endif
