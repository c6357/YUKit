//
//  NSString+YUException.m
//  YUException<https://github.com/c6357/YUException>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSString+YUException.h"
#import <objc/runtime.h>
#import "NSException+YUException.h"

@implementation NSString (YUException)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
#if YUExceptionProduction
            [self catchExceptions];
#endif
        }
    });
}

+(void)catchExceptions{
    
    [self swizzleSelectorWithClass:objc_getClass("__NSCFString") originalSelector:@selector(insertString:atIndex:) withSelector:@selector(yuinsertString:atIndex:)];
    
    [self swizzleSelectorWithClass:objc_getClass("__NSCFString") originalSelector:@selector(appendString:) withSelector:@selector(yuappendString:)];
    
    [self swizzleSelectorWithClass:objc_getClass("__NSCFString") originalSelector:@selector(setString:) withSelector:@selector(yusetString:)];
    
    [self swizzleSelectorWithClass:objc_getClass("__NSCFString") originalSelector:@selector(substringFromIndex:) withSelector:@selector(yusubstringFromIndex:)];
    [self swizzleSelectorWithClass:objc_getClass("__NSCFString") originalSelector:@selector(substringToIndex:) withSelector:@selector(yusubstringToIndex:)];
    [self swizzleSelectorWithClass:objc_getClass("__NSCFString") originalSelector:@selector(substringWithRange:) withSelector:@selector(yusubstringWithRange:)];
}

- (void)yuinsertString:(NSString *)aString atIndex:(NSUInteger)loc{
    @try {
        
        [self yuinsertString:aString atIndex:loc];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
    }
}

- (void)yuappendString:(NSString *)aString{
    @try {
        
        [self yuappendString:aString];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
    }
}

- (void)yusetString:(NSString *)aString{
    
    @try {
        
        [self yusetString:aString];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
    }
}

- (NSString *)yusubstringFromIndex:(NSUInteger)from{
    
    id obj = nil;
    
    @try {
        
        obj = [self yusubstringFromIndex:from];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
        return obj;
    }
}
- (NSString *)yusubstringToIndex:(NSUInteger)to{
    id obj = nil;
    
    @try {
        
        obj = [self yusubstringToIndex:to];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
        return obj;
    }
}

- (NSString *)yusubstringWithRange:(NSRange)range{
    id obj = nil;
    
    @try {
        
        obj = [self yusubstringWithRange:range];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
        return obj;
    }
}
@end
