//
//  UserInfo.m
//  YUDBObject
//
//  Created by BruceYu on 15/8/12.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "UserInfo.h"


@implementation UserInfo

/**
 *  数据库名
 *
 *  @return <#return value description#>
 */
+(NSString *)dbName{
    return @"User.db";
}

/**
 *  数据库路径
 *
 *  @return <#return value description#>
 */
+(NSString *)dbFolder{
    return [NSObject createFileDirectories:@"user"];
}

/**
 *  需要过滤的数据库字段
 *
 *  @return <#return value description#>
 */
+(NSArray *)dbIgnoreFields{
    return @[];
}
@end
