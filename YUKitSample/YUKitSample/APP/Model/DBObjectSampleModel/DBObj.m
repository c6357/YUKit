//
//  DBObj.m
//  https://github.com/c6357/YUDBModel
//
//  Created by BruceYu on 15/8/18.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//


#import "DBObj.h"

@implementation DBObj

/**
 *  需要过滤的数据库字段
 *
 *  @return bool
 */
+(NSArray *)YUDBModel_IgnoreFields{
    //数据库不会存储的字段
//    return @[];
    return @[@"point",@"user",@"method",@"ivar",@"category",@"property",@"classz"];
}

///设置主键
//+(NSString*)YUDBModel_PrimaryKey{
//    return @"myPrimaryKey";
//}


///json key字段替换
+(NSDictionary *)YUDBModel_ReplacePropertyKey{
    return @{
             @"objId":@"id",
             };
}


-(void)deserialize:(NSDictionary *)dictionary
{
    [super deserialize:dictionary arrayParser:^id(NSString *key,id value) {

        if ([key isEqualToString:@"dict"]) {
//            return @"自定义dict";
//            return @{@"hello":@"world"};
        }
        
        if ([key isEqualToString:@"list"]) {
//            return @"自定义list对象";
            return [UserInfoLevel6 class];
        }
        
        else if ([key isEqualToString:@"array"]) {
//            return @"自定义array";
            return @[@"1",@"2",@"3"];
        }
        
        else if ([key isEqualToString:@"name"]) {
//            return @[@"name"];
//            return @"自定义name";
        }
        
        return nil;
    }];
}

@end
