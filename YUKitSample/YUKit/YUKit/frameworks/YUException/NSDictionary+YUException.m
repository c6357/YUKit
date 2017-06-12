//
//  NSDictionary+YUException.m
//  YUException<https://github.com/c6357/YUException>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSDictionary+YUException.h"
#import <objc/runtime.h>
#import "NSException+YUException.h"

@implementation NSDictionary (YUException)

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
    
    [self swizzleSelectorWithClass:objc_getClass("__NSPlaceholderDictionary") originalSelector:@selector(initWithObjects:forKeys:count:) withSelector:@selector(yuinitWithObjects:forKeys:count:)];
    
    [self swizzleSelectorWithClass:objc_getClass("__NSDictionaryM") originalSelector:@selector(setObject:forKey:) withSelector:@selector(yusetObject:forKey:)];

    
    [self swizzleSelectorWithClass:objc_getClass("__NSDictionaryM") originalSelector:@selector(removeObjectForKey:) withSelector:@selector(yuremoveObjectForKey:)];
}


- (instancetype)yuinitWithObjects:(id  _Nonnull const __unsafe_unretained *)objects forKeys:(id<NSCopying>  _Nonnull const __unsafe_unretained *)keys count:(NSUInteger)cnt{
    
    id obj = nil;
    
    @try {

        obj =  [self yuinitWithObjects:objects forKeys:keys count:cnt];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
        return  obj;
    }
}



-(void)yusetObject:(nonnull id)anObject forKey:(nonnull id<NSCopying>)aKey{
    
    @try {
        
       [self yusetObject:anObject forKey:aKey];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
    
    }
}

- (void)yuremoveObjectForKey:(nonnull id)aKey{
    @try {
        
        [self yuremoveObjectForKey:aKey];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
    }
}

@end
