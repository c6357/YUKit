//
//  NSString+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YU)

#pragma mark - Utilities
/** Returns a `NSString`.
 @return a guid string.
 */
+(NSString*)yu_uuidString;

/**
 *从前开始查找字符串
 @return -1 没有找到
 */
-(NSInteger)yu_indexOf:(NSString*)search;

/**
 *从后开始查找字符串
 @return -1 没有找到
 */
-(NSInteger)yu_lastIndexOf:(NSString*)search;

/**
 *去除字符串前后空格
 */
-(NSString*)yu_trim;


/**
 待废弃
 *手机号码信息安全格式（135****2345）
 */
-(NSString *)yu_stringFilter;


/**
 *手机号码信息安全格式（135****2345）
 */
-(NSString *)yu_phoneFilter;


/**
 *姓名信息安全格式（王**）
 */
-(NSString *)yu_nameFilter;


/**
 *身份证信息安全格式（500***********1234）
 */
-(NSString *)yu_idNoFilter;


/**
 <#Description#>

 @return <#return value description#>
 */
-(NSString *)yu_bankCardNoFilter;


-(NSString *)yu_stringFilterByString:(NSString *)string;


/**
 *16位条形码数字格式
 */
- (NSString *)yu_stringToCodeStyle;


/**
 *价格输入格式(三位数一个逗号)
 */
- (NSString *)yu_stringToCommaStyle;


#pragma mark - URL
/**
 Returns a new string encoded for a URL parameter. (Deprecated)
 
 The following characters are encoded: `:/=,!$&'()*+;[]@#?`.
 
 @return A new string escaped for a URL parameter.
 */
- (NSString *)yu_URLEncodedParameterString;


/**
 Returns a new string decoded from a URL.
 
 @return A new string decoded from a URL.
 */
- (NSString *)yu_URLDecodedString;

/**
 * Parses a URL query string into a dictionary.
 */
- (NSDictionary*)yu_queryDictionaryUsingEncoding;


/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)yu_stringByAddingQueryDictionary:(NSDictionary*)query;



#pragma mark - Hash
/** Returns an MD5 string of from the given `NSString`.
 @return A MD5 string.
 */
- (NSString *) yu_md5String;


/**
 Returns a string of the SHA1 sum of the receiver.
 @return The string of the SHA1 sum of the receiver.
 */
- (NSString *)yu_SHA1Sum;


/**
 Returns a string of the SHA256 sum of the receiver.
 
 @return The string of the SHA256 sum of the receiver.
 */
- (NSString *)yu_SHA256Sum;



/**
 md5加密文件

 @return MD5 String
 */
-(NSString *)yu_md5FileString;


#pragma mark - Encode and decode

-(NSString*)yu_AES128EncryToBase64String:(NSString *)password;

-(NSString*)yu_AES128DecryptWithKey:(NSString*)password;

-(NSString*)yu_DESEncryToBase64String:(NSString *)password;

-(NSString*)yu_DESDecryptWithKey:(NSString*)password;


@end

