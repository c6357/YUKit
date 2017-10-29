//
//  NSTimer+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/10/13.
//  Copyright © 2015年 BruceYu. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSTimer (YU)

+(id)yu_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats;

+(id)yu_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(void))inBlock repeats:(BOOL)inRepeats;

- (void)yu_pause;
- (void)yu_resume;
- (void)yu_resumeWithTimeInterval:(NSTimeInterval)time;

@end
