//
//  main.m
//  RSATest
//
//  Created by SDLL18 on 15/8/28.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSAUtil.h"

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        // insert code here...
       // NSLog(@"Hello, World!");
        NSString *publicKey = @"8959d2ced61bee338accd16794538ec0a49da0655ddca8fa2461d4cf419dafaf4d7c47813f6ac8c6e5646a2beb08cccf4184a831e683a631e3c528b908deecc57235d03935d0650fbe53d44f717da7f5d1622e7405a3b4f06377eb506880dae21e5065c878c03d85113e068ac82af6b29037d57163d9a311807bee654927d349";
        NSString* encodeStr = [RSAUtil RSAEncrypotoTheData:@"123" withData:[RSAUtil stringToHexData:publicKey]];
        NSLog(encodeStr);
    }
    return 0;
}
