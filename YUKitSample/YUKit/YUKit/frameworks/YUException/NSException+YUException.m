//
//  NSException+YUException.m
//  YUException<https://github.com/c6357/YUException>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSException+YUException.h"
#import <objc/runtime.h>
#import "NSDictionary+YUException.h"
#import "NSString+YUException.h"
#import "NSObject+YUException.h"
#import "NSArray+YUException.h"
#import "NSObject+YUMethodSignature.h"
#import "NSObject+YULog.h"
#import "UncaughtExceptionHandler.h"

@implementation NSException (YUException)

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

    [UncaughtExceptionHandler install];
}



+(void)unknownException:(void(^)(NSException *unknownException, BOOL*dismissed))unknownException{
    
    [UncaughtExceptionHandler unknownException:unknownException];
}
@end




@implementation NSException (exception)

-(void)exception:(void(^)(id obj))obj{
    
    NSString *errorName = self.name;
    NSString *errorReason = self.reason;
    NSArray *callStackSymbols = [NSThread callStackSymbols];
    
    NSDictionary *dic = @{@"name":errorName,@"reason":errorReason,@"StackSymbols":callStackSymbols};
    
    YULogWarn(@"%@",dic);
    
#if DEBUG
//    @throw self;
#endif
    
    if (obj) {
        obj(dic);
    }
}
@end

@implementation NSObject (runtime)

+ (void)swizzleSelectorWithClass:(Class)clazz originalSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    
    Class class = clazz;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethodInit = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethodInit) {
        
        class_addMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
