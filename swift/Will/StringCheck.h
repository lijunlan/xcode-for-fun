//
//  StringCheck.h
//  Will
//
//  Created by SDLL18 on 15/3/11.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface StringCheck : NSObject
+(BOOL) NSStringIsValidEmail:(NSString*)checkString;
+(BOOL) NSStringIsValidTel:(NSString *)checkString;
@end