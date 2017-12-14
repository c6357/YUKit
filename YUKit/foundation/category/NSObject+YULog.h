//
//  NSObject+YULog.h
//  YUException<https://github.com/c6357/YUException>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YULog)

//+ (void)writeLog:(id)log;


FOUNDATION_EXPORT void YU_LogError(NSString *format, ...);

FOUNDATION_EXPORT void YU_LogWarn(NSString *format, ...);

FOUNDATION_EXPORT void YU_LogInfo(NSString *format, ...);

FOUNDATION_EXPORT void YU_LogCrash(void);

FOUNDATION_EXPORT void YU_Log(NSString* format, ...);


@end

@interface NSString (YULog)

- (NSString *)yu_nsLogFileName;

@end
