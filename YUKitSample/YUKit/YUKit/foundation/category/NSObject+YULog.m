//
//  NSObject+YULog.m
//  YUException<https://github.com/c6357/YUException>
//
//  Created by BruceYu on 15/9/1.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSObject+YULog.h"

#define LOGRETURN @": "

#define LOGPATH @"log path"


#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif

NSString *LogFileName;
const char *lineStr = "\n\n👉👉👉";
const char *warnStr = "\n\n⚠️⚠️⚠️警告";
const char *errorStr = "\n\n❌❌❌错误";

@implementation NSObject (YULog)
FOUNDATION_EXPORT NSString *DFILE(){
    return  [[NSString stringWithFormat:@"%s",__FILE__] nsLogFileName];
}



FOUNDATION_EXPORT void YULogError(NSString *format, ...){
#ifndef __OPTIMIZE__
    fprintf( stderr, "%s",errorStr);
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
    fprintf( stderr, "\n\n");
#endif
}

FOUNDATION_EXPORT void YULogWarn(NSString *format, ...){
#ifndef __OPTIMIZE__
    fprintf( stderr, "%s",warnStr);
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
    fprintf( stderr, "\n\n");
#endif
}

FOUNDATION_EXPORT void YULogInfo(NSString *format, ...){
#ifndef __OPTIMIZE__
    format = [NSString stringWithFormat:@"[文件名:%@]\n[函数名:%s]\n[行号:%d] %@",DFILE(),__FUNCTION__,__LINE__,format];
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
#endif
}

FOUNDATION_EXPORT void YULogCrash(){
    NSString *format = [NSString stringWithFormat:@"\
                        \n[文件名:%@]\n[函数名:%s]\n[行号:%d] Crash：%@\n",DFILE(),__FUNCTION__,__LINE__,[NSThread callStackSymbols]];
    NSLog(@"%@",format);
}

FOUNDATION_EXPORT void YULog(NSString* format, ...){
#ifndef __OPTIMIZE__
    fprintf( stderr, "%s",lineStr);
    va_list args;
    va_start(args, format);
    NSLogv(format, args);
    va_end(args);
    fprintf( stderr, "\n\n");
#endif
}


//
//+ (void)writeLog:(id)log{
//#ifdef DEBUG
//    if(!isSafeString(LogFileName)){
//        LogFileName =  [self fileNameString];
//    }
//    NSString* fileNamePackageRes = [[NSString alloc] initWithFormat:@"%@/%@%@",LOGPATH,LogFileName,@".txt"];
//
//    NSString* oldLog =[[NSString alloc] initWithContentsOfFile:fileNamePackageRes encoding:NSUTF8StringEncoding error:nil];
//    
//    if (!oldLog) {
//        NSString* strLogData = [[NSString alloc]initWithFormat:@"%@%@%@",[self timeString],LOGRETURN,log];
//        [strLogData writeToFile:fileNamePackageRes atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    }else{
//        oldLog = [NSString stringWithFormat:@"%@\n\n%@%@%@",oldLog,[self timeString],LOGRETURN,log];
//        [oldLog writeToFile:fileNamePackageRes atomically:YES encoding:NSUTF8StringEncoding error:nil];
//    }
//#endif
//}
//
//
//+(NSString*)fileNameString{
//    NSDateFormatter *dateFormatter_fileName = [[NSDateFormatter alloc] init];
//    [dateFormatter_fileName setDateFormat:@"yyyy.MM.dd.hh.mm.ss"];
//    NSString *fileName                      = [dateFormatter_fileName stringFromDate:[NSDate date]];
//    return fileName;
//}
//
//
//+(NSString*)timeString{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy:MM:dd:hh:mm:ss"];
//    NSString *timeStr              = [dateFormatter stringFromDate:[NSDate date]];
//
//    return timeStr;
//}
//
//
//void LogFrame(CGRect frame){
//    NSLog(@"frame[X=%.1f,Y=%.1f,W=%.1f,H=%.1f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
//}
//
//
//void LogPoint(CGPoint point){
//    
//    NSLog(@"point [X=%.1f,Y=%.1f",point.x,point.y);
//}


@end



@implementation NSString (YULog)

- (NSString *)nsLogFileName
{
    
    NSString *file = [[NSString alloc]initWithString:self];
    
    NSRange range = [file rangeOfString:@"/" options:NSBackwardsSearch];
    
    if (range.location != NSNotFound) {
        
        file = [file substringFromIndex:range.location+1];
        
    }
    
    return file;
    
}
@end

