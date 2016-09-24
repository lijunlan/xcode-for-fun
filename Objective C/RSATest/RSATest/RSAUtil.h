//
//  RSAUtil.h
//  RSATest
//
//  Created by SDLL18 on 15/8/28.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface RSAUtil : NSObject

+(SecKeyRef)getPublicKey:(NSData *)indata;
+ (NSData *) stringToHexData:(NSString *)str;
+(NSString *)RSAEncrypotoTheData:(NSString *)plainText withData:(NSData *)indata;
+(NSString *) dataToHexString:(NSData*) byte;

@end
