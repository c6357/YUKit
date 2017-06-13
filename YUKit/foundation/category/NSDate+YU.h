//
//  NSDate+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YU)

-(NSUInteger)day;
-(NSUInteger)month;
-(NSUInteger)year;

-(NSUInteger)next;
-(NSUInteger)pre;

#pragma mark - day
/**
 明天的当前时间
 */
-(NSDate*)nextDay;

/**
  昨天的当前时间
 */
-(NSDate*)preDay;

/**
 今天的00:00:00
 */
-(NSDate*)daybegin;

/**
 今天的23:59:59
 */
-(NSDate*)dayEnd;


#pragma mark - Week
/**
 7天后的日期
 */
-(NSDate*)nextWeek;

/**
 7天前的日期
 */
-(NSDate*)preWeek;

/**
 周一
 */
-(NSDate*)weekMonday;

/**
 周日作为一个星期的开始
 */
-(NSDate*)weekBegin;

/**
 周六作为一个星期的结束
 */
-(NSDate*)weekEnd;



#pragma mark - month
/**
 下一个月的一号
 */
-(NSDate*)nextMonth;

/**
  上一个月的一号
 */
-(NSDate*)preMonth;

/**
 当月的第一天
 */
-(NSDate*)monthBegin;


/**
 当月的最后一天
 */
-(NSDate*)monthEnd;


#pragma mark - year
/**
 下一年
 */
-(NSDate*)nextYear;
/**
 上一年
 */
-(NSDate*)preYear;

/**
 当年的年初
 */
-(NSDate*)yearBegin;

/**
 当年的年末
 */
-(NSDate*)yearEnd;

/**
 当年的最后一个星期一
 */
-(NSDate*)yearLastWeekMonday;


#pragma mark - 比较
//大于date  返回yes
-(BOOL)compareDate:(NSDate*)date;

//大于date  返回yes
-(BOOL)comparewithDate:(NSDate *)date;

// 比较 与 目标相差多久,返回值格式为 HH:MM:SS
- (NSString *)compareWithAnDate:(NSDate *)anDate;

//是否是今天
- (BOOL)isDateInToday:(NSDate *)date NS_AVAILABLE(10_9, 8_0);

/**
 判断是否是同一天 周 月 年
 */
-(BOOL)isEqualDay:(NSDate*)date;

-(BOOL)isEqualWeek:(NSDate*)date;

-(BOOL)isEqualMonth:(NSDate*)date;

-(BOOL)isEqualYear:(NSDate*)date;

#pragma mark -转换


/**
 * num天后的日期

 @param dayNum <#dayNum description#>
 @return <#return value description#>
 */
-(NSDate*)dateWithAFewDay:(NSInteger)dayNum;

/**
 * 取得日期
 * @param formatString 　   规则｜格式
 **/
-(NSDate *)dateFromString:(NSString *)formatString;


/**
 根据String返回Date:
 
 @param dateString 字符串String
 @param formatString 格式可以为yyyy-MM-dd HH:mm:ss
 */
+ (NSDate *)dateFromString:(NSString *)dateString formatString:(NSString *)formatString;

/**
 根据String返回Date:
 
 @param dateString 字符串String
 @param formatString 格式可以为yyyy-MM-dd HH:mm:ss
 @param isLocal 表示该String的时间是否为local时间
 */
+ (NSDate *)dateFromString:(NSString *)dateString formatString:(NSString *)formatString isLocal:(BOOL)isLocal;

/***
 *获取当前时间戳
 *@return 毫秒
 **/
+(NSString*)timeIntervalString;


/***
 *时间戳转换成时间字符串
 **/
+(NSString*)stringFromTimeInterval:(NSString*)timeString formatString:(NSString*)formatString;


/**
 *
 @param formatString <#formatString description#>
 @return <#return value description#>
 */
-(NSString*)stringFromDateWithFormat:(NSString*)formatString;


/**
 *日期类型转换为字符类型,第一个参数是日期格式,第二个参数为传入的日期
 *@param date 　日期
 *@param formatString 　   规则｜格式
 **/


+(NSString *)stringFromDate:(NSDate*)date formatString:(NSString*)formatString;


/**
 如果是今天就返回今天HH:mm，其他的返回日期格式时间
 @param date 日期
 @param formatString 规则｜格式
 */
+(NSString *)stringFromDateCheckToday:(NSDate*)date formatString:(NSString*)formatString;


/**
 *日期类型转换为字符类型,第一个参数是日期格式,第二个参数为传入的日期
 *@param dateString 　日期串
 *@param sourceFormatString     原规则｜格式
 *@param destinationFormatString 　    新规则｜格式
 **/

+(NSString *)stringFromDateString:(NSString*)dateString sourceFormat:(NSString*)sourceFormatString destinationFormat:(NSString*)destinationFormatString;


/**
 *日期类型转换为字符类型,第一个参数是日期格式,第二个参数为传入的日期
 *@param dateString 　日期串
 *@param sourceFormatString     原规则｜格式
 *@param destinationFormatString 　    新规则｜格式
 **/
+(NSString *)stringFromDateString2Simplify:(NSString*)dateString sourceFormat:(NSString*)sourceFormatString destinationFormat:(NSString*)destinationFormatString;

@end
