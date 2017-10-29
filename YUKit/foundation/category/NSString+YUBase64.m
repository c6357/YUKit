//
//  NSString+YUBase64.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSString+YUBase64.h"
#import "NSData+YUBase64.h"

@implementation NSString (YUBase64)
+ (NSString *)yu_stringWithBase64EncodedString:(NSString *)string
{
    NSData *data = [NSData yu_dataWithBase64EncodedString:string];
    if (data)
    {
        return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)yu_base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data yu_base64EncodedStringWithWrapWidth:wrapWidth];
}

- (NSString *)yu_base64EncodedString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    return [data yu_base64EncodedString];
}

- (NSString *)yu_base64DecodedString
{
    return [NSString yu_stringWithBase64EncodedString:self];
}

- (NSData *)yu_base64DecodedData
{
    return [NSData yu_dataWithBase64EncodedString:self];
}

@end
