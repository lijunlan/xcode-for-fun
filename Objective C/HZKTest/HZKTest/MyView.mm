//
//  MyView.m
//  HZKTest
//
//  Created by SDLL18 on 15/3/18.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import "MyView.h"
#include "Fold_increase.h"

@interface MyView (){
    bool isSetUp;
    struct Result _r;
}
@end

@implementation MyView
@synthesize points;
-(id)init{
    if (self = [super init]) {
        isSetUp = false;
    }
    return self;
}

- (void)setUp{
    points = [[NSMutableArray alloc]init];
}

- (void)setUp:(float)MaxP PercSig:(float)PercSig Nsample:(int)Nsample DataTitle:(const char *)DataTitle nData:(int)nData days:(float *)days folds:(float *)folds{
    isSetUp = true;
    _r = Fold_increase(MaxP,PercSig,Nsample,DataTitle,nData,days,folds);
    [self setNeedsDisplay];
}

- (void)addPoint:(MyPoint *)point{
    [points addObject:point];
    [self setNeedsDisplay];
}

- (void)clearPoint{
    [points removeAllObjects];
    [self setNeedsDisplay];
}

- (void)start:(CGContextRef) context rect:(CGRect)rect{
    if(isSetUp==false)return;
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(context);
    CGFloat X1 = 0.0,Y1 = 0.0;
    for(int i = 0;i<15;i++){
        CGFloat plotX = _r.days[i] *4.0 + rect.size.width/2;
        CGFloat plotY = -_r.mean[i] *4.0 + rect.size.height/2;
        if(i==0){
                CGContextMoveToPoint(context, plotX, plotY);
                X1 = plotX;
                Y1 = plotY;
        }
        else{
            CGContextAddLineToPoint(context,plotX , plotY);
        }
    }
    CGContextStrokePath(context);
    
    CGContextSetRGBStrokeColor(context, 0.0, 1.0, 0.0, 1.0);
    CGContextBeginPath(context);
    X1 = 0.0,Y1 = 0.0;
    for(int i = 0;i<15;i++){
        CGFloat plotX = _r.days[i] *4.0 + rect.size.width/2;
        CGFloat plotY = -_r.sig1[i] *4.0 + rect.size.height/2;
        if(i==0){
            CGContextMoveToPoint(context, plotX, plotY);
            X1 = plotX;
            Y1 = plotY;
        }
        else{
            CGContextAddLineToPoint(context,plotX , plotY);
        }
    }
    CGContextStrokePath(context);

    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 1.0, 1.0);
    CGContextBeginPath(context);
    X1 = 0.0,Y1 = 0.0;
    for(int i = 0;i<15;i++){
        CGFloat plotX = _r.days[i] *4.0 + rect.size.width/2;
        CGFloat plotY = -_r.sig2[i] *4.0 + rect.size.height/2;
        if(i==0){
            CGContextMoveToPoint(context, plotX, plotY);
            X1 = plotX;
            Y1 = plotY;
        }
        else{
            CGContextAddLineToPoint(context,plotX , plotY);
        }
    }
    CGContextStrokePath(context);
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0);
    CGContextBeginPath(context);
    X1 = 0.0,Y1 = 0.0;
    for(int i = 0;i<_r.nD;i++){
        //NSLog(@"%f,%f",_r.indays[i],_r.folds[i]);
        CGFloat plotX = _r.indays[i] *4.0 + rect.size.width/2;
        CGFloat plotY = -_r.folds[i] *4.0 + rect.size.height/2;
        if(i==0){
            CGContextMoveToPoint(context, plotX, plotY);
            X1 = plotX;
            Y1 = plotY;
        }
        else{
            CGContextAddLineToPoint(context,plotX , plotY);
        }
    }
    CGContextStrokePath(context);

//    //连线
//    CGContextSetLineWidth(context, 4.0);
//    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
//    CGContextBeginPath(context);
//    int i = 1;
//    CGFloat X1 = 0.0,Y1 = 0.0;
//    for (MyPoint* p in points){
//        CGFloat plotX = p.x *4.0 + rect.size.width/2;
//        CGFloat plotY = -p.y *4.0 + rect.size.height/2;
//        if(i==1){
//            CGContextMoveToPoint(context, plotX, plotY);
//            X1 = plotX;
//            Y1 = plotY;
//        }
//        else{
//            CGContextAddLineToPoint(context, plotX, plotY);
//        }
//        i++;
//    }
//    if(X1!=0.0&&Y1!=0.0){
//        CGContextAddLineToPoint(context, X1, Y1);
//    }
//    CGContextStrokePath(context);

}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置线条样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //设置线条粗细宽度
    CGContextSetLineWidth(context, 1.0);
    //设置颜色
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    
    //x轴
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, rect.origin.x, rect.size.height/2);
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height/2);
    CGContextStrokePath(context);
    
    //y轴
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, rect.size.width/2, rect.origin.y);
    CGContextAddLineToPoint(context, rect.size.width/2, rect.size.height);
    CGContextStrokePath(context);
    
    //刻度
    CGContextSetLineWidth(context, 1.0);
    for (CGFloat dis = 0.0 ; dis<=rect.size.width/2 ; dis+=40.0 ) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, rect.size.width/2+dis, rect.size.height/2+2.0);
        CGContextAddLineToPoint(context, rect.size.width/2+dis, rect.size.height/2-2.0);
        CGContextStrokePath(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, rect.size.width/2-dis, rect.size.height/2+2.0);
        CGContextAddLineToPoint(context, rect.size.width/2-dis, rect.size.height/2-2.0);
        CGContextStrokePath(context);
        NSString *str = [[NSString alloc] initWithFormat:@"%d",((int)dis)/4];
        [str drawAtPoint:CGPointMake(rect.size.width/2+dis, rect.size.height/2+2.0) withAttributes:nil];
        NSString *str2 = [[NSString alloc] initWithFormat:@"%d",((int)-dis)/4];
        [str2 drawAtPoint:CGPointMake(rect.size.width/2-dis, rect.size.height/2+2.0) withAttributes:nil];
    }
    for (CGFloat dis = 0.0 ; dis<=rect.size.height/2 ; dis+=40.0 ) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, rect.size.width/2+2.0, rect.size.height/2+dis);
        CGContextAddLineToPoint(context, rect.size.width/2-2.0, rect.size.height/2+dis);
        CGContextStrokePath(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, rect.size.width/2+2.0, rect.size.height/2-dis);
        CGContextAddLineToPoint(context, rect.size.width/2-2.0, rect.size.height/2-dis);
        CGContextStrokePath(context);
        if(dis==0.0)continue;
        NSString *str = [[NSString alloc] initWithFormat:@"%d",((int)-dis)/4];
        [str drawAtPoint:CGPointMake(rect.size.width/2+2.0, rect.size.height/2+dis) withAttributes:nil];
        NSString *str2 = [[NSString alloc] initWithFormat:@"%d",((int)dis)/4];
        [str2 drawAtPoint:CGPointMake(rect.size.width/2+2.0, rect.size.height/2-dis) withAttributes:nil];
    }
    
    [self start:context rect:rect];
    
    //连线
    CGContextSetLineWidth(context, 4.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextBeginPath(context);
    int i = 1;
    CGFloat X1 = 0.0,Y1 = 0.0;
    for (MyPoint* p in points){
        CGFloat plotX = p.x *4.0 + rect.size.width/2;
        CGFloat plotY = -p.y *4.0 + rect.size.height/2;
        if(i==1){
            CGContextMoveToPoint(context, plotX, plotY);
            X1 = plotX;
            Y1 = plotY;
        }
        else{
            CGContextAddLineToPoint(context, plotX, plotY);
        }
        i++;
    }
    if(X1!=0.0&&Y1!=0.0){
        CGContextAddLineToPoint(context, X1, Y1);
    }
    CGContextStrokePath(context);
    
    
    //画点和注明坐标
    CGContextSetLineWidth(context, 5.0);
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
    for (MyPoint* p in points) {
        CGFloat plotX = p.x *4.0 + rect.size.width/2;
        CGFloat plotY = -p.y *4.0 + rect.size.height/2;
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, plotX-1, plotY);
        CGContextAddLineToPoint(context, plotX+1, plotY);
        CGContextStrokePath(context);
        NSString *str = [[NSString alloc] initWithFormat:@"%d,%d",p.x,p.y];
        [str drawAtPoint:CGPointMake(plotX, plotY) withAttributes:nil];
    }

}

@end
