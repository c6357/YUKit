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
+(NSString*)uuidString;

/**
 *从前开始查找字符串
 @return -1 没有找到
 */
-(NSInteger)indexOf:(NSString*)search;

/**
 *从后开始查找字符串
 @return -1 没有找到
 */
-(NSInteger)lastIndexOf:(NSString*)search;

/**
 *去除字符串前后空格
 */
-(NSString*)trim;


/**
 待废弃
 *手机号码信息安全格式（135****2345）
 */
-(NSString *)stringFilter;


/**
 *手机号码信息安全格式（135****2345）
 */
-(NSString *)phoneFilter;


/**
 *姓名信息安全格式（王**）
 */
-(NSString *)nameFilter;


/**
 *身份证信息安全格式（500***********1234）
 */
-(NSString *)idNoFilter;




-(NSString *)stringFilterByString:(NSString *)string;


/**
 *16位条形码数字格式
 */
- (NSString *)stringToCodeStyle;


/**
 *价格输入格式(三位数一个逗号)
 */
- (NSString *)stringToCommaStyle;


#pragma mark - URL
/**
 Returns a new string encoded for a URL parameter. (Deprecated)
 
 The following characters are encoded: `:/=,!$&'()*+;[]@#?`.
 
 @return A new string escaped for a URL parameter.
 */
- (NSString *)URLEncodedParameterString;


/**
 Returns a new string decoded from a URL.
 
 @return A new string decoded from a URL.
 */
- (NSString *)URLDecodedString;

/**
 * Parses a URL query string into a dictionary.
 */
- (NSDictionary*)queryDictionaryUsingEncoding;


/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;



#pragma mark - Hash
/** Returns an MD5 string of from the given `NSString`.
 @return A MD5 string.
 */
- (NSString *) md5String;


/**
 Returns a string of the SHA1 sum of the receiver.
 @return The string of the SHA1 sum of the receiver.
 */
- (NSString *)SHA1Sum;


/**
 Returns a string of the SHA256 sum of the receiver.
 
 @return The string of the SHA256 sum of the receiver.
 */
- (NSString *)SHA256Sum;





#pragma mark - Encode and decode

-(NSString*)AES128EncryToBase64String:(NSString *)password;

-(NSString*)AES128DecryptWithKey:(NSString*)password;

-(NSString*)DESEncryToBase64String:(NSString *)password;

-(NSString*)DESDecryptWithKey:(NSString*)password;


@end

