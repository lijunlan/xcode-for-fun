//
//  MyView.h
//  HZKTest
//
//  Created by SDLL18 on 15/3/18.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPoint.h"

@interface MyView : UIView
@property (nonatomic,strong) NSMutableArray* points;

-(void)setUp;
-(void)setUp:(float) MaxP PercSig:(float) PercSig Nsample:(int) Nsample DataTitle:(const char*) DataTitle nData:(int) nData  days:(float*) days folds:(float*) folds;
-(void) addPoint: (MyPoint*) point;
-(void) clearPoint;
-(void) start:(CGContextRef) context rect:(CGRect)rect;
@end
