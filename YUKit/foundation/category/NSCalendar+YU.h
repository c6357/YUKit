//
//  NSCalendar+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (YU)

+(NSDateComponents*)yu_currentDateComponents;

+(NSDateComponents*)yu_dateComponentsWithDate:(NSDate*)date;

+ (int)yu_currentSec;

+ (int)yu_currentMin;

+ (int)yu_currentHour;

+ (int)yu_currentDay;

+ (int)yu_currentWeek;

+ (int)yu_currentMonth;

+ (int)yu_currentYear;

+ (int)yu_currentweekOfMonth;

+ (int)yu_currentweekOfYear;


+ (int)yu_getYearWithDate:(NSDate*)date;

+ (int)yu_getMonthWithDate:(NSDate*)date;

+ (int)yu_getDayWithDate:(NSDate*)date;

+ (int)yu_getWeekdayWithDate:(NSDate*)date;

+ (int)yu_getWeekOfYearWithDate:(NSDate*)date;

+ (int)yu_getWeekOfYearWithDate2:(NSDate*)date;


+ (int)yu_getNumberOfDaysInMonth;

+ (int)yu_getNumberOfDaysInMonth:(NSInteger)month;

+ (int)yu_getNumberOfDaysInMonth:(NSInteger)month year:(NSInteger) year;


+ (NSString*)yu_getWeekWithDate:(NSDate*)date;

+ (BOOL)yu_isLeapYear:(NSInteger)year;

@end



@interface NSCalendar (NSDate)

+(NSDate*)yu_dateSinceNowWithInterval:(NSInteger)dayInterval;

+(NSDate*)yu_dateWithTimeInterval:(NSInteger)dayInterval sinceDate:(NSDate*)date;


+(NSDate*)yu_dateWithAFewMinute:(NSInteger)Num;

+(NSDate*)yu_dateWithAFewHour:(NSInteger)hourNum;

+(NSDate*)yu_dateWithAFewHour:(NSInteger)hourNum Date:(NSDate*)date;

+(NSDate*)yu_dateWithAFewDay:(NSInteger)dayNum;

+(NSDate*)yu_dateWithAFewDay:(NSInteger)dayNum Date:(NSDate*)date;



+(NSDate*)yu_dateWithAFewWeek:(NSInteger)weekNum;

+(NSDate*)yu_dateWithAFewMonth:(NSInteger)monthNum;

+(NSDate*)yu_dateWithAFewYea:(NSInteger)yeaNum;

@end
