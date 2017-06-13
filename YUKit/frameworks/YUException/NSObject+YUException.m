//
//  NSObject+YUException.m
//  YUException<https://github.com/c6357/YUException>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//
#import "NSObject+YUException.h"
#import <objc/runtime.h>
#import "NSException+YUException.h"

@implementation NSObject (YUException)

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
    
    [self swizzleSelectorWithClass:[self class] originalSelector:@selector(setValue:forKey:) withSelector:@selector(yusetValue:forKey:)];

    [self swizzleSelectorWithClass:[self class] originalSelector:@selector(valueForKey:) withSelector:@selector(yuvalueForKey:)];
    

}



-(void)yusetValue:(id)value forKey:(NSString *)key{
    
    @try {
        
        [self yusetValue:value forKey:key];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
    }
}

-(id)yuvalueForKey:(NSString *)key{
   
    id obj = nil;
    
    @try {
        
        obj = [self yuvalueForKey:key];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        return obj;
    }
}

@end
