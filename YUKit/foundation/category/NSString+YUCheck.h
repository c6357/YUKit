//
//  NSString+YUCheck.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YUCheck)

/**
 *是否可以使用 空字符串也允许
 */
-(BOOL)isCanBeUse;

/**
 *判断字符串是否为空，以及是否全是空格或者换行
 */
- (BOOL)isBlankString;

/*
 *是否全是空格或者换行
 */
- (BOOL)isEmptyOrWhitespace;

- (BOOL)isNormal;

- (BOOL)isMobilephone;

- (BOOL)isTelephone;

- (BOOL)isEmail;

- (BOOL)isUrl;

- (BOOL)isNumber;


- (BOOL)isChinese;


- (BOOL)isDecimal;

/**
 *是否包含字符串substring
 */
- (BOOL)isContainString:(NSString*)substring;


/**
 *有非法字符
 */
- (BOOL)isContainSpecialCharact;

/**
 *
 */
- (BOOL)isIPAddress;


/**
 是否有效身份证

 @return <#return value description#>
 */
- (BOOL)isValidateIDNumber;

@end
