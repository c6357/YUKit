//
//  NSDate+YU.m
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "NSDate+YU.h"
#import "NSCalendar+YU.h"


#pragma mark - DateFormat
/*
 小写的h是12小时制，大写的H是24小时制。
 
 */

NSString * const  yu_dateFormatNill = @"0000-00-00 00:00:00.000";
NSString * const  yu_dateDefaultFormat =  @"yyyy-MM-dd HH:mm:ss";
NSString * const  yu_dateDefaultFormat_SSS =  @"yyyyMMddHHmmssSSS";

//NSString * const  dateDefaultFormat =  @"yyyy/MM/dd";

//NSString * const  dateFormat_yyyy_MM_dd_HH =  @"yyyy-MM-dd HH:mm:ss.SSS";
//NSString * const  dateFormat_02 =  @"yyyy-MM-dd HH:mm:ss";
//NSString * const  dateFormat_03 =  @"yyyy-MM-dd HH:mm";
//NSString * const  dateFormat_04 =  @"yyyy-MM-dd HH";
//NSString * const  dateFormat_05 =  @"yyyy-MM-dd";
//NSString * const  dateFormat_06 =  @"MM-dd HH:mm";
//
//NSString * const  dateFormat01 =  @"yyyy.MM.dd HH:mm.ss.SSS";
//NSString * const  dateFormat02 =  @"yyyy.MM.dd HH:mm.ss";
//NSString * const  dateFormat03 =  @"yyyy.MM.dd HH:mm";
//NSString * const  dateFormat04 =  @"yyyy.MM.dd HH";
//NSString * const  dateFormat05 =  @"yyyy.MM.dd";
//
//NSString * const  dateFormat一 =  @"yyyy年MM月dd日HH点mm分";
//NSString * const  dateFormat二 =  @"MM月dd日HH点mm分";


#define kOneDayInterval (24 * 60 * 60 )
#define k7DayInterval (7 * kOneDayInterval)

@implementation NSDate (YU)

-(NSUInteger)yu_day
{
    return [NSCalendar yu_getDayWithDate:self];
}

-(NSUInteger)yu_month
{
    return [NSCalendar yu_getMonthWithDate:self];
}

-(NSUInteger)yu_year
{
    return [NSCalendar yu_getYearWithDate:self];
}

-(NSUInteger)yu_next
{
    NSDate *date = [self dateByAddingTimeInterval:kOneDayInterval];
    return date.yu_day;
}

-(NSUInteger)yu_pre
{
    NSDate *date = [self dateByAddingTimeInterval:-kOneDayInterval];
    return date.yu_day;
    
}


#pragma mark - day
-(NSDate*)yu_nextDay
{
    return [self dateByAddingTimeInterval:kOneDayInterval];
}

-(NSDate*)yu_preDay
{
    return [self dateByAddingTimeInterval:-kOneDayInterval];
}

-(NSDate*)yu_daybegin
{
    NSDateComponents *comp = [NSCalendar yu_dateComponentsWithDate:self];
    comp.hour = 0;
    comp.minute = 0;
    comp.second = 0;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

-(NSDate*)yu_dayEnd
{
    NSDateComponents *comp = [NSCalendar yu_dateComponentsWithDate:self];
    comp.hour = 23;
    comp.minute = 59;
    comp.second = 59;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

#pragma mark - Week
-(NSDate*)yu_nextWeek
{
    return [self dateByAddingTimeInterval:7 * kOneDayInterval];
}

-(NSDate*)yu_preWeek
{
    return [self dateByAddingTimeInterval:-7 * kOneDayInterval];
}

-(NSDate*)yu_weekMonday
{
    int weekDay = [NSCalendar yu_getWeekdayWithDate:self];
    int offset = 0;
    if (weekDay == 1) {
        offset = -6;
    } else {
        offset = 2- weekDay;
    }
    NSDate *date = [self dateByAddingTimeInterval:(kOneDayInterval * offset)];
    return date;
}

-(NSDate*)yu_weekBegin
{
    int weekDay = [NSCalendar yu_getWeekdayWithDate:self];
    int offset = weekDay - 1;
    
    NSDate *date = [self dateByAddingTimeInterval:-(kOneDayInterval * offset)];
    return date;
}

-(NSDate*)yu_weekEnd
{
    int week = [NSCalendar yu_getWeekOfYearWithDate:self];
    if (week == 1 && self.yu_month == 12) {
        return self.yu_yearEnd;
    } else {
        return self.yu_weekBegin.yu_nextWeek.yu_preDay;
    }
}

#pragma mark - month
-(NSDate*)yu_nextMonth
{
    NSDateComponents *comp = [NSCalendar yu_dateComponentsWithDate:self];
    comp.month = (comp.month + 1) % 13 + (comp.month + 1) / 13;
    comp.day = 1;
    if (comp.month == 1) {
        comp.year++;
    }
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}

-(NSDate*)yu_preMonth
{
    NSDateComponents *comp = [NSCalendar yu_dateComponentsWithDate:self];
    int month = (comp.month - 1) % 13;
    int year = (int)comp.year;
    if (month == 0) {
        month = 12;
        year--;
    }
    comp.day = 1;
    comp.year = year;
    comp.month = month;
    return [[NSCalendar currentCalendar] dateFromComponents:comp];
}


-(NSDate*)yu_monthBegin
{
    NSDateComponents *comp = [NSCalendar yu_dateComponentsWithDate:self];
    comp.day = 1;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date;
}


-(NSDate*)yu_monthEnd{
    return nil;
}


-(NSDate*)yu_nextYear
{
    NSDateComponents *comp = [NSCalendar yu_dateComponentsWithDate:self];
    comp.year++;
    comp.month = comp.day = 1;
    comp.hour = comp.second = comp.minute = 0;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date;
}

-(NSDate*)yu_preYear
{
    NSDateComponents *comp = [NSCalendar yu_dateComponentsWithDate:self];
    comp.year--;
    comp.month = comp.day = 1;
    comp.hour = comp.second = comp.minute = 0;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date;
}

-(NSDate*)yu_yearBegin
{
    NSDateComponents *comp = [NSCalendar yu_dateComponentsWithDate:self];
    comp.month = 1;
    comp.day = 1;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date;
}

-(NSDate*)yu_yearEnd
{
    NSDateComponents *comp = [NSCalendar yu_dateComponentsWithDate:self];
    comp.month = 12;
    comp.day = 31;
    NSDate *date = [[NSCalendar currentCalendar] dateFromComponents:comp];
    return date;
}

-(NSDate*)yu_yearLastWeekMonday
{
    NSDate *date = self.yu_yearEnd;
    int week = [NSCalendar yu_getWeekdayWithDate:date];
    date = [date dateByAddingTimeInterval:-(week - 1) * kOneDayInterval];
    return date;
}

#pragma mark - 比较
//大于date  返回yes
-(BOOL)yu_compareDate:(NSDate*)date{
    return [[self earlierDate:date] isEqualToDate:date];
}

-(BOOL)yu_comparewithDate:(NSDate *)date{
    NSComparisonResult result = [self compare:date];
    BOOL isbig = NO;
    if (result==NSOrderedDescending) {//大于
        isbig = YES;
    }
    return isbig;
}

- (NSString *)yu_compareWithAnDate:(NSDate *)anDate
{
    NSCalendar *chineseClendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags =  NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    // 当前系统时间 与 活动结束时间 比较
    NSDateComponents *cps = [ chineseClendar components:unitFlags fromDate:self  toDate:anDate  options:0];
    
    NSInteger diffHour = cps.hour;
    NSInteger diffMinute = cps.minute;
    NSInteger diffSecond = cps.second;
    
    NSString *diffHourStr;
    NSString *diffMinuteStr;
    NSString *diffSecondStr;
    
    if (diffHour < 10) {
        diffHourStr = [NSString stringWithFormat:@"0%@",@(diffHour).stringValue];
    } else {
        diffHourStr = @(diffHour).stringValue;
    }
    
    if (diffMinute < 10) {
        diffMinuteStr = [NSString stringWithFormat:@"0%@",@(diffMinute).stringValue];
    } else {
        diffMinuteStr = @(diffMinute).stringValue;
    }
    
    if (diffSecond < 10) {
        diffSecondStr = [NSString stringWithFormat:@"0%@",@(diffSecond).stringValue];
    } else {
        diffSecondStr = @(diffSecond).stringValue;
    }
    
    return [NSString stringWithFormat:@"%@:%@:%@",diffHourStr,diffMinuteStr,diffSecondStr];
}

- (BOOL)yu_isDateInToday:(NSDate *)date NS_AVAILABLE(10_9, 8_0){
    
    return [[NSCalendar currentCalendar] isDateInToday:date];
}


-(BOOL)yu_isEqualDay:(NSDate*)date{
    return ([NSCalendar yu_getYearWithDate:self] == [NSCalendar yu_getYearWithDate:date] &&
            [NSCalendar yu_getMonthWithDate:self] == [NSCalendar yu_getMonthWithDate:date] &&
            [NSCalendar yu_getDayWithDate:self] == [NSCalendar yu_getDayWithDate:date])
    ;
}

-(BOOL)yu_isEqualWeek:(NSDate*)date{
    BOOL isEqual =  ([NSCalendar yu_getYearWithDate:self] == [NSCalendar yu_getYearWithDate:date] &&
                     [NSCalendar yu_getMonthWithDate:self] == [NSCalendar yu_getMonthWithDate:date] && [NSCalendar yu_getWeekOfYearWithDate2:self]== [NSCalendar yu_getWeekOfYearWithDate2:date]);
    return isEqual;
    
}

-(BOOL)yu_isEqualMonth:(NSDate*)date{
    return ([NSCalendar yu_getYearWithDate:self] == [NSCalendar yu_getYearWithDate:date] &&
            [NSCalendar yu_getMonthWithDate:self] == [NSCalendar yu_getMonthWithDate:date])
    ;
}

-(BOOL)yu_isEqualYear:(NSDate*)date{
    return [NSCalendar yu_getYearWithDate:self] == [NSCalendar yu_getYearWithDate:date];
}

#pragma mark -转换
-(NSDate*)yu_dateWithAFewDay:(NSInteger)dayNum{
    
    NSCalendar *_greCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponentsAsTimeQantum = [[NSDateComponents alloc] init];
    [dateComponentsAsTimeQantum setDay:dayNum];
    
    NSDate *dateFromDateComponentsAsTimeQantum = [_greCalendar dateByAddingComponents:dateComponentsAsTimeQantum toDate:self options:0];
    return dateFromDateComponentsAsTimeQantum;
}


-(NSDate *)yu_dateFromString:(NSString *)formatString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:formatString];
    NSString *dateTime = [dateFormatter stringFromDate:[NSDate date]];
    return [dateFormatter dateFromString:dateTime];
}

+ (NSDate *)yu_dateFromString:(NSString *)dateString formatString:(NSString *)formatString{
    return [self yu_dateFromString:dateString formatString:formatString isLocal:YES];
}

+ (NSDate *)yu_dateFromString:(NSString *)dateString formatString:(NSString *)formatString isLocal:(BOOL)isLocal
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    
    if (isLocal) {
        [dateFormatter setLocale:[NSLocale currentLocale]];
    }
    return [dateFormatter dateFromString:dateString];
}

+(NSString*)yu_timeIntervalString{
    NSTimeInterval timeInterval =[[NSDate date] timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%.0f",timeInterval*1000];
}

+(NSString*)yu_stringFromTimeInterval:(NSString*)timeString formatString:(NSString*)formatString{
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [date yu_stringFromDateWithFormat:formatString];
    
    return dateString;
}

-(NSString*)yu_stringFromDateWithFormat:(NSString*)formatString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    NSString *destDateString = [dateFormatter stringFromDate:self];
    return  destDateString;
}

+(NSString *)yu_stringFromDate:(NSDate*)date formatString:(NSString*)formatString{
    return [date yu_stringFromDateWithFormat:formatString];
}

+(NSString *)yu_stringFromDateCheckToday:(NSDate*)date formatString:(NSString*)formatString{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    NSString *str = nil;
    if ([date yu_isEqualDay:[NSDate date]]) {
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:@"HH:mm"];
        str = [NSString stringWithFormat:@"今天 %@",[outputFormatter stringFromDate:date]];
    }else{
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:formatString];
        str = [outputFormatter stringFromDate:date];
    }
    return str;
}


+(NSString *)yu_stringFromDateString:(NSString*)dateString sourceFormat:(NSString*)sourceFormatString destinationFormat:(NSString*)destinationFormatString{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];
    [inputFormatter setDateFormat:sourceFormatString];
    
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:destinationFormatString];
    
    NSString *str = [outputFormatter stringFromDate:inputDate];
    return str;
}

+(NSString *)yu_stringFromDateString2Simplify:(NSString*)dateString sourceFormat:(NSString*)sourceFormatString destinationFormat:(NSString*)destinationFormatString{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[NSLocale currentLocale]];
    [inputFormatter setDateFormat:sourceFormatString];
    
    NSDate* inputDate = [inputFormatter dateFromString:dateString];
    
    NSString *str = nil;
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"HH:mm"];
    
    NSDate *otherDate = [[NSDate date] dateByAddingTimeInterval:-24*60*60];
    if ([otherDate yu_isEqualDay:inputDate]) {
        
        str = [NSString stringWithFormat:@"昨天 %@",[outputFormatter stringFromDate:inputDate]];
        
    }else if ([inputDate yu_isEqualDay:[NSDate date]]) {

        str = [NSString stringWithFormat:@"今天 %@",[outputFormatter stringFromDate:inputDate]];
    }else{
        
        [outputFormatter setDateFormat:destinationFormatString];
        str = [outputFormatter stringFromDate:inputDate];
    }
    return str;
}




//仅限本地操作有效
#define YU_NotDisturbDateBefore @"YYYY-MM-DD 08:00:00" //早上 XXX 之前免打扰
#define YU_NotDisturbDateAfter  @"YYYY-MM-DD 19:00:00" //晚上 XXX 之后免打扰
-(BOOL)yu_isNotDisturb{
    NSDate *NotDisturbStartDate = [[NSDate date] yu_dateFromString:YU_NotDisturbDateBefore];
    NSDate *NotDisturbEndDate = [[NSDate date] yu_dateFromString:YU_NotDisturbDateAfter];
    //>08 && < 19 非打扰
    if ([self yu_compareDate:NotDisturbStartDate] && ![self yu_compareDate:NotDisturbEndDate]){
        return NO;
    }
    return YES;
}


@end
