//
//  StringCheck.m
//  Will
//
//  Created by SDLL18 on 15/3/11.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import "StringCheck.h"

@implementation StringCheck

+ (BOOL) NSStringIsValidEmail:(NSString*)checkString
{
    if ([checkString length] == 0) {
        return NO;
    }
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilterString ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (BOOL)NSStringIsValidTel:(NSString *)checkString
{
    if ([checkString length] == 0) {
        return NO;
    }
    //1[0-9]{10}
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    //    NSString *regex = @"[0-9]{11}";
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:checkString];
}

@end