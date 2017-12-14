//
//  NSTimer+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//


#import "NSTimer+YU.h"

@implementation NSTimer (YU)

+(id)yu_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats
{
    void (^block)(void) = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(yu_jdExecuteSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+(id)yu_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats
{
    void (^block)(void) = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(yu_jdExecuteSimpleBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+(void)yu_jdExecuteSimpleBlock:(NSTimer *)inTimer;
{
    if([inTimer userInfo])
    {
        void (^block)(void) = (void (^)(void))[inTimer userInfo];
        block();
    }
}

- (void)yu_pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)yu_resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)yu_resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

@end
