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
-(BOOL)checkPhoneLength{
    if ([self length]>=11 && [self length]<=14) {
        return YES;
    }
    return NO;
}

-(BOOL)isPhoneNo
{
    BOOL ret = FALSE;
    NSString *regex =  @"^(\\+86|(\\(\\+86\\)))?(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1})|(17[0-9]{1}))+[0-9]{8})$";
    
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;
}

-(BOOL)isCallNo
{
    BOOL ret = FALSE;
    NSString *regex =  @"^((\\+86)|(\\(\\+86\\)))?\\D?((((010|021|022|023|024|025|026|027|028|029|852)|(\\(010\\)|\\(021\\)|\\(022\\)|\\(023\\)|\\(024\\)|\\(025\\)|\\(026\\)|\\(027\\)|\\(028\\)|\\(029\\)|\\(852\\)))\\D?\\d{8}|((0[3-9][1-9]{2})|(\\(0[3-9][1-9]{2}\\)))\\D?\\d{7,8}))(\\D?\\d{1,4})?$";
    
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;
}

-(BOOL)isLocateCallNo
{
    BOOL ret = FALSE;
    NSString *regex =  @"^(([0-9]{7})|(([0-9]{8})))$";
    
    
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;
}

-(BOOL)is400PhoneNo
{
    BOOL ret = FALSE;
    NSString *regex =  @"^400[016789]\\d{6}$";
    
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;
}

-(BOOL)isEmailStr
{
    NSString *regex = @"[a-zA-Z_]{1,}[0-9]{0,}@(([a-zA-z0-9]-*){1,}\\.){1,3}[a-zA-z\\-]{1,}" ;
    BOOL ret = FALSE;
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return  ret;
}

-(BOOL)isPwd
{
    return  IsSafeString(self) && self.length >= 6 && self.length <= 16 ;
}
//-(NSString*)stringEncodeBase64
//{
//    size_t outLen;
//    char *outStr =  mk_NewBase64Encode(self.UTF8String, strlen(self.UTF8String), FALSE, &outLen);
//    if (outLen > 0) {
//        return [NSString stringWithUTF8String:outStr];
//    } else {
//        return nil;
//    }
//}

-(BOOL)isNumberic
{
    BOOL ret = FALSE;
    
    NSString *regex = @"^[0-9]*$";
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return ret;
}

-(BOOL)isDecimal //小数
{
    
    BOOL ret = FALSE;
    
    NSString *regex = @"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$";//@"^\\d{1}$|^\\d{1}$.\\d{1}$";//@"^\\d{1,}$|^\\d{1,}.\\d{2,2}$"; //@"^(0|[1-9]/d*)/.(/d+)$";
    if (IsSafeString(self)) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:self];
    }
    return ret;
}
//-(BOOL)isDigit
//{
//    BOOL ret = FALSE;
//    NSString *regex =  @"^-?\\d+$";
//
//    if (IsSafeString(self)) {
//        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//        ret = [pred evaluateWithObject:self];
//    }
//    return  ret;
//}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isWhitespaceAndNewlines {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isEmptyOrWhitespace {
    return !self.length ||
    ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}


- (BOOL)isEmail{
    
    NSString *emailRegEx =
    @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
    @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
    @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
    @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
    @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
    @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
    @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}
- (BOOL)isURLString{
    NSString *emailRegEx =@"^http(s)?://([\\w-]+.)+[\\w-]+(/[\\w-./?%&=]*)?$";
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    return [regExPredicate evaluateWithObject:[self lowercaseString]];
}

- (BOOL)isHasString:(NSString*)substring{
    return !([self rangeOfString:substring].location == NSNotFound);
}

//有非法字符
-(BOOL)isIncludeSpecialCharact{
    //***需要过滤的特殊字符：~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€。
    NSRange urgentRange = [self rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @"~￥#&*<>《》()[]{}【】^@/￡¤￥|§¨「」『』￠￢￣~@#￥&*（）——+|《》$_€"]];
    if (urgentRange.location == NSNotFound)
    {
        return NO;
    }
    return YES;
}
//验证电话号码
-(BOOL)isValidateTelNumber{
    
    NSString *strRegex = @"[0-9]{1,20}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strRegex];
    return [emailTest evaluateWithObject:self];
}

@end
