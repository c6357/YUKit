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

typedef void (^NSObjectPerformBlock)(id userObject);

@interface NSObject (YU)

- (void)afterBlock:(dispatch_block_t)block after:(float)time;


- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;


- (void)performAfterDelay:(float)delay thisBlock:(void (^)(BOOL finished))completion;


- (void)performBlockInBackground:(NSObjectPerformBlock)performBlock completion:(NSObjectPerformBlock)completionBlock userObject:(id)userObject;


- (void)countdDown:(NSInteger)timeOut Done:(NillBlock_Nill)done Time:(NillBlock_Integer)time NS_DEPRECATED_IOS(8_0,10_0,"iOS8.0之后使用");


- (id)getAssociatedObjectForKey:(const char *)key;
- (id)setAssociatedObject:(id)obj forKey:(const char *)key policy:(objc_AssociationPolicy)policy;
- (void)removeAssociatedObjectForKey:(const char *)key policy:(objc_AssociationPolicy)policy;
- (void)removeAllAssociatedObjects;


+ (id)getAssociatedObjectForKey:(const char *)key;
+ (id)setAssociatedObject:(id)obj forKey:(const char *)key policy:(objc_AssociationPolicy)policy;
+ (void)removeAssociatedObjectForKey:(const char *)key policy:(objc_AssociationPolicy)policy;
+ (void)removeAllAssociatedObjects;

@end
