//
//  NSArray+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSArray+YU.h"
#import "YUKit.h"

@implementation NSArray (YU)

BOOL isSafeArray(NSArray *arry){
    return  ((arry)&&(![(arry) isEqual:[NSNull null]]) &&((arry).count>0));
}


- (BOOL)isEmpty {
    return [self count] == 0 ? YES : NO;
}

-(NSMutableArray*)arrayWithKey:(NSString*)key
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [array addObject:[obj performSelector:NSSelectorFromString(key)]];
#pragma clang diagnostic pop
    }];
    return array;
}


-(NSMutableDictionary*)dictionaryWithKey:(NSString*)key
{
    if (!isSafeArray(self)) {
        return nil;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (id obj in self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        dict[ [obj performSelector:NSSelectorFromString(key)]] = obj;
#pragma clang diagnostic pop
        
    }
    return dict;
}


-(NSMutableDictionary*)dictionaryWithIntKey:(NSString*)key
{
    if (!isSafeArray(self)) {
        return nil;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (id obj in self) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        dict[[NSString stringWithFormat:@"%d",(int)[obj performSelector:NSSelectorFromString(key)]]] = obj;
#pragma clang diagnostic pop
        
    }
    return dict;
}


+(id)arrayWithCArray:(char**)strs len:(NSInteger)length
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:length];
    for (int  k = 0; k < length; k++) {
        [array addObject:[NSString stringWithUTF8String:strs[k]]];
    }
    return array;
}


@end

@implementation NSMutableArray (YU)

- (id)firstObject {
    if ([self count] == 0)
        return nil;
    return [self objectAtIndex:0];
}


- (NSMutableArray *) removeFirstObject
{
    if (self.count) {
       [self removeObjectAtIndex:0];
    }
    return self;
}

- (NSMutableArray*)addObject:(id)object,...{
    if (!object) return self;
    id obj = object;
    va_list objects;
    va_start(objects, object);
    do
    {
        [self addObject:obj];
        obj = va_arg(objects, id);
    } while (obj);
    va_end(objects);
    return self;
}
@end
