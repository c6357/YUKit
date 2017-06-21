//
//  UserDefaults.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/7.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "YU_UserDefaults.h"

@implementation UserDefaults

+ (void)setObject:(nullable id)value forKey:(NSString *)defaultName{
    
    [[UserDefaults standardUserDefaults] setObject:value forKey:defaultName];
    [[UserDefaults standardUserDefaults]  synchronize];
}

+ (nullable id)objectForKey:(NSString *)defaultName{
    
    return [[UserDefaults standardUserDefaults] objectForKey:defaultName];
}

@end
