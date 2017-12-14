//
//  NSDictionary+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YU)

/*
 * Checks to see if the dictionary is empty
 */
@property(nonatomic,readonly,getter=yu_isEmpty) BOOL empty;




-(NSDictionary*)yu_copyToSelf:(NSDictionary*)dic;

- (NSDictionary *)yu_dictionaryByReplacingNullsWithStrings;

- (BOOL)yu_getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

- (int)yu_getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;

- (long long)yu_getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;

- (NSString *)yu_getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

- (time_t)yu_getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;


-(NSDictionary*)yu_valueToString;

@end
