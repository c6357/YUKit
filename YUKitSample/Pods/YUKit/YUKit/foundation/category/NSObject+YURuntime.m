//
//  NSObject+YURuntime.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/12/28.
//  Copyright © 2015年 BruceYu. All rights reserved.
//

#import "NSObject+YURuntime.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <execinfo.h>
#import "NSObject+YU.h"
#import "YU_Runtime.h"

#undef	MAX_CALLSTACK_DEPTH
#define MAX_CALLSTACK_DEPTH	(64)
#define dbIgnoreFields @[@"hash",@"superclass",@"description",@"debugDescription"]
NSString * const dictCustomerPropertyStr =  @"dictCustomerProperty";
static char dictCustomerPropertyKey;


@implementation NSObject (YURuntime)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setAssociatedObject:[NSMutableDictionary new] forKey:&dictCustomerPropertyKey policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
    });
}


- (void)swizzleSelectorWithClass:(Class)clazz originalSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    [YURuntime swizzleSelectorWithClass:clazz originalSelector:originalSelector withSelector:swizzledSelector];
}

+ (NSArray *)callstack:(NSUInteger)depth
{
    NSMutableArray * array = [NSMutableArray new];
    
    void * stacks[MAX_CALLSTACK_DEPTH] = { 0 };
    depth = backtrace( stacks, (int)((depth > MAX_CALLSTACK_DEPTH) ? MAX_CALLSTACK_DEPTH : depth) );
    if ( depth )
    {
        char ** symbols = backtrace_symbols( stacks, (int)depth );
        if ( symbols )
        {
            for ( int i = 0; i < depth; ++i )
            {
                NSString * symbol = [NSString stringWithUTF8String:(const char *)symbols[i]];
                if ( 0 == [symbol length] )
                    continue;
                
                NSRange range1 = [symbol rangeOfString:@"["];
                NSRange range2 = [symbol rangeOfString:@"]"];
                
                if ( range1.length > 0 && range2.length > 0 )
                {
                    NSRange range3;
                    range3.location = range1.location;
                    range3.length = range2.location + range2.length - range1.location;
                    [array addObject:[symbol substringWithRange:range3]];
                }
                else
                {
                    [array addObject:symbol];
                }
            }
            
            free( symbols );
        }
    }
    
    return array;
}

+ (NSArray *)allIvar{
    
    Class class = self;
    unsigned int count;
    NSMutableArray *result = [NSMutableArray new];
    
    while ( class != Nil/*[NSObject class]*/)
    {
        NSMutableArray *arry = [NSMutableArray new];
        Ivar *ivarList = class_copyIvarList(class, &count);
        for (unsigned int i = 0; i<count; i++) {
            
            Ivar myivar = ivarList[i];
            const char *ivarname = ivar_getName(myivar);
            
            if ( NULL == ivarname )
                continue;
            
            NSString * ivarStr = [NSString stringWithUTF8String:ivarname];
            if ( nil == ivarStr )
                continue;
            
            [arry addObject:ivarStr];
        }
        [result addObject:@{NSStringFromClass(class?:[self class]):arry}];
        class = [class superclass];
    }
    return result;
}

+ (NSArray *)allProtocol{
    
    Class class = self;
    unsigned int count;
    NSMutableArray *result = [NSMutableArray new];
    
    while ( class != Nil/*[NSObject class]*/)
    {
         NSMutableArray *arry = [NSMutableArray new];
        __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
        for (unsigned int i = 0; i<count; i++) {
            
            Protocol *myprotocal = protocolList[i];
            const char *protocolname = protocol_getName(myprotocal);
            
            if ( NULL == protocolname )
                continue;
            
            NSString * protcocolStr = [NSString stringWithUTF8String:protocolname];
            if ( nil == protcocolStr )
                continue;
            
            [arry addObject:protcocolStr];
        }
        
        [result addObject:@{NSStringFromClass(class):arry}];
        class = [class superclass];
    }
    return result;
}

+ (NSArray *)classesWithProtocol:(NSString *)protocolName
{
    NSMutableArray *results = [NSMutableArray new];
    
    Protocol * protocol = NSProtocolFromString(protocolName);
    for ( NSString *className in [self allClassNames] )
    {
        Class classType = NSClassFromString( className );
        if ( classType == self )
            continue;
        
        if ( NO == [classType conformsToProtocol:protocol] )
            continue;
        
        [results addObject:[classType description]];
    }
    return results;
}

+ (NSArray *)allSubClasses
{
    NSMutableArray *results = [NSMutableArray new];
    
    for ( NSString *className in [self allClassNames] )
    {
        Class class = NSClassFromString( className );
        
        if ( class == self )
            continue;
        
        if ( NO == [class isSubclassOfClass:self] )
            continue;
        
        [results addObject:[class description]];
    }
    return results;
}


+ (NSArray *)allMethods
{
    static NSMutableArray * methodNames = nil;
    
    if ( nil == methodNames )
    {
        methodNames = [NSMutableArray new];
        
        Class thisClass = self;
        
        while ( thisClass != Nil/*[NSObject class]*/)
        {
            unsigned int methodCount = 0;
            Method *methods = class_copyMethodList( thisClass, &methodCount );
            
            for ( unsigned int i = 0; i < methodCount; ++i )
            {
                SEL selector = method_getName( methods[i] );
                if ( selector )
                {
                    const char * cstrName = sel_getName(selector);
                    if ( NULL == cstrName )
                        continue;
                    
                    NSString * selectorName = [NSString stringWithUTF8String:cstrName];
                    if ( nil == selectorName )
                        continue;
                    
                    [methodNames addObject:selectorName];
                }
            }
            
            thisClass = class_getSuperclass( thisClass );
        }
    }
    return methodNames;
}

+ (NSArray *)allProperties{
    return [self allProperties:[NSObject superclass]];
}

+ (NSArray *)allProperties:(Class)baseClass
{
    return [self allProperties_each:baseClass enumeration:nil];
}

+ (NSArray *)allProperties:(Class)baseClass prefix:(NSString *)prefix
{
    NSArray * properties = [self allProperties_each:baseClass enumeration:nil];

    if ( nil == properties || 0 == properties.count)
    {
        return nil;
    }
    
    if ( nil == prefix )
    {
        return properties;
    }
    
    NSMutableArray * result = [NSMutableArray new];
    
    for ( NSString * propName in properties )
    {
        if ( NO == [propName hasPrefix:prefix] )
        {
            continue;
        }
        
        [result addObject:propName];
    }
    
    [result sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
    
    return result;
}

+ (NSArray *)allProperties_each:(runtime_Block_KeyForArray)enumeration{
    return [self allProperties_each:[NSObject superclass] enumeration:enumeration];
 
}

+ (NSArray *)allProperties_each:(Class)baseClass
enumeration:(runtime_Block_KeyForArray)enumeration{
    
    baseClass = baseClass ?: [NSObject class];
    Class class = [self class];
    
    NSMutableArray * propertyNames = [NSMutableArray new];
    unsigned int count;
    BOOL stop = NO;
    
    while ( class != baseClass)
    {
        objc_property_t *t = class_copyPropertyList(class, &count);
        
        for (int k = 0; k < count; k++) {
            
            const char * cstrName = property_getName( t[k] );
            if ( NULL == cstrName )
                continue;
            
            NSString *propName = [NSString stringWithUTF8String:cstrName];
            if ( nil == propName )
                continue;

            if (![dbIgnoreFields containsObject:propName])
            {
                [propertyNames addObject:propName];
                
                if (enumeration) {
                    enumeration(propName,&stop);
                }
                
                if (stop) break;
            }
        }
        class = [class superclass];
    }
    
    return propertyNames;
}

- (NSArray *)allProperties_each:(runtime_Block_KeyValueForArray)enumeration{
    
    return [self allProperties_each:[self superclass] enumeration:enumeration];
    
}

- (NSArray *)allProperties_each:(Class)baseClass
                    enumeration:(runtime_Block_KeyValueForArray)enumeration{
    
    return [[self class] allProperties_each:baseClass
                            enumeration:^(NSString *key, BOOL *stop1) {
                                BOOL stop = NO;
                                id value = nil;
//                                if ( class_isMetaClass([self class]) )
                                {
                                    Ivar ivar = class_getInstanceVariable([self class], [[NSString stringWithFormat:@"_%@",key] UTF8String]);
                                    if (ivar) {
                                        value = object_getIvar(self , ivar);
                                    }
                                    if (enumeration) {
                                        enumeration(key,value,&stop);
                                    }
                                    if (stop) *stop1 = YES;
                                }
                            }];
}





+ (void)addProperty:(NSString *)propertyName withValue:(id)value {
    Class class = [self class];

    Ivar ivar = class_getInstanceVariable(class, [[NSString stringWithFormat:@"_%@", propertyName] UTF8String]);
    if (ivar) {
        return;
    }
    objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([value class])] UTF8String] };
    objc_property_attribute_t ownership = { "&", "N" };
    objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", propertyName] UTF8String] };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    
    if (class_addProperty(class, [propertyName UTF8String], attrs, 3)) {
        
    } else {
        class_replaceProperty(class, [propertyName UTF8String], attrs, 3);
    }
}

- (void)addProperty:(NSString *)propertyName withValue:(id)value {

    Class class = [self class];
//    Ivar ivar = class_getInstanceVariable(class, [[NSString stringWithFormat:@"_%@", dictCustomerPropertyStr] UTF8String]);
//    if (!ivar) {
//        [[self class] addProperty:dictCustomerPropertyStr withValue:[NSMutableDictionary new]];
//        
//            class_addIvar([self class], [[NSString stringWithFormat:@"_%@", dictCustomerPropertyStr] UTF8String], sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
//    }
//    
    Ivar ivar = class_getInstanceVariable(class, [[NSString stringWithFormat:@"_%@", propertyName] UTF8String]);
    if (ivar) {
        return;
    }
    objc_property_attribute_t type = { "T", [[NSString stringWithFormat:@"@\"%@\"",NSStringFromClass([value class])] UTF8String] };
    objc_property_attribute_t ownership = { "&", "N" };
    objc_property_attribute_t backingivar  = { "V", [[NSString stringWithFormat:@"_%@", propertyName] UTF8String] };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    
    
    if (class_addProperty(class, [propertyName UTF8String], attrs, 3)) {
        
        class_addMethod(class, NSSelectorFromString(propertyName), (IMP)getter, "@@:");
        class_addMethod(class, NSSelectorFromString([NSString stringWithFormat:@"set%@:",[propertyName capitalizedString]]), (IMP)setter, "v@:@");
        [self setValue:value forKey:propertyName];
        
    } else {
        class_replaceProperty(class, [propertyName UTF8String], attrs, 3);
        class_addMethod(class, NSSelectorFromString(propertyName), (IMP)getter, "@@:");
        class_addMethod(class, NSSelectorFromString([NSString stringWithFormat:@"set%@:",[propertyName capitalizedString]]), (IMP)setter, "v@:@");
        [self setValue:value forKey:propertyName];
    }
}

- (id)getPropertyValue:(NSString *)propertyName {
    
    Class class = [self class];
    
    //先判断有没有这个属性，没有就添加，有就直接赋值
    Ivar ivar = class_getInstanceVariable(class, [[NSString stringWithFormat:@"_%@", propertyName] UTF8String]);
    if (ivar) {
        return object_getIvar(self, ivar);
    }
    
#ifdef private_dictCustomerProperty
    ivar = class_getInstanceVariable(class, [[NSString stringWithFormat:@"_%@",dictCustomerPropertyStr] UTF8String]);
    NSMutableDictionary *dict = object_getIvar(self, ivar);
#else
    NSMutableDictionary *dict = [self getAssociatedObjectForKey:&dictCustomerPropertyKey];
#endif
    if (dict && [dict objectForKey:propertyName])
    {
        return [dict objectForKey:propertyName];
    } else {
        return nil;
    }
}

#pragma mark - private
id getter(id self1, SEL _cmd1)
{
    //    Ivar ivar = class_getInstanceVariable([self1 class], "_privateName");
    //    return object_getIvar(self1, ivar);
    NSString *key = NSStringFromSelector(_cmd1);
#ifdef private_dictCustomerProperty
    Ivar ivar = class_getInstanceVariable([self1 class], [[NSString stringWithFormat:@"_%@",dictCustomerPropertyStr] UTF8String]);
    NSMutableDictionary *dictCustomerProperty = object_getIvar(self1, ivar);
    return [dictCustomerProperty objectForKey:key];
#else
    NSMutableDictionary *dictCustomerProperty  = [self1 getAssociatedObjectForKey:&dictCustomerPropertyKey];
    return [dictCustomerProperty objectForKey:key];
#endif
}

void setter(id self1, SEL _cmd1, id newValue)
{
    //    Ivar ivar = class_getInstanceVariable([self1 class], "_privateName");
    //    id oldName = object_getIvar(self1, ivar);
    //    if (oldName != newValue) object_setIvar(self1, ivar, [newValue copy]);
    //移除set
    NSString *key = [NSStringFromSelector(_cmd1) stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];
    //首字母小写
    NSString *head = [key substringWithRange:NSMakeRange(0, 1)];
    head = [head lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:head];
    //移除后缀 ":"
    key = [key stringByReplacingCharactersInRange:NSMakeRange(key.length - 1, 1) withString:@""];
    
#ifdef private_dictCustomerProperty
    Ivar ivar = class_getInstanceVariable([self1 class], [[NSString stringWithFormat:@"_%@",dictCustomerPropertyStr] UTF8String]);
    NSMutableDictionary *dictCustomerProperty = object_getIvar(self1, ivar);
    if (!dictCustomerProperty) {
        dictCustomerProperty = [NSMutableDictionary dictionary];
        object_setIvar(self1, ivar, dictCustomerProperty);
    }
#else
    NSMutableDictionary *dictCustomerProperty  = [self1 getAssociatedObjectForKey:&dictCustomerPropertyKey];
    if (!dictCustomerProperty) {
        dictCustomerProperty = [NSMutableDictionary dictionary];
    }
#endif
    
    [dictCustomerProperty setObject:newValue forKey:key];
    [self1 setAssociatedObject:dictCustomerProperty forKey:&dictCustomerPropertyKey policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

+ (NSArray *)allClassNames
{
    static NSMutableArray *classNames = nil;
    
    if (nil == classNames) {
        unsigned int classesCount = 0;
          
        classNames     = [NSMutableArray new];
        Class *classes = objc_copyClassList( &classesCount );

        for ( unsigned int i = 0; i < classesCount; ++i )
        {
            Class classType = classes[i];
            Class superClass = class_getSuperclass( classType );

            if ( Nil == superClass )
              continue;

            if ( NO == class_respondsToSelector( classType, @selector(doesNotRecognizeSelector:) ) )
                continue;

            [classNames addObject:[NSString stringWithUTF8String:class_getName(classType)]];
        }

        [classNames sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
          return [obj1 compare:obj2];
        }];
        free( classes );
    }
    
    return classNames;
}
@end
