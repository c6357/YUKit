//
//  NSString+YUCheck.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YUCheck)

-(BOOL)checkPhoneLength;
-(BOOL)isPhoneNo;
-(BOOL)is400PhoneNo;
-(BOOL)isLocateCallNo;
-(BOOL)isCallNo;
-(BOOL)isEmailStr;
-(BOOL)isPwd;
-(BOOL)isNumberic;
-(BOOL)isDecimal;


- (BOOL)isWhitespaceAndNewlines;

- (BOOL)isEmptyOrWhitespace;

- (BOOL)isEmail;

- (BOOL)isURLString;

- (BOOL)isHasString:(NSString*)substring;

//非法字符
-(BOOL)isIncludeSpecialCharact;

//纯数字
-(BOOL)isValidateTelNumber;
@end
