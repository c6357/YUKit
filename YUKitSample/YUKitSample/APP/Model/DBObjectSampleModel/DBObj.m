//
//  DBObj.m
//  YUDBObject
//
//  Created by BruceYu on 15/8/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "DBObj.h"

@implementation DBObj

/**
 *  数据库名
 *
 *  @return <#return value description#>
 */
+(NSString *)dbName{
    return @"Base.db";
}

/**
 *  数据库路径
 *
 *  @return <#return value description#>
 */
+(NSString *)dbFolder{
    return [NSObject createFileDirectories:@"base"];
}


/**
 *  需要过滤的数据库字段
 *
 *  @return <#return value description#>
 */
+(NSArray *)dbIgnoreFields{
    return @[];
}

/**
 *  Deserialize json -> Class
 *
 *  @param _dict <#_dict description#>
 */
-(void)Deserialize:(NSDictionary *)_dict
{
    [super Deserialize:_dict arrayParserObj:^Class(NSString *field) {
        if ([field isEqualToString:@"infoArry"]) {
            return [UserInfo class];
        }
        return nil;
    }];
}

@end
