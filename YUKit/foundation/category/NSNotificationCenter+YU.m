//
//  NSNotificationCenter+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//


#import "NSNotificationCenter+YU.h"
#import <pthread.h>

@implementation NSNotificationCenter (YU)

- (void)yu_postNotificationOnMainThread:(NSNotification *) notification {
    
    if( pthread_main_np() ) return [self postNotification:notification];
    [self yu_postNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void)yu_postNotificationOnMainThread:(NSNotification *) notification waitUntilDone:(BOOL) wait {
    if( pthread_main_np() ) return [self postNotification:notification];
    [[self class] performSelectorOnMainThread:@selector( yu_postNotification: ) withObject:notification waitUntilDone:wait];
}

+ (void)yu_postNotification:(NSNotification *) notification {
    [[self defaultCenter] postNotification:notification];
}

- (void)yu_postNotificationOnMainThreadWithName:(NSString *) name object:(id) object {
    if( pthread_main_np() ) return [self postNotificationName:name object:object userInfo:nil];
    [self yu_postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void)yu_postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo {
    if( pthread_main_np() ) return [self postNotificationName:name object:object userInfo:userInfo];
    [self yu_postNotificationOnMainThreadWithName:name object:object userInfo:userInfo waitUntilDone:NO];
}

- (void)yu_postNotificationOnMainThreadWithName:(NSString *) name object:(id) object userInfo:(NSDictionary *) userInfo waitUntilDone:(BOOL) wait {
    if( pthread_main_np() ) return [self postNotificationName:name object:object userInfo:userInfo];
    
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if( name ) [info setObject:name forKey:@"name"];
    if( object ) [info setObject:object forKey:@"object"];
    if( userInfo ) [info setObject:userInfo forKey:@"userInfo"];
    
    [[self class] performSelectorOnMainThread:@selector( yu_postNotificationName: ) withObject:info waitUntilDone:wait];
}

+ (void)yu_postNotificationName:(NSDictionary *) info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    
    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}


//static inline void addNotification(id observer,SEL aSelector,NSNotificationName aName ,id anObject){
//    [[NSNotificationCenter defaultCenter] addObserver:observer selector:(aSelector) name:(aName) object:anObject];
//}
//
//static inline void postNotification(SEL aSelector,NSNotificationName aName ,id anObject){
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
//}
//
//static inline void removeNotification(id observer,SEL aSelector,NSNotificationName aName){
//    [[NSNotificationCenter defaultCenter] removeObserver:observer name:aName object:nil];
//}
//
//static inline void removeAllNotification(id observer){
//    [[NSNotificationCenter defaultCenter] removeObserver:observer];
//}


//#define AddNotification(notifiName,notifiSelector) \
//[[NSNotificationCenter defaultCenter] addObserver:self selector:(notifiSelector) name:(notifiName) object:nil]
//#define PostNotification(notifiName,obj) \
//[[NSNotificationCenter defaultCenter] postNotificationName:notifiName object:obj]
//
//#define RemoveNotification(notifiName)     \
//[[NSNotificationCenter defaultCenter] removeObserver:self \
//name:notifiName \
//object:nil]
//#define RemoveAllNotification()     \
//[[NSNotificationCenter defaultCenter] removeObserver:self]



@end
