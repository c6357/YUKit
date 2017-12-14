//
//  NSDictionary+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSDictionary+YU.h"
#import "NSNumber+YU.h"

@implementation NSDictionary (YU)

- (BOOL)yu_isEmpty {
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

-(NSDictionary*)yu_copyToSelf:(NSDictionary*)dic{
    NSMutableDictionary *returnDic = [NSMutableDictionary new];
    for (NSString *key in dic.allKeys) {
        if ([self.allKeys containsObject:key]) {
            [returnDic setObject:dic[key] forKey:key];
        };
    }
    return returnDic;
}

- (NSDictionary *)yu_dictionaryByReplacingNullsWithStrings {
    
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
            [replaced setObject: [(NSDictionary *) object yu_dictionaryByReplacingNullsWithStrings] forKey: key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:(NSDictionary*)replaced];
}

- (BOOL)yu_getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForKey:key] == [NSNull null] ? defaultValue
    : [[self objectForKey:key] boolValue];
}

- (int)yu_getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    return [self objectForKey:key] == [NSNull null]
				? defaultValue : [[self objectForKey:key] intValue];
}

- (long long)yu_getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] longLongValue];
}

- (NSString *)yu_getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
				? defaultValue : [self objectForKey:key];
}

- (time_t)yu_getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue {
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

-(NSDictionary*)yu_valueToString{
    if (!self) {
        return [NSDictionary new];
    }
    return [self yu_valueToString:nil];
}

-(NSMutableDictionary*)yu_valueToString:(NSMutableDictionary *)dictSource{
    
    NSMutableDictionary *newDic = dictSource;
    
    if (nil == dictSource) {
        newDic = [NSMutableDictionary new];
    }
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [self yu_setValue:obj forKey:key dictSource:newDic];
        
    }];
    
    return newDic;
}

-(NSMutableDictionary *)yu_setValue:(id)obj forKey:(NSString*)key dictSource:(NSMutableDictionary *)dictSource{
    
    if ([obj isKindOfClass:[NSString class]]) {
        [dictSource setObject:obj forKey:key];
    }
    
    else if ([obj isKindOfClass:[NSArray class]]) {
        NSMutableArray *arry = [NSMutableArray new];
        for (id subObj in obj) {
            NSMutableDictionary *newDict = [NSMutableDictionary new];
            NSDictionary* subDic = [newDict yu_setValue:subObj forKey:key dictSource:newDict];
            //            NSLog(@"subDic %@",subDic);
            [arry addObject:subDic];
        }
        [dictSource setObject:arry forKey:key];
    }
    
    else if ([obj isKindOfClass:[NSDictionary class]]) {
        [obj yu_valueToString:dictSource];
    }
    
    else if ([obj isKindOfClass:[NSNumber class]]) {
        [dictSource setObject:[obj yu_toString] forKey:key];
    }
    
    else{
        [dictSource setObject:@"" forKey:key];
    }
    
    return dictSource;
}
@end
