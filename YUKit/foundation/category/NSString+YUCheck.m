//
//  NSString+YUCheck.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSString+YUCheck.h"
#import "YUKit.h"

@implementation NSString (YUCheck)

-(BOOL)isCanBeUse{
    NSString *a = self;
    return (
        (a != nil)
        && (a != NULL)
        && !([(a) isEqual:[NSNull null]])
        && ((a).length>0)
        && !([[NSString stringWithFormat:@"%@",(a)] isEqualToString:@"<null>"])
        && !([[NSString stringWithFormat:@"%@",(a)] isEqualToString:@"(null)"])
        );
}

- (BOOL)isBlankString{
    
    if (self == nil) {
        return YES;
    }
    
    if (self == NULL) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isEmptyOrWhitespace {
   return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0;
}

- (BOOL)isNormal
{
    NSString *		regex = @"([^%&',;=!~?$]+)";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isMobilephone
{
    BOOL ret = FALSE;
    NSString *regex =  @"^(\\+86|(\\(\\+86\\)))?(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+[0-9]{8})$";
    
    if (isSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;
}

- (BOOL)isTelephone
{
    BOOL ret = FALSE;
    NSString *regex =  @"^((\\+86)|(\\(\\+86\\)))?\\D?((((010|021|022|023|024|025|026|027|028|029|852)|(\\(010\\)|\\(021\\)|\\(022\\)|\\(023\\)|\\(024\\)|\\(025\\)|\\(026\\)|\\(027\\)|\\(028\\)|\\(029\\)|\\(852\\)))\\D?\\d{8}|((0[3-9][1-9]{2})|(\\(0[3-9][1-9]{2}\\)))\\D?\\d{7,8}))(\\D?\\d{1,4})?$";
    
    if (isSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;
}

- (BOOL)isEmail
{
    NSString *regex = @"[a-zA-Z_]{1,}[0-9]{0,}@(([a-zA-z0-9]-*){1,}\\.){1,3}[a-zA-z\\-]{1,}" ;
    BOOL ret = FALSE;
    if (isSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;
}

- (BOOL)isUrl
{
    NSString *		regex = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

- (BOOL)isNumber
{
    BOOL ret = FALSE;
    
    NSString *regex = @"^[0-9]*$";
    if (isSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return ret;
}

- (BOOL)isChinese
{
    NSString *		regex = @"(^[\u4e00-\u9fa5]{2,16}$)";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}


-(BOOL)isNumberic
{
    BOOL ret = FALSE;
    
    NSString *regex = @"^[0-9]*$";
    if (isSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return ret;
}

-(BOOL)isDecimal
{
    BOOL ret = FALSE;
    
    NSString *regex = @"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$";
    if (isSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return ret;
}

- (BOOL)isContainString:(NSString*)substring{
    return !([self rangeOfString:substring].location == NSNotFound);
}

- (BOOL)isContainSpecialCharact{
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}

- (BOOL)isIPAddress
{
    NSArray *			components = [self componentsSeparatedByString:@"."];
    NSCharacterSet *	invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
    
    if ( [components count] == 4 )
    {
        NSString *part1 = [components objectAtIndex:0];
        NSString *part2 = [components objectAtIndex:1];
        NSString *part3 = [components objectAtIndex:2];
        NSString *part4 = [components objectAtIndex:3];
        
        if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
            [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
        {
            if ( [part1 intValue] < 255 &&
                [part2 intValue] < 255 &&
                [part3 intValue] < 255 &&
                [part4 intValue] < 255 )
            {
                return YES;
            }
        }
    }
    
    return NO;
}

@end
