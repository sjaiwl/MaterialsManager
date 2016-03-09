//
//  NSDate+Utils.h
//  Appest
//
//  Created by 猪登登 on 14-7-31.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMAEnum.h"

static double const OneMinuteTimeInterval = 60;
static double const FifteenMinutesTimeInterval = 900;
static double const ThirtyMinutesTimeInterval = 1800;
static double const OneHourTimeInterval = 3600;
static double const ThreeHoursTimeInterval = 10800;
static double const OneDayTimeInterval = 86400;
static double const OneWeekTimeInterval = 604800;

static double const SecondsForOneMinute = 60;
static double const MinutesForOneHour = 60;
static double const HoursForOneDay = 24;

@interface NSDate (Utils)

- (NSInteger)getEar;
- (NSInteger)getYear;
- (NSInteger)getMonth;
- (NSInteger)getDay;
- (NSInteger)getHour;
- (NSInteger)getMinute;
- (NSInteger)getSecond;
- (NSInteger)getWeekDay;

+ (BOOL)is24HourFormat;

- (BOOL)isEarlierThanNow;
- (BOOL)isEarlierThan:(NSDate *)anotherDate;
- (BOOL)isEarlierThanOrEqualTo:(NSDate *)anotherDate;

- (BOOL)isLaterThanNow;
- (BOOL)isLaterThan:(NSDate *)anotherDate;
- (BOOL)isLaterThanOrEqualTo:(NSDate *)anotherDate;

- (NSString *)stringFromUTCDate;
- (NSString *)stringFromRemoteDailyRemindTime;

- (NSString *)dayString;
- (NSString *)weekdayString;

- (NSString *)stringForTimeYYYYMMDD;
- (NSString *)stringForTimeHHMMSS;

- (NSString *)yyyyMMddWithTimeZone;

- (NSInteger)weekOfYearWithFirstWeekday:(TTWeekday)firstWeekday;

- (NSDate *)dateFormatterOnlyYYYYMMDD;

- (BOOL)isTheSameDayAs:(NSDate *)anotherDate;
- (BOOL)isTheSameDayAs:(NSDate *)anotherDate timeZone:(NSTimeZone *)timeZone;

+ (NSDate *)dateIngoringSeconds;

+ (instancetype)nextHour;

+ (instancetype)startOfDayForYesterday;
+ (instancetype)startOfDayForToday;
+ (instancetype)startOfDayForTomorrow;
+ (instancetype)startOfDayForTheDayInOneWeek;
+ (instancetype)startOfDayForTheDayInOneMonth;
+ (instancetype)startOfDayForDate:(NSDate *)date;

+ (instancetype)endOfDayForToday;
+ (instancetype)endOfDayForTomorrow;
+ (instancetype)endOfDayForDate:(NSDate *)date;

- (instancetype)dateByAddingYear:(NSInteger)year;
- (instancetype)dateByAddingMonth:(NSInteger)month;
- (instancetype)dateByAddingWeek:(NSInteger)week;
- (instancetype)dateByAddingDay:(NSInteger)day;
- (instancetype)dateByAddingHour:(NSInteger)hour;
- (instancetype)dateByAddingMinute:(NSInteger)minute;
- (instancetype)dateByAddingSecond:(NSInteger)second;

- (NSInteger)differenceOfDayFromNow;
- (NSInteger)differenceOfDayFrom:(NSDate *)fromDate;
- (NSInteger)differenceOfDayFrom:(NSDate *)fromDate timeZone:(NSTimeZone *)timeZone;

// Chinese Calendar
- (BOOL)isLunarCalendarFestival;
- (NSString *)festivalInLunarCalendar;

- (NSString *)displayDayInLunarCalendar;
- (NSString *)displayDayInLunarCalendarHasLastDay;

@end
