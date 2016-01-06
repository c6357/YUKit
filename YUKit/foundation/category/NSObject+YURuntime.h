//
//  NSObject+YURuntime.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/28.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YUKit.h"

typedef void (^runtime_Block_KeyForArray)(NSString *key,BOOL *stop);
typedef void (^runtime_Block_KeyValueForArray)(NSString *key,NSString *value,BOOL *stop);

@interface NSObject (YURuntime)

//混合
- (void)swizzleSelectorWithClass:(Class)clazz originalSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;


//查看调用栈
+ (NSArray *)callstack:(NSUInteger)depth;


//成员变量
+ (NSArray *)allIvar;


//协议
+ (NSArray *)allProtocol;
+ (NSArray *)classesWithProtocol:(NSString *)protocolName;


//all subClass
+ (NSArray *)allSubClasses;
//all methods
+ (NSArray *)allMethods;


//all properties
+ (NSArray *)allProperties;
+ (NSArray *)allProperties:(Class)baseClass;
+ (NSArray *)allProperties:(Class)baseClass prefix:(NSString *)prefix;
+ (NSArray *)allProperties_each:(runtime_Block_KeyForArray)enumeration;
+ (NSArray *)allProperties_each:(Class)baseClass
                   enumeration:(runtime_Block_KeyForArray)enumeration;

- (NSArray *)allProperties_each:(runtime_Block_KeyValueForArray)enumeration;
- (NSArray *)allProperties_each:(Class)baseClass
                    enumeration:(runtime_Block_KeyValueForArray)enumeration;


- (void)addProperty:(NSString *)propertyName withValue:(id)value;
- (id  )getPropertyValue:(NSString *)propertyName;

@end

