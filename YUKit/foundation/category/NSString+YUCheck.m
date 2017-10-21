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


- (BOOL)isValidateIDNumber{
    
    if(!isSafeString(self)){
        return NO;
    }
    
    NSString * identityString = self;
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}


@end
