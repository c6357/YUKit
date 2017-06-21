//
//  NSObject+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "YUKit.h"

typedef void (^NSObjectPerformBlock)(_Nonnull id userObject);

@interface NSObject (YU)

- (BOOL)runUntilBlock:(nullable BOOL(^)())block timeout:(NSTimeInterval)timeout;

- (void)afterBlock:(nullable dispatch_block_t)block after:(float)time;

+ (void)afterBlock:(nullable dispatch_block_t)block after:(float)time;

- (void)performBlock:(nullable void (^)(void))block afterDelay:(NSTimeInterval)delay;

- (void)performAfterDelay:(float)delay thisBlock:(nullable void (^)(BOOL finished))completion;

- (void)performBlockInBackground:(nullable NSObjectPerformBlock)performBlock completion:(nullable NSObjectPerformBlock)completionBlock userObject:(nullable id)userObject;

- (void)countdDown:(NSInteger)timeOut Done:(nullable NillBlock_Nill)done Time:(nullable NillBlock_Integer)time NS_DEPRECATED_IOS(8_0,10_0,"iOS8.0之后使用");


#pragma mark -
#pragma mark - NSNotification
- (void)addNotification:(nullable SEL)aSelector name:(nullable NSNotificationName)aName;

- (void)addNotification:(nullable SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject;

- (void)postNotificationName:(_Nonnull NSNotificationName)aName;

- (void)postNotificationName:(nullable NSNotificationName)aName object:(nullable id)anObject;

- (void)postNotificationName:(nullable NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

- (void)removeNotification:(nullable NSNotificationName)aName;

- (void)removeNotification:(nullable NSNotificationName)aName object:(nullable id)anObject;

- (void)removeAllNotification;

#pragma mark -
#pragma mark - runtime
+ (void)swizzleSelectorWithClass:(_Nonnull Class)clazz originalSelector:(_Nonnull SEL)originalSelector withSelector:(_Nonnull SEL)swizzledSelector ;

- (_Nonnull id)getAssociatedObjectForKey:( const char * _Nonnull )key;
- (_Nonnull id)setAssociatedObject:(_Nonnull id)obj forKey:( const char * _Nonnull )key policy:(objc_AssociationPolicy)policy;
- (void)removeAssociatedObjectForKey:(const char * _Nonnull )key policy:(objc_AssociationPolicy)policy;
- (void)removeAllAssociatedObjects;


+ (_Nonnull id)getAssociatedObjectForKey:(const char *_Nonnull )key;
+ (_Nonnull id)setAssociatedObject:(_Nonnull id)obj forKey:(const char *_Nonnull )key policy:(objc_AssociationPolicy)policy;
+ (void)removeAssociatedObjectForKey:(const char *_Nonnull )key policy:(objc_AssociationPolicy)policy;
+ (void)removeAllAssociatedObjects;

@end
