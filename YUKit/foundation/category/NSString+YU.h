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
+ (NSString *)generateGuid;

/**
 * Parses a URL query string into a dictionary.
 */
- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding;


/**
 * Parses a URL, adds query parameters to its query, and re-encodes it as a new URL.
 */
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query;

/**
 * Compares two strings expressing software versions.
 *
 * The comparison is (except for the development version provisions noted below) lexicographic
 * string comparison. So as long as the strings being compared use consistent version formats,
 * a variety of schemes are supported. For example "3.02" < "3.03" and "3.0.2" < "3.0.3". If you
 * mix such schemes, like trying to compare "3.02" and "3.0.3", the result may not be what you
 * expect.
 *
 * Development versions are also supported by adding an "a" character and more version info after
 * it. For example "3.0a1" or "3.01a4". The way these are handled is as follows: if the parts
 * before the "a" are different, the parts after the "a" are ignored. If the parts before the "a"
 * are identical, the result of the comparison is the result of NUMERICALLY comparing the parts
 * after the "a". If the part after the "a" is empty, it is treated as if it were "0". If one
 * string has an "a" and the other does not (e.g. "3.0" and "3.0a1") the one without the "a"
 * is newer.
 *
 * Examples (?? means undefined):
 *   "3.0" = "3.0"
 *   "3.0a2" = "3.0a2"
 *   "3.0" > "2.5"
 *   "3.1" > "3.0"
 *   "3.0a1" < "3.0"
 *   "3.0a1" < "3.0a4"
 *   "3.0a2" < "3.0a19"  <-- numeric, not lexicographic
 *   "3.0a" < "3.0a1"
 *   "3.02" < "3.03"
 *   "3.0.2" < "3.0.3"
 *   "3.00" ?? "3.0"
 *   "3.02" ?? "3.0.3"
 *   "3.02" ?? "3.0.2"
 */
- (NSComparisonResult)versionStringCompare:(NSString *)other;

/**
 * Calculate the md5 hash of this string using CC_MD5.
 *
 * @return md5 hash of this string
 */
@property (nonatomic, readonly) NSString* md5Hash;

- (NSString *)URLEncodedString;


-(NSString *)AnalyticalTitle;




/** Returns a `NSString`.
 @return a guid string.
 */
+(NSString*)createGUID;
/** 向前查找字符串.
 @return 查找到字符串的位置,否则返回-1
 */
-(NSInteger)indexOf:(NSString*)search;
/** 向后查找字符串.
 @return 查找到字符串的位置,否则返回-1
 */
-(NSInteger)lastIndexOf:(NSString*)search;
/** 去除字符串前后空格.
 @return 去除字符串前后空格的字符串
 */
-(NSString*)Trim;
/** 根据字体与宽度计算字符串的大小.
 @return 获取文本大小
 */
-(CGSize)textSize:(UIFont*)f withWidth:(CGFloat)w;
/** Returns an MD5 string of from the given `NSString`.
 @return A MD5 string.
 */
- (NSString *) stringFromMD5;
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
/** Returns a `NSString` that is URL friendly.
 @return A URL encoded string.
 */
-(NSString*)URLEncode;
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




/** Returns a `NSString` that properly replaces HTML specific character sequences.
 @return An escaped HTML string.
 
 */
- (NSString *) escapeHTML;

/** Returns a `NSString` that properly formats text for HTML.
 @return An unescaped HTML string.
 */
- (NSString *) unescapeHTML;
///----------------------------------
/// @name URL Escaping and Unescaping
///----------------------------------

/**
 Returns a new string escaped for a URL query parameter.
 
 The following characters are escaped: `\n\r:/=,!$&'()*+;[]@#?%`. Spaces are escaped to the `+` character. (`+` is
 escaped to `%2B`).
 
 @return A new string escaped for a URL query parameter.
 
 @see stringByUnescapingFromURLQuery
 */
- (NSString *)stringByEscapingForURLQuery;

/**
 Returns a new string unescaped from a URL query parameter.
 
 `+` characters are unescaped to spaces.
 
 @return A new string escaped for a URL query parameter.
 
 @see stringByEscapingForURLQuery
 */
- (NSString *)stringByUnescapingFromURLQuery;

/** Returns a `NSString` that removes HTML elements.
 @return Returns a string without the HTML elements.
 */
- (NSString*) stringByRemovingHTML;


///----------------------
/// @name Base64 Encoding
///----------------------

/**
 Returns a string representation of the receiver Base64 encoded.
 
 @return A Base64 encoded string
 */
- (NSString *)base64EncodedString;

/**
 Returns a new string contained in the Base64 encoded string.
 
 This uses `NSData`'s `dataWithBase64String:` method to do the conversion then initializes a string with the resulting
 `NSData` object using `NSUTF8StringEncoding`.
 
 @param base64String A Base64 encoded string
 
 @return String contained in `base64String`
 */
//+ (NSString *)stringWithBase64String:(NSString *)base64String;

-(NSDate*)dateFromSql;
-(NSDate*)dateFromString;
-(NSString*)dateString2SYBDateFormat;

+(NSString*)stringFromDate:(NSDate*)date;
+(NSString*)cnStringFromDate:(NSDate*)date;
//-(NSString*)stringEncodeBase64;
-(NSString*)AES128EncryToBase64String:(NSString *)password;
-(NSString*)AES128DecryptWithKey:(NSString*)password;

-(NSString*)DESDecryptWithKey:(NSString*)password;
-(NSString*)DESEncryToBase64String:(NSString *)password;

-(CGSize)caluateWidth:(UIFont*)font;
+(NSString*)gen_uuid;

- (CGSize)sizeWithFontX:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeWithFontX:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;



// - URL转义
+ (NSString *)urlencode:(NSString *)uStr;


/**
 * MD5加密
 * @param str 需要加密的内容
 * @return 加密后的字符串
 **/
- (NSString *)md5;

/*****
 * 去掉字符串左右空格
 * @param nibName ViewController.xib 文件名
 * @param ViewController 或 ViewController_Iphone5
 ****/
+(NSString*)stringRemoveSpace:(NSString*)str;
/***
 *获取当前时间
 *@return 毫秒
 **/
+(NSString*)timeInterval1970;

/**
 * 取得当前日期    第一个参数是日期格式
 * @param pattern 　   规则｜格式
 **/
+(NSString *)getCurrentDate:(NSString *)pattern;


+(NSString *)dateToString:(NSDate*)date DateFormat:(NSString*)DateFormat;


+(NSString *)dateToStringCheckToday:(NSDate*)date DateFormat:(NSString*)DateFormat;


/**
 *日期类型转换为字符类型,第一个参数是日期格式,第二个参数为传入的日期
 *@param pattern 1　     原规则｜格式
 *@param pattern 2 　    新规则｜格式
 *@param dateStr 　日期串
 **/
+(NSString *)stringToString:(NSString*)pattern1 NewRule:(NSString*)pattern2 dateString:(NSString*)dateStr;


/**
 *日期类型转换为字符类型,第一个参数是日期格式,第二个参数为传入的日期  如果日期是当天则显示为今天
 *@param pattern 1　     原规则｜格式
 *@param pattern 2 　    新规则｜格式
 *@param dateStr 　日期串
 **/
+(NSString *)stringToString2:(NSString*)pattern1 NewRule:(NSString*)pattern2 dateString:(NSString*)dateStr;


+(NSString*)switchTime:(NSDate*)date;

+(NSString*)adjustTime:(NSDate*)date;



+(CGSize)LabSize:(UIFont*)Labfont labTex:(NSString*)Text;

+(CGSize)LabSize:(UIFont*)Labfont labTex:(NSString*)Text width:(CGFloat)width;



+(NSString *)AddComma:(NSString *)string;//添加逗

+(NSString*)CUfilterString :(NSString*)_string;

+(NSString*)CUfilterPhone :(NSString*)_phone;

+(NSString *)filterPhone:(NSString *)phone;



+(CTParagraphStyleRef)textStyleref;


+(NSString*)uuid;

-(NSMutableAttributedString*)redText:(NSString*)text;

+(NSString*)timestamp;

-(NSMutableAttributedString*)dishPrice;

+(NSString*)priceStyle:(double)price;

//-(NSMutableString*)dishNameForHeaderInSection:(UIFont*)font width:(float)width;

@end
