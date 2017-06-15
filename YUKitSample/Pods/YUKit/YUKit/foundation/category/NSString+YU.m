//
//  NSString+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+YU.h"
#import "NSData+YU.h"
//#import "UIApplication+YUShare.h"
#import "YUKit.h"
#import "NSDate+YU.h"



@implementation NSString (YU)

+ (NSString *)generateGuid {
    CFUUIDRef	uuidObj = CFUUIDCreate(nil);//create a new UUID
    //get the string representation of the UUID
    NSString	*uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return uuidString ;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
// Copied and pasted from http://www.mail-archive.com/cocoa-dev@lists.apple.com/msg28175.html
- (NSDictionary*)queryDictionaryUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator]) {
        NSString* value = [query objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
        value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    if ([self rangeOfString:@"?"].location == NSNotFound) {
        return [self stringByAppendingFormat:@"?%@", params];
    } else {
        return [self stringByAppendingFormat:@"&%@", params];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSComparisonResult)versionStringCompare:(NSString *)other {
    NSArray *oneComponents = [self componentsSeparatedByString:@"a"];
    NSArray *twoComponents = [other componentsSeparatedByString:@"a"];
    
    // The parts before the "a"
    NSString *oneMain = [oneComponents objectAtIndex:0];
    NSString *twoMain = [twoComponents objectAtIndex:0];
    
    // If main parts are different, return that result, regardless of alpha part
    NSComparisonResult mainDiff;
    if ((mainDiff = [oneMain compare:twoMain]) != NSOrderedSame) {
        return mainDiff;
    }
    
    // At this point the main parts are the same; just deal with alpha stuff
    // If one has an alpha part and the other doesn't, the one without is newer
    if ([oneComponents count] < [twoComponents count]) {
        return NSOrderedDescending;
    } else if ([oneComponents count] > [twoComponents count]) {
        return NSOrderedAscending;
    } else if ([oneComponents count] == 1) {
        // Neither has an alpha part, and we know the main parts are the same
        return NSOrderedSame;
    }
    
    // At this point the main parts are the same and both have alpha parts. Compare the alpha parts
    // numerically. If it's not a valid number (including empty string) it's treated as zero.
    NSNumber *oneAlpha = [NSNumber numberWithInt:[[oneComponents objectAtIndex:1] intValue]];
    NSNumber *twoAlpha = [NSNumber numberWithInt:[[twoComponents objectAtIndex:1] intValue]];
    return [oneAlpha compare:twoAlpha];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)md5Hash {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] MD5Sum];
}

- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}

NSMutableData* receivedData;
-(NSString *)AnalyticalTitle{
    
    NSString *UrlStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:self] encoding:NSUTF8StringEncoding error:nil];
    if(!UrlStr){
        UrlStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:self] encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000) error:nil];
    }
    
    //    if(!UrlStr){
    //        NSMutableURLRequest  *request = [[NSMutableURLRequest alloc] init];
    //        [request setURL:[NSURL URLWithString:self]];
    //        [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    //        [request setTimeoutInterval:5.0];
    //
    //       receivedData = [[NSMutableData alloc] init];
    //
    //        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request     delegate:self];
    //        if (connection == nil) {
    //            return nil;
    //        }
    //
    //    }
    //
    if (UrlStr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self]]];
//            webView.delegate = self;
//            webView.mediaPlaybackRequiresUserAction = NO;
//            webView.mediaPlaybackAllowsAirPlay = NO;
//            [ApplicationDelegate.window addSubview:webView];
        });
        
    }
    
    
    
    NSMutableString *titleStr  = nil;
    if (UrlStr) {
        
        NSRange range = [UrlStr rangeOfString:@"<title>"];
        
        if (range.location != NSNotFound) {
            NSMutableString *needTidyString=[NSMutableString stringWithString:[UrlStr substringFromIndex:range.location+range.length]];
            
            NSRange rang2=[needTidyString rangeOfString:@"</title>"];
            
            titleStr =[NSMutableString stringWithString:[needTidyString substringToIndex:rang2.location]];
            
            NSLog(@"titleStr == %@",titleStr);
        }
        
    }
    
    return titleStr;
}





- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data {
    
    [receivedData appendData:data];
}


- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response{
    NSLog(@"send=%@ redirect=%@",request.URL,response.URL);
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConn {
    //    NSString *results = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    //    self.title ＝  [webViewstringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
//    [UIApplication sharedApplication].networkActivityIndicatorVisible =NO;
//    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];//获取当前页面的title
    [webView removeFromSuperview];
}



//生成一个guid值
+(NSString*)createGUID{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}
//向前查找字符串
-(NSInteger)indexOf:(NSString*)search{
    NSRange r=[self rangeOfString:search];
    if (r.location!=NSNotFound) {
        return r.location;
    }
    return -1;
}
//向后查找字符串
-(NSInteger)lastIndexOf:(NSString*)search{
    NSRange r=[self rangeOfString:self options:NSBackwardsSearch];
    if (r.location!=NSNotFound) {
        return r.location;
    }
    return -1;
}
//去除字符串前后空格
-(NSString*)Trim{
    if (self) {
        //whitespaceAndNewlineCharacterSet 去除前后空格与回车
        //whitespaceCharacterSet 除前后空格
        return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return @"";
}
//获取文本大小
-(CGSize)textSize:(UIFont*)f withWidth:(CGFloat)w{
#if 1
//    [text sizeWithFontX:font constrainedToSize:(maxSize)lineBreakMode:mode];
    
    CGSize labsize = [self sizeWithFontX:f constrainedToSize:CGSizeMake(w, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return labsize;
#else
    return  [self sizeWithFont:f constrainedToSize:CGSizeMake(w, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
#endif
}
//产生MD5字符串
- (NSString *) stringFromMD5{
    if(self == nil || [self length] == 0)
        return nil;
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    return outputString ;
}
- (NSString *)SHA1Sum {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data SHA1Sum];
}


- (NSString *)SHA256Sum {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data SHA256Sum];
}

//url字符串编码处理
-(NSString*)URLEncode{
    
    NSString *encodedString = ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                   (CFStringRef)self,
                                                                                   NULL,
                                                                                   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                   kCFStringEncodingUTF8));
    
    return encodedString;
    /***
     NSString * encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
     (CFStringRef)self,
     NULL,
     NULL,
     kCFStringEncodingUTF8);
     return encodedString;
     ***/
}
- (NSString *)URLEncodedParameterString {
    static CFStringRef toEscape = CFSTR(":/=,!$&'()*+;[]@#?");
    return ( NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                ( CFStringRef)self,
                                                                NULL,
                                                                toEscape,
                                                                kCFStringEncodingUTF8));
}


- (NSString *)URLDecodedString {
    return ( NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                ( CFStringRef)self,
                                                                                CFSTR(""),
                                                                                kCFStringEncodingUTF8));
}

- (NSString *) escapeHTML{
    NSMutableString *s = [NSMutableString string];
    
    NSUInteger start = 0;
    int len = (int)[self length];
    NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"<>&\""];
    
    while (start < len) {
        NSRange r = [self rangeOfCharacterFromSet:chs options:0 range:NSMakeRange(start, len-start)];
        if (r.location == NSNotFound) {
            [s appendString:[self substringFromIndex:start]];
            break;
        }
        
        if (start < r.location) {
            [s appendString:[self substringWithRange:NSMakeRange(start, r.location-start)]];
        }
        
        switch ([self characterAtIndex:r.location]) {
            case '<':
                [s appendString:@"&lt;"];
                break;
            case '>':
                [s appendString:@"&gt;"];
                break;
            case '"':
                [s appendString:@"&quot;"];
                break;
                //			case '…':
                //				[s appendString:@"&hellip;"];
                //				break;
            case '&':
                [s appendString:@"&amp;"];
                break;
        }
        
        start = r.location + 1;
    }
    
    return s;
}

- (NSString *) unescapeHTML{
    NSMutableString *s = [NSMutableString string];
    NSMutableString *target = [self mutableCopy];
    NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"&"];
    
    while ([target length] > 0) {
        NSRange r = [target rangeOfCharacterFromSet:chs];
        if (r.location == NSNotFound) {
            [s appendString:target];
            break;
        }
        
        if (r.location > 0) {
            [s appendString:[target substringToIndex:r.location]];
            [target deleteCharactersInRange:NSMakeRange(0, r.location)];
        }
        
        if ([target hasPrefix:@"&lt;"]) {
            [s appendString:@"<"];
            [target deleteCharactersInRange:NSMakeRange(0, 4)];
        } else if ([target hasPrefix:@"&gt;"]) {
            [s appendString:@">"];
            [target deleteCharactersInRange:NSMakeRange(0, 4)];
        } else if ([target hasPrefix:@"&quot;"]) {
            [s appendString:@"\""];
            [target deleteCharactersInRange:NSMakeRange(0, 6)];
        } else if ([target hasPrefix:@"&#39;"]) {
            [s appendString:@"'"];
            [target deleteCharactersInRange:NSMakeRange(0, 5)];
        } else if ([target hasPrefix:@"&amp;"]) {
            [s appendString:@"&"];
            [target deleteCharactersInRange:NSMakeRange(0, 5)];
        } else if ([target hasPrefix:@"&hellip;"]) {
            [s appendString:@"…"];
            [target deleteCharactersInRange:NSMakeRange(0, 8)];
        } else {
            [s appendString:@"&"];
            [target deleteCharactersInRange:NSMakeRange(0, 1)];
        }
    }
    
    return s;
}
#pragma mark - URL Escaping and Unescaping

- (NSString *)stringByEscapingForURLQuery {
    NSString *result = self;
    
    static CFStringRef leaveAlone = CFSTR(" ");
    static CFStringRef toEscape = CFSTR("\n\r:/=,!$&'()*+;[]@#?%");
    
    CFStringRef escapedStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, ( CFStringRef)self, leaveAlone,
                                                                     toEscape, kCFStringEncodingUTF8);
    
    if (escapedStr) {
        NSMutableString *mutable = [NSMutableString stringWithString:(__bridge  NSString *)escapedStr];
        CFRelease(escapedStr);
        
        [mutable replaceOccurrencesOfString:@" " withString:@"+" options:0 range:NSMakeRange(0, [mutable length])];
        result = mutable;
    }
    return result;
}


- (NSString *)stringByUnescapingFromURLQuery {
    NSString *deplussed = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return [deplussed stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString*) stringByRemovingHTML{
    
    NSString *html = self;
    NSScanner *thescanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([thescanner isAtEnd] == NO) {
        [thescanner scanUpToString:@"<" intoString:NULL];
        [thescanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
    }
    return html;
}

#pragma mark - Base64 Encoding

- (NSString *)base64EncodedString  {
    if ([self length] == 0) {
        return nil;
    }
    
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}



-(NSDate*)dateFromString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    //   NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *destDate= [dateFormatter dateFromString:self];
    
    return destDate;
}
-(NSDate*)dateFromSql
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss.SSS"];
    //   NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSDate *destDate= [dateFormatter dateFromString:self];
    
    return destDate;
}

-(NSString*)dateString2SYBDateFormat
{
    NSDate *date = [self dateFromString];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy.MM.dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return  destDateString;
}


+(NSString*)stringFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return  destDateString;
}


+(NSString*)cnStringFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy年M月d日"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return  destDateString;
}


-(NSString*)AES128EncryToBase64String:(NSString *)password
{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    data = [data AES128Operation:kCCEncrypt key:password];
    return [data base64EncodedString];
}


-(NSString*)AES128DecryptWithKey:(NSString*)password
{
    NSData *data = [NSData dataFromBase64String:self];
    data = [data AES128Operation:kCCDecrypt key:password];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

-(NSString*)DESEncryToBase64String:(NSString *)password
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    data = [data DESEncryptWithKey:password];
    return [data base64EncodedString];
}


-(NSString*)DESDecryptWithKey:(NSString*)password
{
    NSData *data = [NSData dataFromBase64String:self];
    data = [data DESDecryptWithKey:password];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


+(NSString*)gen_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(NSString*)CFBridgingRelease(uuid_string_ref)];
    
    return uuid;
}

-(CGSize)caluateWidth:(UIFont*)font
{
#if 1
    CGSize labsize = [self sizeWithFontX:font constrainedToSize:CGSizeMake(9999,9999)lineBreakMode:NSLineBreakByWordWrapping];
#else
    CGSize labsize = [self sizeWithFont:font constrainedToSize:CGSizeMake(999, 999) lineBreakMode:NSLineBreakByWordWrapping];
    
#endif
    return labsize;
}

- (CGSize)sizeWithFontX:(UIFont *)font forWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize retSize = CGSizeZero;
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = lineBreakMode;
        
        NSDictionary *dict = @{NSFontAttributeName:font,
                               NSParagraphStyleAttributeName:paraStyle};
        CGSize size = CGSizeMake(width, font.lineHeight);
        
        CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        retSize = rect.size;
    } else {
        WarnIgnore_Deprecate(retSize = [self sizeWithFont:font forWidth:width lineBreakMode:lineBreakMode];);
        
    }
    
    return retSize;
}

- (CGSize)sizeWithFontX:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize retSize = CGSizeZero;
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = lineBreakMode;
        
        NSDictionary *dict = @{NSFontAttributeName:font,
                               NSParagraphStyleAttributeName:paraStyle};
        
        CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        retSize = rect.size;
    } else {
        WarnIgnore_Deprecate(retSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];);
        
    }
    
    return retSize;
}




#pragma mark -

+ (NSString *)urlencode:(NSString *)uStr
{
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)uStr,
                                                              NULL,
                                                              (CFStringRef)@"+' '/?%#&",
                                                              kCFStringEncodingUTF8));
    return outputStr;
}


- (NSString *)md5{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+(NSString*)stringRemoveSpace:(NSString*)str{
    
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
}

+(NSString*)timeInterval1970{
    NSTimeInterval timeInterval =[[NSDate date] timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f",timeInterval*1000];
}






+(NSString *)getCurrentDate:(NSString *)pattern{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:pattern];
    return [dateFormatter stringFromDate:[NSDate date]];
}


+(NSString *)dateToString:(NSDate*)date DateFormat:(NSString*)DateFormat{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:DateFormat];
    NSString *str = [outputFormatter stringFromDate:date];
    return str;
}


+(NSString *)dateToStringCheckToday:(NSDate*)date DateFormat:(NSString*)DateFormat{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    NSString *str = nil;
    if ([date isEqualDay:[NSDate date]]) {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:@"HH:mm"];
        str = [NSString stringWithFormat:@"今天 %@",[outputFormatter stringFromDate:date]];
    }else{
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:DateFormat];
        str = [outputFormatter stringFromDate:date];
    }
    return str;
}

+(NSString *)stringToString:(NSString*)pattern1 NewRule:(NSString*)pattern2 dateString:(NSString*)dateStr
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:pattern1];
    
    
    NSDate* inputDate = [inputFormatter dateFromString:dateStr];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:pattern2];
    
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}



+(NSString *)stringToString2:(NSString*)pattern1 NewRule:(NSString*)pattern2 dateString:(NSString*)dateStr
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:pattern1];
    
    
    NSDate* inputDate = [inputFormatter dateFromString:dateStr];
    
    NSString *str = nil;
    
    NSDate *otherDate = [[NSDate date] dateByAddingTimeInterval:-24*60*60];
    if ([otherDate isEqualDay:inputDate]) {
        str = [NSString stringWithFormat:@"昨天 %@",[self getTime:inputDate]];
        return str;
    }else if ([inputDate isEqualDay:[NSDate date]]) {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:@"HH:mm"];
        str = [NSString stringWithFormat:@"今天 %@",[outputFormatter stringFromDate:inputDate]];
    }else{
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:pattern2];
        str = [outputFormatter stringFromDate:inputDate];
    }
    return str;
}

//获取时分
+(NSString *)getTime:(NSDate *)date{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"HH:mm"];
    return [outputFormatter stringFromDate:date];
}

+(NSString*)adjustTime:(NSDate*)date
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *_components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:_components];
    
    _components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
    NSDate *otherDate = [cal dateFromComponents:_components];
    
    if([today isEqualToDate:otherDate]) {
        _components = [cal components:(NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:date];
        return [NSString stringWithFormat:@"%d:%02d",(int)_components.hour,(int)_components.minute];
    } else {
        otherDate = [otherDate dateByAddingTimeInterval: 24*60*60 ];
        
        if ([today isEqualToDate:otherDate]) {
            _components = [cal components:(NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:date];
            return [NSString stringWithFormat:@"昨天 %d:%02d",(int)_components.hour,(int)_components.minute];
        } else {
            _components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:date];
            if ([self GetYear] != _components.year) {
                return [NSString stringWithFormat:@"%d-%d-%d %d:%02d",(int)_components.year,(int)_components.month,(int)_components.day,(int)_components.hour,(int)_components.minute];
            } else {
                return [NSString stringWithFormat:@"%d-%d %d:%02d",/*_components.year*,*/(int)_components.month,(int)_components.day,(int)_components.hour,(int)_components.minute];
            }
        }
    }
}

+(int)GetYear{
    NSDate *now = [NSDate date];
    //    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    int year = (int)[dateComponent year];
    //    int month = [dateComponent month];
    //    int day = [dateComponent day];
    //    int hour = [dateComponent hour];
    //    int minute = [dateComponent minute];
    //    int second = [dateComponent second];
    //    NSLog(@"year is: %d", year);
    //    NSLog(@"month is: %d", month);
    //    NSLog(@"day is: %d", day);
    //    NSLog(@"hour is: %d", hour);
    //    NSLog(@"minute is: %d", minute);
    //    NSLog(@"second is: %d", second);
    
    return year;
}

+(NSString*)GetCustmoerDate{
    NSDate *now = [NSDate date];
    //    NSLog(@"now date is: %@", now);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    
    dateComponent = [calendar components:unitFlags fromDate:now];
    int hour = (int)[dateComponent hour];
    int minute = (int)[dateComponent minute];
    return [NSString stringWithFormat:@"%d:%d",hour,minute];
}

+(NSString*)switchTime:(NSDate*)date
{
    if (!date) {
        date = [NSDate date];
    }
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
    NSDate *today = [cal dateFromComponents:components];
    
    components = [cal components:(NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:date];
    NSDate *otherDate = [cal dateFromComponents:components];
    if([today isEqualToDate:otherDate]) {
        components = [cal components:(NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:date];
        return [NSString stringWithFormat:@"%d:%02d",(int)components.hour,(int)components.minute];
    } else {
        otherDate = [otherDate dateByAddingTimeInterval:24*60*60];
        if ([today isEqualToDate:otherDate]) {
            return @"昨天";
        } else {
            if ([self GetYear] > components.year) {
                return [NSString stringWithFormat:@"%d-%02d-%02d",(int)components.year,(int)components.month,(int)components.day];
            }
            return [NSString stringWithFormat:@"%02d-%02d",/*components.year,*/(int)components.month,(int)components.day];
        }
    }
}

+(CGSize)LabSize:(UIFont*)Labfont labTex:(NSString*)Text{
    
    NSDictionary * attribute = [NSDictionary dictionaryWithObjectsAndKeys:Labfont,NSFontAttributeName,nil];
    CGSize actualsize = [Text boundingRectWithSize:CGSizeMake(APP_WIDTH(), 10000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    actualsize.width += 2;
    return actualsize;
}

+(CGSize)LabSize:(UIFont*)Labfont labTex:(NSString*)Text width:(CGFloat)width{
    
    NSDictionary * attribute = [NSDictionary dictionaryWithObjectsAndKeys:Labfont,NSFontAttributeName,nil];
    CGSize actualsize = [Text boundingRectWithSize:CGSizeMake(width, 10000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    actualsize.width += 2;
    return actualsize;
}


+ (NSString *)AddComma:(NSString *)string{//添加逗号
    string = [NSString stringWithFormat:@"%.2f",[string doubleValue]];
    double value = [string doubleValue];
    long long x = (long long)value;
    
    NSString *y = nil;
    NSRange range = [string rangeOfString:@"."];
    if (range.location != NSNotFound) {
        y = [string substringFromIndex:range.location];
    }
    
    
    NSMutableString *sStr = [NSMutableString stringWithFormat:@"%lld",x];
    int length = (int)[sStr length];
    int start = [sStr length] % 3 ;
    if (start == 0) {
        start = 3;
    }
    
    int loop = ceil(length / 3.0) - 1;
    for (int k = 0; k < loop ; k++) {
        [sStr insertString:@"," atIndex:start + k * 4];
    }
    
    if (y != nil) {
        [sStr appendString:y];
    }
    
    return sStr;
}

+(NSString*)CUfilterString :(NSString*)_string{
    
    return _string;
    
    if (IsSafeString(_string)) {
        return [self GetString:[_string length]];
    }
    return @"";
}

//过滤 只显示前3位
+(NSString *)filterPhone:(NSString *)phone{
    return phone;
    if (IsSafeString(phone)) {
        NSMutableString *str = [NSMutableString stringWithString:phone];
        [str replaceCharactersInRange:NSMakeRange(3, phone.length-3) withString:@"********"];
        
        return str;
    }
    return @"";
}

+(NSString*)CUfilterPhone :(NSString*)_phone{
    
    NSMutableString *_tempStr = [NSMutableString new];
    
    if (IsSafeString(_phone)) {
        
        NSString *firistStr = [_phone substringToIndex:3];
        [_tempStr appendString:firistStr];
        
        [_tempStr appendString:[self GetString:[_phone length]-6]];
        
        NSString *lastStr = [_phone substringFromIndex:[_phone length]-3];
        [_tempStr appendString:lastStr];
    }
    
    return _tempStr;
}

+(NSString*)GetString :(NSInteger)Num{
    
    NSMutableString *tempStr = [[NSMutableString alloc] initWithCapacity:Num];
    for (int i=0; i<Num; i++) {
        [tempStr appendString:@"*"];
    }
    return SafeString(tempStr);
}


+(CTParagraphStyleRef)textStyleref{
    CTParagraphStyleSetting lineBreakMode;
    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping;
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.value = &lineBreak;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    
    //段缩进
    CGFloat headindent = 0.0f;
    CTParagraphStyleSetting head;
    head.spec = kCTParagraphStyleSpecifierHeadIndent;
    head.value = &headindent;
    head.valueSize = sizeof(float);
    
    CGFloat fristlineindent = 0.0f;
    CTParagraphStyleSetting fristline;
    fristline.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
    fristline.value = &fristlineindent;
    fristline.valueSize = sizeof(float);
    
    //对齐方式
    CTTextAlignment alignment = kCTJustifiedTextAlignment;
    CTParagraphStyleSetting alignmentStyle;
    alignmentStyle.spec=kCTParagraphStyleSpecifierAlignment;//指定为对齐属性
    alignmentStyle.valueSize=sizeof(alignment);
    alignmentStyle.value=&alignment;
    
    //行距
    CGFloat _linespace = 0.0f;
    CTParagraphStyleSetting lineSpaceSetting;
    lineSpaceSetting.spec = kCTParagraphStyleSpecifierLineSpacing;
    lineSpaceSetting.value = &_linespace;
    lineSpaceSetting.valueSize = sizeof(float);
    
    CTParagraphStyleSetting settings[] = {
        lineBreakMode,fristline,head,alignmentStyle
    };
    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 4);
    
    return style;
}

+(NSString*)uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(NSString*)CFBridgingRelease(uuid_string_ref)];
    
    return uuid;
}



+(NSString*)timestamp{
    NSNumber *time = [NSNumber numberWithUnsignedInteger:(NSUInteger)([NSDate date].timeIntervalSince1970*1000)];
    return TrToString(time);
}

-(NSMutableAttributedString*)dishPrice{
    NSMutableAttributedString *txt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@/份",self]];
    
    [txt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:NSMakeRange(0, self.length)];
    
    [txt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0,self.length)];
    return txt;
}

+(NSString*)priceStyle:(double)price{
    
    NSString *priceStr =  [NSString stringWithFormat:@"%.2f",price];
    
    //    if([priceStr rangeOfString:@"."].length>0){
    //
    //    }
    
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(priceStr.floatValue)];
    
    return outNumber;
}

-(NSMutableAttributedString*)redText:(NSString*)text{
    
    NSMutableAttributedString *txt = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",self,text]];
    
    //    [txt addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:22] range:NSMakeRange(1, text.length)];
    
    [txt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(self.length,text.length)];
    return txt;
}


//static NSString *lineStr = @"——";
//-(NSMutableString*)dishNameForHeaderInSection:(UIFont*)font width:(float)width{
//    NSMutableString *str = [NSMutableString new];
//    float le = [Utils LabSize:font labTex:lineStr].width;
//    float sLe = [Utils LabSize:font labTex:self].width;
//    float SL = width - sLe -10;
//    
//    [str appendString:[self linStr:SL/2/le S:lineStr]];
//    [str appendString:[self linStr:5 S:@" "]];
//    [str appendString:self];
//    [str appendString:[self linStr:5 S:@" "]];
//    [str appendString:[self linStr:SL/2/le S:lineStr]];
//    return str;
//}
//-(NSMutableString*)linStr:(int)num S:(NSString*)s{
//    NSMutableString *str = [NSMutableString new];
//    for (int i = 0 ; i<num ; i++) {
//        [str appendString:s];
//    }
//    return str;
//}
@end
