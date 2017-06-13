//
//  NSMethodSignature+YUException.m
//  YUKit<https://github.com/c6357/YUException>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//


#import "NSMethodSignature+YUException.h"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "NSException+YUException.h"

@implementation NSMethodSignature (YU)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
#if YUExceptionProduction
        [self install];
#endif
        }
    });
}

+(void)install{
    
    [self hookMethedClass:[NSObject class] hookSEL:@selector(methodSignatureForSelector:) originalSEL:@selector(methodSignatureForSelectorOriginal:) myselfSEL:@selector(methodSignatureForSelectorMySelf:)];
    
    [self hookMethedClass:[NSObject class] hookSEL:@selector(forwardInvocation:) originalSEL:@selector(forwardInvocationOriginal:) myselfSEL:@selector(forwardInvocationMySelf:)];
    
}

- (NSMethodSignature *)methodSignatureForSelectorMySelf:(SEL)aSelector {
    
    NSString *sel = NSStringFromSelector(aSelector);
    if ([sel rangeOfString:@"set"].location == 0) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else {
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
}

- (NSMethodSignature *)methodSignatureForSelectorOriginal:(SEL)aSelector {
    return nil;
}


- (void)forwardInvocationOriginal:(NSInvocation *)anInvocation {
    
}


- (void)forwardInvocationMySelf:(NSInvocation *)anInvocation{
    
#if 0
    Class cls = [anInvocation.target class];
    class_addMethod(cls, anInvocation.selector, (IMP)yucrashFunction, "v@:@@");
    if ([anInvocation.target respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:anInvocation.target];
    }

    NSLog(@"[%@ %@ %@]:unrecognized selector",self,cls,NSStringFromSelector(anInvocation.selector));
    NSLog(@"%@",[NSThread callStackSymbols]);
#endif
    

    Class cls = [anInvocation.target class];
    
    if ([cls respondsToSelector:[anInvocation selector]]) {
        
        [anInvocation invokeWithTarget:anInvocation.target];
        
    }else{
        
        @try {
            [cls forwardInvocation:anInvocation];
        } @catch (NSException *exception) {
        
//            NSLog(@"[%@ %@ %@]:unrecognized selector",self,cls,NSStringFromSelector(anInvocation.selector));
            [exception exception:nil];
            
        } @finally {
            
        }
    }
}


#pragma mark - private
void crashFunction(id self, SEL _cmd, ...) {
    
    id value = nil;
    
    NSString *selString = NSStringFromSelector(_cmd);
    
    int cnt = 0, length = (int)selString.length;
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [selString rangeOfString: @":" options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            cnt++;
        }
    }
    
    va_list arg_ptr;
    va_start(arg_ptr, _cmd);
    
    for(int i = 0; i < cnt; i++)
    {
        value = va_arg(arg_ptr, id);
        NSLog(@"value%d=%@", i+1, value);
    }
    va_end(arg_ptr);
    
}

+ (void)hookMethedClass:(Class)class hookSEL:(SEL)hookSEL originalSEL:(SEL)originalSEL myselfSEL:(SEL)mySelfSEL
{
    Method hookMethod = class_getInstanceMethod(class, hookSEL);
    Method mySelfMethod = class_getInstanceMethod(self, mySelfSEL);
    
    IMP hookMethodIMP = method_getImplementation(hookMethod);
    
    class_addMethod(class, originalSEL, hookMethodIMP, method_getTypeEncoding(hookMethod));
    
    IMP hookMethodMySelfIMP = method_getImplementation(mySelfMethod);
    
    class_replaceMethod(class, hookSEL, hookMethodMySelfIMP, method_getTypeEncoding(hookMethod));
}

@end
