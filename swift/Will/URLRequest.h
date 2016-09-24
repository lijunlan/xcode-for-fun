//
//  URLRequest.h
//  Will
//
//  Created by SDLL18 on 15/3/11.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLRequest : NSObject<NSURLConnectionDataDelegate>

-(id)initWithRequest:(NSURLRequest*)req;
-(id)initWithURL:(NSString*)URL withBody:(NSMutableData*) body;
-(void)startWithCompletion:(void (^) (URLRequest* request,NSData* data,BOOL success))comple;

@end