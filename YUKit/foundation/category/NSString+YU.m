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
#import "NSString+YUCheck.h"
#import "NSNumber+YU.h"
#import "NSString+YUBase64.h"
#import "NSData+YUBase64.h"

@implementation NSString (YU)

NSString* YU_CheckString(NSString *string){
    
    NSString *s = string;
    if (![s isKindOfClass:[NSString class]]) {
        s = YU_StringWithFormat(string);
    }
    return s;
}



BOOL yu_isSafeString(NSString* string){

    string = YU_CheckString(string);
    return [string yu_isCanBeUse]&& ![string yu_isBlankString];
}

NSString* YU_SafeString(NSString* string){
    
    string = YU_CheckString(string);
    
    if ([string yu_isCanBeUse]) {
        return string;
    }
    return @"";
}

NSString* YU_ComboString(NSString* format,...){
    
    va_list args;
    va_start(args, format);
    NSString *string = [[NSString alloc] initWithFormat:format arguments:args];

    va_end(args);
    return string;
}

NSString* YU_AppendString(NSString* str1,NSString* str2){
    
    return [NSString stringWithFormat:@"%@%@",str1,str2];
    
}

+(NSString*)yu_uuidString
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(NSString*)CFBridgingRelease(uuid_string_ref)];
    return uuid;
}


-(NSInteger)yu_indexOf:(NSString*)search{
    
    NSRange r=[self rangeOfString:search];
    if (r.location!=NSNotFound) {
        return r.location;
    }
    return -1;
}

-(NSInteger)yu_lastIndexOf:(NSString*)search{
    
    NSRange r=[self rangeOfString:search options:NSBackwardsSearch];
    if (r.location!=NSNotFound) {
        return r.location;
    }
    return -1;
}


-(NSString*)yu_trim{
    if (self) {
        return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    }
    return @"";
}


-(NSString *)yu_stringFilter{
    
    if ([self yu_isCanBeUse]) {
        
        NSUInteger len = self.length;
        
        NSMutableString *str = [NSMutableString stringWithString:self];
        [str replaceCharactersInRange:NSMakeRange(MIN(len, 4), self.length-MIN(len, 8)) withString:@"***"];
        
        return str;
    }
    return @"";
}


-(NSString *)yu_phoneFilter{
    if ([self yu_isCanBeUse]) {
        
        NSUInteger len = self.length;
        
        NSMutableString *str = [NSMutableString stringWithString:self];
        [str replaceCharactersInRange:NSMakeRange(MIN(len, 4), self.length-MIN(len, 8)) withString:[self yu_stringFilterWithLenth:len-8]];
        
        return str;
    }
    return @"";
}

-(NSString*)yu_stringFilterWithLenth:(NSInteger)lenth{
    
    NSMutableString *string = [NSMutableString new];
    
    NSInteger len = lenth;
    while (len>0) {
        [string appendFormat:@"*"];
        len --;
    }
    
    return string;
}


-(NSString *)yu_nameFilter{
    
    if ([self yu_isCanBeUse]) {
        
        NSUInteger len = self.length;
        
        NSMutableString *str = [NSMutableString stringWithString:self];
        [str replaceCharactersInRange:NSMakeRange(MIN(len, 1), self.length-MIN(len, 1)) withString:[self yu_stringFilterWithLenth:len-1]];
        
        return str;
    }
    return @"";
}


-(NSString *)yu_idNoFilter{
    if ([self yu_isCanBeUse]) {
        
        NSUInteger len = self.length;
        
        NSMutableString *str = [NSMutableString stringWithString:self];
        [str replaceCharactersInRange:NSMakeRange(MIN(len, 3), self.length-MIN(len, 7)) withString:[self yu_stringFilterWithLenth:len-7]];
        
        return str;
    }
    return @"";
}




-(NSString *)yu_stringFilterByString:(NSString *)string{
        
    if ([string yu_isCanBeUse]) {
        
        NSUInteger len = string.length;
        
        NSMutableString *str = [NSMutableString stringWithString:string];
        [str replaceCharactersInRange:NSMakeRange(MIN(len, 4), string.length-MIN(len, 8)) withString:@"***"];
        
        return str;
    }
    
    return @"";
}

- (NSString *)yu_stringToCodeStyle{
    
    if ([self yu_isCanBeUse]) {
        NSMutableString *chars = [NSMutableString new];
        
        for (int i = 0; i < [self length]; i++) {
            
            if (i %4 == 0 && (i>1 && i<[self length])) {
                [chars appendString:@"  "];
            }else{
                [chars appendString:@""];
            }
            
            NSString * c = [self substringWithRange:NSMakeRange(i,1)];
            [chars appendString:c];
        }
        return chars;
    }
    return @"";
}


- (NSString *)yu_stringToCommaStyle{
    
    NSString *string = [NSString stringWithFormat:@"%.2f",[self doubleValue]];
    
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

- (NSString *)yu_URLEncodedParameterString {
    
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                             (CFStringRef)self,
                                                                                             NULL,
                                                                                             CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                             kCFStringEncodingUTF8));
    return result;
}


- (NSString *)yu_URLDecodedString {
    return ( NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                  ( CFStringRef)self,
                                                                                                  CFSTR(""),
                                                                                                  kCFStringEncodingUTF8));
}


- (NSDictionary*)yu_queryDictionaryUsingEncoding{
    
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
                            stringByRemovingPercentEncoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByRemovingPercentEncoding];
            [pairs setObject:value forKey:key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}


- (NSString*)yu_stringByAddingQueryDictionary:(NSDictionary*)query {
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


- (NSString *)yu_md5String{
    if(self == nil || [self length] == 0)
        return nil;
   return [[self dataUsingEncoding:NSUTF8StringEncoding] yu_MD5Sum];
}


- (NSString *)yu_SHA1Sum {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data yu_SHA1Sum];
}


- (NSString *)yu_SHA256Sum {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    return [data yu_SHA256Sum];
}


-(NSString *)yu_md5FileString{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    NSData * data = [NSData dataWithContentsOfFile:self];
    return [data yu_MD5Sum];
}


-(NSString*)yu_AES128EncryToBase64String:(NSString *)password
{
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    data = [data yu_AES128Operation:kCCEncrypt key:password];
    return [data yu_base64EncodedString];
}


-(NSString*)yu_AES128DecryptWithKey:(NSString*)password
{
    NSData *data = [self yu_base64DecodedData];
    data = [data yu_AES128Operation:kCCDecrypt key:password];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

-(NSString*)yu_DESEncryToBase64String:(NSString *)password
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    data = [data yu_DESEncryptWithKey:password];
    return [data yu_base64EncodedString];
}


-(NSString*)yu_DESDecryptWithKey:(NSString*)password
{
    NSData *data = [self yu_base64DecodedData];
    data = [data yu_DESDecryptWithKey:password];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end

