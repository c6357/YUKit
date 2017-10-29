//
//  UserDefaults.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "YU_UserDefaults.h"

@implementation YUUserDefaults

+ (void)yu_setObject:(nullable id)value forKey:(NSString *)defaultName{
    
    [[YUUserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[YUUserDefaults standardUserDefaults]  synchronize];
}

+ (nullable id)yu_objectForKey:(NSString *)defaultName{
    
    return [[YUUserDefaults standardUserDefaults] objectForKey:defaultName];
}

@end
