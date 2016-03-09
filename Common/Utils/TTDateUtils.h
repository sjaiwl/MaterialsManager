//
//  TTDateUtils.h;
//  GNotes
//
//  Created by chenchao on 12-8-13.
//  Copyright (c) 2012年 Appest. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSDate+Utils.h"
#import "NSDate+TKCategory.h"
#import "NSDateComponents+Utils.h"

#define yyyy_MM_dd_HH_mm_ss @"yyyy-MM-dd HH:mm:ss"
#define yyyy_MM_dd @"yyyy-MM-dd"
#define yy_MM_dd @"yy-MM-dd"

#define FIRST_INTELLIGENT_TIME 9
#define SECOND_INTELLIGENT_TIME 13
#define THIRD_INTELLIGENT_TIME 17
#define FOURTH_INTELLIGENT_TIME 20

@interface TTDateUtils : NSObject

+ (NSDate *)getUTCFormateDate:(NSString *)dateString;

+ (NSString *)formatUTC:(NSDate *)date;
+ (NSString *)formatTime:(NSDate *)date;
+ (NSString *)formatDate:(NSDate *)date;

+ (NSString *)formatE_DMMM:(NSDate *)date;
+ (NSString *)formatE_DMMMYYYY:(NSDate *)date;
+ (NSString *)formatE_DDMMM:(NSDate *)date;

+ (NSString *)formatEEE:(NSDate *)date;

+ (NSString *)formatdMMM:(NSDate *)date;

+ (NSString *)formatdMMMyyyy:(NSDate *)date;
+ (NSString *)formatyyyyMd:(NSDate *)date;

+ (BOOL)isToday:(NSDate *)date;

+ (NSArray *)shortWeekdaySymbols;

+ (NSString *)getStringyyyyMMddDate:(NSDate *)date;
+ (NSDate *)dateForyyyyMMddString:(NSString *)dateString;

+ (NSString *)getStringDateTime:(NSDate *)date;

// subscribed calendar
+ (NSDate *)getCalendarSubscribeFormateDate:(NSString *)dateString
                               withTimeZone:(NSString *)timeZoneString;

+ (NSString *)composeSubscribedCalendarDateWithDate:(NSDate *)date;
+ (NSString *)composeSubscribedCalendarTimeWithStartDate:(NSDate *)startDate
                                                 endDate:(NSDate *)endDate;

// Determine whether the app is installed over one week
+ (BOOL)isInstalledMoreThanSevenDays;

// Import Reminder
+ (NSString *)formatDateByDateString:(NSString *)dateString;

@end
