//
//  NSArray+YUException.m
//  YUException<https://github.com/c6357/YUException>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSArray+YUException.h"
#import <objc/runtime.h>
#import "NSException+YUException.h"

@implementation NSArray (YUException)

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
    
    [self swizzleSelectorWithClass:objc_getClass("__NSPlaceholderArray") originalSelector:@selector(initWithObjects:count:) withSelector:@selector(yuinitWithObjects:count:)];
    
    [self swizzleSelectorWithClass:objc_getClass("__NSArray0") originalSelector:@selector(objectAtIndex:) withSelector:@selector(emptyObjectIndex:)];
    
    [self swizzleSelectorWithClass:objc_getClass("__NSArrayI") originalSelector:@selector(objectAtIndex:) withSelector:@selector(arrObjectIndex:)];
    
    [self swizzleSelectorWithClass:objc_getClass("__NSArrayM") originalSelector:@selector(objectAtIndex:) withSelector:@selector(mutableObjectIndex:)];
    
    [self swizzleSelectorWithClass:objc_getClass("__NSArrayM") originalSelector:@selector(insertObject:atIndex:) withSelector:@selector(mutableInsertObject:atIndex:)];
}

- (instancetype)yuinitWithObjects:(id  _Nonnull const __unsafe_unretained *)objects count:(NSUInteger)cnt{
    
    id obj = nil;
    
    @try {
        
        obj =  [self yuinitWithObjects:objects count:cnt];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
        return  obj;
    }
}

- (id)emptyObjectIndex:(NSInteger)index{
    
    id obj = nil;
    
    @try {
        
        obj =  [self emptyObjectIndex:index];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
        return  obj;
    }
}


- (id)arrObjectIndex:(NSInteger)index{

    id obj = nil;
    
    @try {
        
        obj =  [self arrObjectIndex:index];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
        
        }];
        
    } @finally {
        
        return  obj;
    }
}


- (id)mutableObjectIndex:(NSInteger)index{
    
    id obj = nil;
    
    @try {
        
        obj =  [self mutableObjectIndex:index];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
        return  obj;
    }
}


- (void)mutableInsertObject:(id)object atIndex:(NSUInteger)index{
    
    @try {
        
       [self mutableInsertObject:object atIndex:index];
        
    } @catch (NSException *exception) {
        
        [exception exception:^(id obj) {
            
        }];
        
    } @finally {
        
    }
}


@end
