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


FOUNDATION_EXPORT void YULogError(NSString *format, ...);

FOUNDATION_EXPORT void YULogWarn(NSString *format, ...);

FOUNDATION_EXPORT void YULogInfo(NSString *format, ...);

FOUNDATION_EXPORT void YULogCrash();

FOUNDATION_EXPORT void YULog(NSString* format, ...);


@end

@interface NSString (YULog)

- (NSString *)nsLogFileName;

@end
