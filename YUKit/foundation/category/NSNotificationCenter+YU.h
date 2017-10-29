//
//  NSNotificationCenter+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSNotificationCenter (YU)

- (void)yu_postNotificationOnMainThread:(NSNotification *) notification;
- (void)yu_postNotificationOnMainThread:(NSNotification *) notification waitUntilDone:(BOOL) wait;

- (void)yu_postNotificationOnMainThreadWithName:(NSString *) name object:(id) object;
- (void)yu_postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo;
- (void)yu_postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo waitUntilDone:(BOOL) wait;

@end
