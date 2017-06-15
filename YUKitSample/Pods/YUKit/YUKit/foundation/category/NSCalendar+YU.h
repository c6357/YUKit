//
//  NSCalendar+YU.h
//  YUKit<https://github.com/c6357/YUKit>
//
//  Created by BruceYu on 15/9/2.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (YU)

+(NSDateComponents*)currentDateComponents;

+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date;

+ (int)currentSec;

+ (int)currentMin;

+ (int)currentHour;

+ (int)currentDay;

+ (int)currentWeek;

+ (int)currentMonth;

+ (int)currentYear;

+ (int)currentweekOfMonth;

+ (int)currentweekOfYear;


+ (int)getYearWithDate:(NSDate*)date;

+ (int)getMonthWithDate:(NSDate*)date;

+ (int)getDayWithDate:(NSDate*)date;

+ (int)getWeekdayWithDate:(NSDate*)date;

+ (int)getWeekOfYearWithDate:(NSDate*)date;

+ (int)getWeekOfYearWithDate2:(NSDate*)date;


+ (int)numberOfDaysInMonth;

+ (int)getNumberOfDaysInMonth:(NSInteger)month;

+ (int)getNumberOfDaysInMonth:(NSInteger)month year:(NSInteger) year;


+ (NSString*)getWeekWithDate:(NSDate*)date;

+ (BOOL)isLeapYear:(NSInteger)year;

@end



@interface NSCalendar (NSDate)

+(NSDate*)dateSinceNowWithInterval:(NSInteger)dayInterval;

+(NSDate*)dateWithTimeInterval:(NSInteger)dayInterval sinceDate:(NSDate*)date;


+(NSDate*)dateWithAFewMinute:(NSInteger)Num;

+(NSDate*)dateWithAFewHour:(NSInteger)hourNum;

+(NSDate*)dateWithAFewHour:(NSInteger)hourNum Date:(NSDate*)date;

+(NSDate*)dateWithAFewDay:(NSInteger)dayNum;

+(NSDate*)dateWithAFewDay:(NSInteger)dayNum Date:(NSDate*)date;



+(NSDate*)dateWithAFewWeek:(NSInteger)weekNum;

+(NSDate*)dateWithAFewMonth:(NSInteger)monthNum;

+(NSDate*)dateWithAFewYea:(NSInteger)yeaNum;

@end
