//
//  NSDictionary+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSDictionary+YU.h"

@implementation NSDictionary (YU)

- (BOOL)isEmpty {
    return [self count] == 0 ? YES : NO;
}

//- (NSString *)descriptionWithLocale:(id)locale
//{
//    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
//    
//    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
//    }];
//    
//    [strM appendString:@"}\n"];
//    
//    return strM;
//}

-(NSDictionary*)copyToSelf:(NSDictionary*)dic{
    NSMutableDictionary *returnDic = [NSMutableDictionary new];
    for (NSString *key in dic.allKeys) {
        if ([self.allKeys containsObject:key]) {
            [returnDic setObject:dic[key] forKey:key];
        };
    }
    return returnDic;
}

- (NSDictionary *)dictionaryByReplacingNullsWithStrings {
    
    const NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary: self];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self) {
        const id object = [self objectForKey: key];
        if (object == nul) {
            [replaced setObject: blank forKey: key];
        }
        else if ([object isEqualToString:@"<null>"])
             [replaced setObject: blank forKey: key];
        
        else if ([object isEqualToString:@"(null)"])
            [replaced setObject: blank forKey: key];
        
        else if ([object isKindOfClass: [NSDictionary class]]) {
            [replaced setObject: [(NSDictionary *) object dictionaryByReplacingNullsWithStrings] forKey: key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:(NSDictionary*)replaced];
}

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForKey:key] == [NSNull null] ? defaultValue
    : [[self objectForKey:key] boolValue];
}

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    return [self objectForKey:key] == [NSNull null]
				? defaultValue : [[self objectForKey:key] intValue];
}

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] longLongValue];
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
				? defaultValue : [self objectForKey:key];
}

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue {
    NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }
    struct tm created;
    time_t now;
    time(&now);
    if (stringTime) {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        return mktime(&created);
    }
    return defaultValue;
}


@end
