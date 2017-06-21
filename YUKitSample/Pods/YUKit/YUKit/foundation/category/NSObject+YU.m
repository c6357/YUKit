
//
//  NSObject+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSObject+YU.h"
#import <objc/runtime.h>

@implementation NSObject (YU)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            
#ifndef  __OPTIMIZE__
        printf("%s\n","--------------------------------------------------------------------");
        printf("%s\n","------------------------------ YUKit  ------------------------------");
        printf("%s\n","----------------------- YUKit Version:1.0  -------------------------");
        printf("%s\n","------------------------ author:@BruceYu ---------------------------");
        printf("%s\n","------------------- E-mail:c6357@outlook.com -----------------------");
        printf("%s\n","--------------------------------------------------------------------");
#endif
        }
    });
}

id SafeObj(id obj){
    
   return (((obj)==nil)||([(obj) isEqual:[NSNull null]]))?@"":(obj);
}


BOOL isSafeObj(id obj){
    return (obj&&(![(obj) isEqual:[NSNull null]]));
}


- (BOOL)runUntilBlock:(BOOL(^)())block timeout:(NSTimeInterval)timeout
{
    __block Boolean fulfilled = NO;
    void (^beforeWaiting) (CFRunLoopObserverRef observer, CFRunLoopActivity activity) =
    ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        fulfilled = block();
        if (fulfilled) {
            CFRunLoopStop(CFRunLoopGetCurrent());
        }
    };
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeWaiting, true, 0, beforeWaiting);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    // Run!
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, timeout, false);
    
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    CFRelease(observer);
    
    return fulfilled;
}

+(void)afterBlock:(dispatch_block_t)block after:(float)time
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

-(void)afterBlock:(dispatch_block_t)block after:(float)time
{
    [NSObject afterBlock:block after:time];
}


- (void)performBlock:(void (^)(void))block
          afterDelay:(NSTimeInterval)delay
{
    block = [block copy];
    [self performSelector:@selector(fireBlockAfterDelay:)
               withObject:block
               afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
    block();
}

- (void)performAfterDelay:(float)delay thisBlock:(void (^)(BOOL finished))completion{
    
    [UIView animateWithDuration:delay
                     animations: ^{
                         
                     }completion:^(BOOL finished) {
                         
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

- (void)performBlockInBackground:(NSObjectPerformBlock)performBlock completion:(NSObjectPerformBlock)completionBlock userObject:(id)userObject
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        performBlock(userObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock(userObject);
            }
        });
    });
}

-(void)countdDown :(NSInteger)timeOut Done:(NillBlock_Nill)done Time:(NillBlock_Integer)time {
    __block int timeout = (int)timeOut;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                done();
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                time(timeout);
            });
        }
        timeout--;
    });
    dispatch_resume(_timer);
}

#pragma mark - 
#pragma mark - NSNotification
-(void)addNotification:(SEL)aSelector name:(NSNotificationName)aName{
    
    [self addNotification:aSelector name:aName object:nil];
}

-(void)addNotification:(SEL)aSelector name:(NSNotificationName)aName object:(id)anObject{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:(aSelector) name:(aName) object:anObject];
}

- (void)postNotificationName:(NSNotificationName)aName{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:nil];
}

- (void)postNotificationName:(NSNotificationName)aName object:(id)anObject{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
}

- (void)postNotificationName:(NSNotificationName)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:aUserInfo];
}

- (void)removeNotification:(NSNotificationName)aName{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:aName object:nil];
}

- (void)removeNotification:(NSNotificationName)aName object:(id)anObject{

    [[NSNotificationCenter defaultCenter] removeObserver:self name:aName object:anObject];
}

- (void)removeAllNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 
#pragma mark - associated
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
- (id)getAssociatedObjectForKey:(const char *)key
{
    id currValue = objc_getAssociatedObject( self, key);
    return currValue;
}

- (id)setAssociatedObject:(id)obj forKey:(const char *)key policy:(objc_AssociationPolicy)policy
{
    id oldValue = objc_getAssociatedObject( self, key );
    objc_setAssociatedObject( self, key, obj, policy );
    return oldValue;
}

- (void)removeAssociatedObjectForKey:(const char *)key policy:(objc_AssociationPolicy)policy
{
    objc_setAssociatedObject( self, key, nil, policy );
}

- (void)removeAllAssociatedObjects
{
    objc_removeAssociatedObjects( self );
}

+ (id)getAssociatedObjectForKey:(const char *)key
{
    id currValue = objc_getAssociatedObject( self, key);
    return currValue;
}

+ (id)setAssociatedObject:(id)obj forKey:(const char *)key policy:(objc_AssociationPolicy)policy
{
    id oldValue = objc_getAssociatedObject( self, key );
    objc_setAssociatedObject( self, key, obj, policy );
    return oldValue;
}

+ (void)removeAssociatedObjectForKey:(const char *)key policy:(objc_AssociationPolicy)policy
{
    objc_setAssociatedObject( self, key, nil, policy );
}

+ (void)removeAllAssociatedObjects
{
    objc_removeAssociatedObjects( self );
}
@end
