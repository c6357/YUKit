//
//  NSDictionary+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YU)

- (NSDictionary *)dictionaryByReplacingNullsWithStrings;

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;

@end
