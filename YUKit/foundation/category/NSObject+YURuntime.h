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
- (void)yu_swizzleSelectorWithClass:(Class)clazz originalSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector;


//查看调用栈
+ (NSArray *)yu_callstack:(NSUInteger)depth;


//成员变量
+ (NSArray *)yu_allIvar;


//协议
+ (NSArray *)yu_allProtocol;
+ (NSArray *)yu_classesWithProtocol:(NSString *)protocolName;


//all subClass
+ (NSArray *)yu_allSubClasses;
//all methods
+ (NSArray *)yu_allMethods;


//all properties
+ (NSArray *)yu_allProperties;
+ (NSArray *)yu_allProperties:(Class)baseClass;
+ (NSArray *)yu_allProperties:(Class)baseClass prefix:(NSString *)prefix;
+ (NSArray *)yu_allProperties_each:(runtime_Block_KeyForArray)enumeration;
+ (NSArray *)yu_allProperties_each:(Class)baseClass
                   enumeration:(runtime_Block_KeyForArray)enumeration;

- (NSArray *)yu_allProperties_each:(runtime_Block_KeyValueForArray)enumeration;
- (NSArray *)yu_allProperties_each:(Class)baseClass
                    enumeration:(runtime_Block_KeyValueForArray)enumeration;


- (void)yu_addProperty:(NSString *)propertyName withValue:(id)value;
- (id  )yu_getPropertyValue:(NSString *)propertyName;

@end

