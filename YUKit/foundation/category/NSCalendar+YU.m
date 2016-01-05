//
//  NSCalendar+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSCalendar+YU.h"

@implementation NSCalendar (YU)

+(NSDateComponents*)currentDateComponents{
    
    return [self dateComponentsWithDate:[NSDate date]];
}

+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date{
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear ;
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    return comps;
}

/** 指定时间的 年 月 周 日 等
 *  周一为一周开始
 *  @return (NSDateComponents)
 */
+(NSDateComponents*)GetDateComponentsWithDate2:(NSDate*)date{
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear ;//IOS7
    
    
    //    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday;//IOS8
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    [gregorian setFirstWeekday:2];//周一为一周开始
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    return comps;
}


+ (int)currentSec
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int sec = dt->tm_sec;
    return sec;
}

+ (int)currentMin
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int min = dt->tm_min;
    return min;
}

+ (int)currentHour
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int hour = dt->tm_hour;
    return hour;
}

+ (int)currentDay
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int day = dt->tm_mday;
    return day;
}

+ (int)currentWeek
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int day = dt->tm_wday;
    return day;
}

+ (int)currentMonth
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int month = dt->tm_mon + 1;
    return month;
}

+ (int)currentYear
{
    time_t ct = time(NULL);
    struct tm *dt = localtime(&ct);
    int year = dt->tm_year + 1900;
    return year;
}

/** 一个月中的第几周
 *  @return (int)
 */
+ (int)currentweekOfMonth
{
    // 此方法默认从星期日
    int weekOfMonth = (int)[self dateComponentsWithDate:[NSDate date]].weekOfMonth;
    return weekOfMonth;
}

/** 当前时间一年中的第几周
 *  @return (int)
 */
+ (int)currentweekOfYear
{
    int weekOfYear = (int)[self dateComponentsWithDate:[NSDate date]].weekOfYear;
    return weekOfYear;
}



+ (int)getYearWithDate:(NSDate*)date
{
    int year = (int)[self dateComponentsWithDate:date ? date:[NSDate date]].year;
    return year;
}


+ (int)getMonthWithDate:(NSDate*)date
{
    int month = (int)[self dateComponentsWithDate:date ? date:[NSDate date]].month;
    return month;
}


+ (int)getDayWithDate:(NSDate*)date
{
    int day = (int)[self dateComponentsWithDate:date ? date:[NSDate date]].day;
    return day;
}


+ (int)getWeekdayWithDate:(NSDate*)date
{
    int weekday = (int)[self dateComponentsWithDate:date ? date:[NSDate date]].weekday;
    return weekday;
}



/** 指定时间一年中的周几
 *  @return (int)
 */
+ (int)getWeekOfYearWithDate:(NSDate*)date
{
    int weekOfYear = (int)[self dateComponentsWithDate:date ? date:[NSDate date]].weekOfYear;
    
    return weekOfYear;
}

/** 指定时间一年中的第几周
 *  周一为一周开始
 *  @return (int)
 */
+ (int)getWeekOfYearWithDate2:(NSDate*)date
{
    int weekOfYear = (int)[self GetDateComponentsWithDate2:date ? date:[NSDate date]].weekOfYear;
    
    return weekOfYear;
}

/** 一月中的第几天
 *  @return (int)
 */
+ (int)numberOfDaysInMonth{
    
    return [self getNumberOfDaysInMonth:[self currentMonth] year:[self currentYear]];
}


/**
 * 得到当前年份某月有多少天
 *
 * @param month
 *
 * @return (NSInteger)
 **/
+ (int)getNumberOfDaysInMonth:(NSInteger)month
{
    return [self getNumberOfDaysInMonth:month year:[self currentYear]];
}


/**
 * 得到某年某月有多少天
 *
 * @param month
 *
 * @param year
 *
 * @return (NSInteger)
 **/
+ (int)getNumberOfDaysInMonth:(NSInteger)month year:(NSInteger) year
{
    NSAssert(!(month < 1||month > 12), @"invalid month number");
    NSAssert(!(year < 1), @"invalid year number");
    month = month - 1;
    static int daysOfMonth[12] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    int days = daysOfMonth[month];
    /*
     * feb
     */
    if (month == 1) {
        if ([self isLeapYear:year]) {
            days = 29;
        }
        else {
            days = 28;
        }
    }
    return days;
}


-(NSInteger)weekDate:(NSDate*)date
{
    NSCalendar *_calendar=[NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear ;
    NSDateComponents *com=[_calendar components:unitFlags fromDate:date ? date:[NSDate date]];
    NSString *_dayNum=@"";
    NSInteger dayInt = 0;
    switch ([com weekday]) {
        case 1:{
            _dayNum=@"日";
            dayInt = 1;
            break;
        }
        case 2:{
            _dayNum=@"一";
            dayInt = 2;
            break;
        }
        case 3:{
            _dayNum=@"二";
            dayInt = 3;
            break;
        }
        case 4:{
            _dayNum=@"三";
            dayInt = 4;
            break;
        }
        case 5:{
            _dayNum=@"四";
            dayInt = 5;
            break;
        }
        case 6:{
            _dayNum=@"五";
            dayInt = 6;
            break;
        }
        case 7:{
            _dayNum=@"六";
            dayInt = 7;
            break;
        }
            
            
        default:
            break;
    }
    return dayInt;
}



+(NSMutableArray*)switchDay
{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    
    int head = 0;
    int foot = 0;
    switch ([self currentWeek]) {
        case 1:{
            head = 0;
            foot = 6;
            break;
        }
        case 2:{
            head = 1;
            foot = 5;
            break;
        }
        case 3:{
            head = 2;
            foot = 4;
            break;
        }
        case 4:{
            head = 3;
            foot = 3;
            break;
        }
        case 5:{
            head = 4;
            foot = 2;
            break;
        }
        case 6:{
            head = 5;
            foot = 1;
            break;
        }
        case 7:{
            head = 6;
            foot = 0;
            break;
        }
            
            
        default:
            break;
    }
    
    NSLog(@"%d , %d", head, foot);

    for (int i = -head; i < 0; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [self getDayWithDate:[self dateSinceNowWithInterval:i]]];
        [array addObject:str];
    }
    
    [array addObject:[NSString stringWithFormat:@"%d", [self getDayWithDate:[self dateSinceNowWithInterval:0]]]];
    
    //sy 添加日期
    for (int i = 0; i < foot; i++)
    {
        NSString* str = [NSString stringWithFormat:@"%d", [self getDayWithDate:[self dateSinceNowWithInterval:i+1]]];
        [array addObject:str];
    }
    
    NSLog(@"weekArray = %@", array);
    
    return array;
}


/**
 * 获取当前时间是星期几
 *
 * @return (NSInteger)
 **/
+ (NSString*)getWeekWithDate:(NSDate*)date
{
    if (!date) {
        return @"";
    }
    int weekday = (int)[self dateComponentsWithDate:date ? date:[NSDate date]].weekday;
    //    NSString *_dayNum;
    
    NSArray *weekArry = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",];
    return weekArry[weekday-1];
}



//闰年？
+ (BOOL)isLeapYear:(NSInteger)year
{
    NSAssert(!(year < 1), @"invalid year number");
    BOOL leap = FALSE;
    if ((0 == (year % 400))) {
        leap = TRUE;
    }
    else if((0 == (year%4)) && (0 != (year % 100))) {
        leap = TRUE;
    }
    return leap;
}

@end



@implementation NSCalendar (NSDate)

+ (NSDate*)dateSinceNowWithInterval:(NSInteger)dayInterval{
    return [NSDate dateWithTimeIntervalSinceNow:dayInterval*24*60*60];
}

+ (NSDate*)dateWithTimeInterval:(NSInteger)dayInterval sinceDate:(NSDate*)date{
    return [NSDate dateWithTimeInterval:dayInterval*24*60*60 sinceDate:date ? date :[NSDate date]];
}

+(NSDate*)dateWithAFewMinute:(NSInteger)Num{
    NSCalendar *_greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponentsAsTimeQantum = [[NSDateComponents alloc] init];
    [dateComponentsAsTimeQantum setMinute:Num];
    NSDate *dateFromDateComponentsAsTimeQantum = [_greCalendar dateByAddingComponents:dateComponentsAsTimeQantum toDate:[NSDate date] options:0];
    return dateFromDateComponentsAsTimeQantum;
}


+(NSDate*)dateWithAFewHour:(NSInteger)hourNum{
    return [self dateWithAFewHour:hourNum Date:[NSDate date]];
}

+(NSDate*)dateWithAFewHour:(NSInteger)hourNum Date:(NSDate*)date{
    NSCalendar *_greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponentsAsTimeQantum = [[NSDateComponents alloc] init];
    [dateComponentsAsTimeQantum setHour:hourNum];
    NSDate *dateFromDateComponentsAsTimeQantum = [_greCalendar dateByAddingComponents:dateComponentsAsTimeQantum toDate:date options:0];
    return dateFromDateComponentsAsTimeQantum;
}


+(NSDate*)dateWithAFewDay:(NSInteger)dayNum{
    return [self dateWithAFewDay:dayNum Date:[NSDate date]];
}

+(NSDate*)dateWithAFewDay:(NSInteger)dayNum Date:(NSDate*)date{
    NSCalendar *_greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponentsAsTimeQantum = [[NSDateComponents alloc] init];
    [dateComponentsAsTimeQantum setDay:dayNum];
    NSDate *dateFromDateComponentsAsTimeQantum = [_greCalendar dateByAddingComponents:dateComponentsAsTimeQantum toDate:date options:0];
    return dateFromDateComponentsAsTimeQantum;
}

+(NSDate*)dateWithAFewWeek:(NSInteger)weekNum{
    NSCalendar *_greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponentsAsTimeQantum = [[NSDateComponents alloc] init];
    [dateComponentsAsTimeQantum setWeekOfMonth:weekNum];
    NSDate *dateFromDateComponentsAsTimeQantum = [_greCalendar dateByAddingComponents:dateComponentsAsTimeQantum toDate:[NSDate date] options:0];
    return dateFromDateComponentsAsTimeQantum;
}

+(NSDate*)dateWithAFewMonth:(NSInteger)monthNum{
    NSCalendar *_greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponentsAsTimeQantum = [[NSDateComponents alloc] init];
    [dateComponentsAsTimeQantum setMonth:monthNum];
    NSDate *dateFromDateComponentsAsTimeQantum = [_greCalendar dateByAddingComponents:dateComponentsAsTimeQantum toDate:[NSDate date] options:0];
    return dateFromDateComponentsAsTimeQantum;
}

+(NSDate*)dateWithAFewYea:(NSInteger)yeaNum{
    NSCalendar *_greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponentsAsTimeQantum = [[NSDateComponents alloc] init];
    [dateComponentsAsTimeQantum setYear:yeaNum];
    NSDate *dateFromDateComponentsAsTimeQantum = [_greCalendar dateByAddingComponents:dateComponentsAsTimeQantum toDate:[NSDate date] options:0];
    return dateFromDateComponentsAsTimeQantum;
}

@end
