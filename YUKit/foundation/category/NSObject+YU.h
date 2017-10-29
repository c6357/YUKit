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

- (BOOL)yu_runUntilBlock:(nullable BOOL(^)(void))block timeout:(NSTimeInterval)timeout;

- (void)yu_afterBlock:(nullable dispatch_block_t)block after:(float)time;

+ (void)yu_afterBlock:(nullable dispatch_block_t)block after:(float)time;

- (void)yu_performBlock:(nullable void (^)(void))block afterDelay:(NSTimeInterval)delay;

- (void)yu_performAfterDelay:(float)delay thisBlock:(nullable void (^)(BOOL finished))completion;

- (void)yu_performBlockInBackground:(nullable NSObjectPerformBlock)performBlock completion:(nullable NSObjectPerformBlock)completionBlock userObject:(nullable id)userObject;

- (void)yu_countdDown:(NSInteger)timeOut Done:(nullable YU_VoidBlock)done Time:(nullable YU_VoidBlock_Int)time NS_DEPRECATED_IOS(8_0,10_0,"iOS8.0之后使用");


#pragma mark -
#pragma mark - NSNotification
- (void)yu_addNotification:(nullable SEL)aSelector name:(nullable NSNotificationName)aName;

- (void)yu_addNotification:(nullable SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject;

- (void)yu_postNotificationName:(_Nonnull NSNotificationName)aName;

- (void)yu_postNotificationName:(nullable NSNotificationName)aName object:(nullable id)anObject;

- (void)yu_postNotificationName:(nullable NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo;

- (void)yu_removeNotification:(nullable NSNotificationName)aName;

- (void)yu_removeNotification:(nullable NSNotificationName)aName object:(nullable id)anObject;

- (void)yu_removeAllNotification;

#pragma mark -
#pragma mark - runtime
+ (void)yu_swizzleSelectorWithClass:(_Nonnull Class)clazz originalSelector:(_Nonnull SEL)originalSelector withSelector:(_Nonnull SEL)swizzledSelector ;

- (_Nonnull id)yu_getAssociatedObjectForKey:( const char * _Nonnull )key;
- (_Nonnull id)yu_setAssociatedObject:(_Nonnull id)obj forKey:( const char * _Nonnull )key policy:(objc_AssociationPolicy)policy;
- (void)yu_removeAssociatedObjectForKey:(const char * _Nonnull )key policy:(objc_AssociationPolicy)policy;
- (void)yu_removeAllAssociatedObjects;


+ (_Nonnull id)yu_getAssociatedObjectForKey:(const char *_Nonnull )key;
+ (_Nonnull id)yu_setAssociatedObject:(_Nonnull id)obj forKey:(const char *_Nonnull )key policy:(objc_AssociationPolicy)policy;
+ (void)yu_removeAssociatedObjectForKey:(const char *_Nonnull )key policy:(objc_AssociationPolicy)policy;
+ (void)yu_removeAllAssociatedObjects;

@end
