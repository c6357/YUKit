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
-(BOOL)yu_isCanBeUse;

/**
 *判断字符串是否为空，以及是否全是空格或者换行
 */
- (BOOL)yu_isBlankString;

/*
 *是否全是空格或者换行
 */
- (BOOL)yu_isEmptyOrWhitespace;

- (BOOL)yu_isNormal;

- (BOOL)yu_isMobilephone;

- (BOOL)yu_isTelephone;

- (BOOL)yu_isEmail;

- (BOOL)yu_isUrl;

- (BOOL)yu_isNumber;


- (BOOL)yu_isChinese;


- (BOOL)yu_isDecimal;

/**
 *是否包含字符串substring
 */
- (BOOL)yu_isContainString:(NSString*)substring;


/**
 *有非法字符
 */
- (BOOL)yu_isContainSpecialCharact;

/**
 *
 */
- (BOOL)yu_isIPAddress;


/**
 是否有效身份证

 @return <#return value description#>
 */
- (BOOL)yu_isValidateIDNumber;

@end
