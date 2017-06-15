//
//  NSError+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSError+YU.h"

#define YU_ERROR_DOMAIN @"YU DOMAIN"
#define NOT_DEFINED -1

@implementation NSError (YU)

+ (NSError *)errorWithMsg:(NSString *)msg
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg?:@"发生错误!", NSLocalizedDescriptionKey, nil];
    return [NSError errorWithDomain:YU_ERROR_DOMAIN code:-1000 userInfo:userInfo];
}

+ (NSError*) errorWithMsg:(NSString*)msg obj:(id)obj
{
    NSMutableDictionary *userinfo = [NSMutableDictionary dictionaryWithObject:msg?:@"发生错误!" forKey:NSLocalizedDescriptionKey];
    
    if (obj) {
        userinfo[NSUnderlyingErrorKey] = obj;
    }
    return [NSError errorWithDomain:YU_ERROR_DOMAIN code:NOT_DEFINED userInfo:userinfo];
}


+ (NSError *)errorWithCode:(int)code
{
    NSString *msg ;

    msg = @"发生错误!";

    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg , NSLocalizedDescriptionKey, nil];
    return [NSError errorWithDomain:YU_ERROR_DOMAIN code:code userInfo:userInfo];
}



+ (NSError*) errorWithCode:(NSString*)code msg:(NSString*)msg
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:msg?:@"发生错误!", NSLocalizedDescriptionKey, nil];
    return [NSError errorWithDomain:YU_ERROR_DOMAIN code:[code integerValue] userInfo:userInfo];
}



+ (NSError*) errorWithCode:(NSString*)code msg:(NSString*)msg obj:(id)obj
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:msg?:@"发生错误!", NSLocalizedDescriptionKey, nil];
    if (obj) {
        userInfo[NSUnderlyingErrorKey] = obj;
    }
    return [NSError errorWithDomain:YU_ERROR_DOMAIN code:code ? [code integerValue] : NOT_DEFINED userInfo:userInfo];
}





@end
