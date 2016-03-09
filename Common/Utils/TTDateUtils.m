//
//  TTDateUtils.m
//  GNotes
//
//  Created by chenchao on 12-8-13.
//  Copyright (c) 2012年 Appest. All rights reserved.
//

#import "TTDateUtils.h"
#import "TTStringUtils.h"
#import "MMAConstants.h"

#define RRULE_REPEAT_END_DATE_FORMAT_1 @"yyyyMMdd'T'HHmmss"
#define RRULE_REPEAT_END_DATE_FORMAT_2 @"yyyyMMdd'T'HHmmss'Z'"
#define RRULE_REPEAT_END_DATE_FORMAT_3 @"yyyyMMdd"

static NSCalendar *cal = nil;

static NSString *MM = nil;
static NSString *dd = nil;
static NSString *ddMMM = nil;
static NSString *dMMM = nil;
static NSString *ddMMMM = nil;
static NSString *ddMMyy = nil;
static NSString *dMMMyyyy = nil;
static NSString *yyyyMd = nil;

static NSString *MMyyyy = nil;

static NSString *EEE = nil;
static NSString *E_dMMM = nil;
static NSString *E_dMMMyyyy = nil;
static NSString *E_ddMMM = nil;

static NSString *HHmma = nil;

@implementation TTDateUtils

+ (void)initialize
{
    if (self == [TTDateUtils class]) {
        NSLocale *currentLocale = [NSLocale currentLocale];

        cal = [NSCalendar currentCalendar];
        
        dd = [NSDateFormatter dateFormatFromTemplate:@"dd" options:0 locale:currentLocale];
        MM = [NSDateFormatter dateFormatFromTemplate:@"MM" options:0 locale:currentLocale];
        ddMMM = [NSDateFormatter dateFormatFromTemplate:@"ddMMM" options:0 locale:currentLocale];

        dMMM = [NSDateFormatter dateFormatFromTemplate:@"dMMM" options:0 locale:currentLocale];

        ddMMMM = [NSDateFormatter dateFormatFromTemplate:@"ddMMMM" options:0 locale:currentLocale];
        ddMMyy = [NSDateFormatter dateFormatFromTemplate:@"ddMMyy" options:0 locale:currentLocale];

        dMMMyyyy =
            [NSDateFormatter dateFormatFromTemplate:@"dMMMyyyy" options:0 locale:currentLocale];
        yyyyMd = [NSDateFormatter dateFormatFromTemplate:@"yyyyMd" options:0 locale:currentLocale];

        MMyyyy = [NSDateFormatter dateFormatFromTemplate:@"MMyyyy" options:0 locale:currentLocale];

        EEE = [NSDateFormatter dateFormatFromTemplate:@"EEE" options:0 locale:currentLocale];
        E_dMMM = [NSDateFormatter dateFormatFromTemplate:@"E dMMM" options:0 locale:currentLocale];
        E_dMMMyyyy =
            [NSDateFormatter dateFormatFromTemplate:@"E dMMMyyyy" options:0 locale:currentLocale];
        E_ddMMM =
            [NSDateFormatter dateFormatFromTemplate:@"E ddMMM" options:0 locale:currentLocale];

        HHmma = [NSDateFormatter dateFormatFromTemplate:@"HHmm dd" options:0 locale:currentLocale];
    }
}

+ (NSString *)getTimeFromDate:(NSDate *)date
{
    [[TTDateUtils dateFormatter] setDateFormat:@"HH:mm"];
    NSString *str = [[TTDateUtils dateFormatter] stringFromDate:date];
    return str;
}

+ (NSDate *)getUTCFormateDate:(NSString *)dateString
{
    if ([NSString isEmpty:dateString] || [@"null" compare:dateString] == NSOrderedSame) {
        return nil;
    }

    NSDateFormatter *dateFormatter = [self utcDateFormatter];
    dateFormatter.dateFormat = kTTServerDateFormat;
    NSDate *date = [dateFormatter dateFromString:dateString];
    if (date == nil) {
        dateFormatter.dateFormat = kTTNewServerDateFormat;
        return [dateFormatter dateFromString:dateString];
    }
    return date;
}

+ (NSString *)formatUTC:(NSDate *)date
{
    if (date == nil) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [self utcDateFormatter];
    dateFormatter.dateFormat = kTTServerDateFormat;
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatTime:(NSDate *)date {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatdMMMyyyy:(NSDate *)date {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:dMMMyyyy];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatyyyyMd:(NSDate *)date {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:yyyyMd];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatE_DMMM:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:E_dMMM];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatE_DMMMYYYY:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:E_dMMMyyyy];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatE_DDMMM:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:E_ddMMM];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatEEE:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:EEE];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)formatdMMM:(NSDate *)date {
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:dMMM];
    return [dateFormatter stringFromDate:date];
}

+ (BOOL)isToday:(NSDate *)date
{
    NSDateComponents *components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear
                                                       | NSCalendarUnitMonth | NSCalendarUnitDay)
                                          fromDate:[NSDate date]];
    [components weekday];
    NSDate *today = [cal dateFromComponents:components];
    components = [cal components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth
                                     | NSCalendarUnitDay)
                        fromDate:date];
    NSDate *anotherDate = [cal dateFromComponents:components];

    return [today isEqualToDate:anotherDate];
}

+ (NSDateFormatter *)utcDateFormatter
{
    static NSDateFormatter *utcDateFormatter = nil;
    if (utcDateFormatter == nil) {
        utcDateFormatter = [[NSDateFormatter alloc] init];
        utcDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    }
    return utcDateFormatter;
}

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    return dateFormatter;
}

+ (NSArray *)shortWeekdaySymbols
{
    NSDateFormatter *dateFormatter = [self dateFormatter];
    return [dateFormatter shortStandaloneWeekdaySymbols];
}

+ (NSString *)getStringyyyyMMddDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [self utcDateFormatter];
    dateFormatter.dateFormat = RRULE_REPEAT_END_DATE_FORMAT_3;

    NSString *dateString = [dateFormatter stringFromDate:date];

    return dateString;
}

+ (NSDate *)dateForyyyyMMddString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [self utcDateFormatter];
    dateFormatter.dateFormat = RRULE_REPEAT_END_DATE_FORMAT_3;

    NSDate *date = [dateFormatter dateFromString:dateString];

    return date;
}

+ (NSString *)getStringDateTime:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [self utcDateFormatter];
    dateFormatter.dateFormat = yy_MM_dd;

    return [NSString stringWithFormat:@"%@ %@", [dateFormatter stringFromDate:date],
                     [TTDateUtils formatTime:date]];
}

#pragma mark - about subscribed calendar
+ (NSDate *)getCalendarSubscribeFormateDate:(NSString *)dateString
                               withTimeZone:(NSString *)timeZoneString
{
    if ([NSString isEmpty:dateString] || [@"null" compare:dateString] == NSOrderedSame) {
        return nil;
    }

    NSDateFormatter *dateFormatter = [self utcDateFormatter];
    dateFormatter.dateFormat = RRULE_REPEAT_END_DATE_FORMAT_1;
    if (![NSString isEmpty:timeZoneString]) {
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:timeZoneString];
    }
    else {
        dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
    }

    if (dateString.isConformYYYYMMDDTHHMMSS) {
        dateFormatter.dateFormat = RRULE_REPEAT_END_DATE_FORMAT_1;
    }
    else if (dateString.isConformYYYYMMDDTHHMMSSZ) {
        dateFormatter.dateFormat = RRULE_REPEAT_END_DATE_FORMAT_2;
    }
    else {
        dateFormatter.dateFormat = RRULE_REPEAT_END_DATE_FORMAT_3;
    }

    NSDate *date = [dateFormatter dateFromString:dateString];

    return date;
}

+ (NSString *)composeSubscribedCalendarTimeWithStartDate:(NSDate *)startDate
                                                 endDate:(NSDate *)endDate
{
    NSMutableString *timeString = [NSMutableString string];
    if (startDate != nil && endDate != nil) {
        [timeString appendString:[self composeSubscribedCalendarDateWithDate:startDate]];
        [timeString appendFormat:@", %@", [TTDateUtils formatTime:startDate]];

        NSTimeInterval time = [endDate timeIntervalSinceDate:startDate];
        if (time >= OneDayTimeInterval) {
            [timeString
                appendFormat:@" - %@", [self composeSubscribedCalendarDateWithDate:endDate]];
            [timeString appendFormat:@", %@", [TTDateUtils formatTime:endDate]];
        }
        else {
            [timeString appendFormat:@" - %@", [TTDateUtils formatTime:endDate]];
        }
    }
    return timeString;
}

+ (NSString *)composeSubscribedCalendarDateWithDate:(NSDate *)date
{
    NSMutableString *timeString = [NSMutableString string];
    if (date != nil) {
        [timeString appendString:[TTDateUtils formatE_DDMMM:date]];

        NSInteger days = [date differenceOfDayFromNow];
        if (days < 0) {
            [timeString appendFormat:@", %@",
                        [NSString stringWithFormat:NSLocalizedString(@"%dd ago", nil), -days]];
        }
        else {
            if (days == 0) {
                [timeString appendFormat:@", %@", NSLocalizedString(@"Today", nil)];
            }
            else if (days == 1) {
                [timeString appendFormat:@", %@", NSLocalizedString(@"Tomorrow", nil)];
            }
            else {
                [timeString appendFormat:NSLocalizedString(@", %dd left", nil), days];
            }
        }
    }

    return timeString;
}

#pragma mark - Determine whether the app is installed over one week

+ (BOOL)isInstalledMoreThanSevenDays
{
    BOOL isConform = NO;
    NSDate *now = [NSDate date];
    NSString *installDateString = [[self class] dateStringOfAPPInstallDate];

    if ([NSString isEmpty:installDateString]) {
        isConform = YES;
        NSString *nowString = [TTDateUtils getStringyyyyMMddDate:now];
        [[self class] setAPPInstallDateWithDateString:nowString];
    }
    else {
        NSDate *syncDate = [TTDateUtils dateForyyyyMMddString:installDateString];
        NSInteger day = [syncDate differenceOfDayFromNow];
        if (day < -7) {
            isConform = YES;
        }
    }
    return isConform;
}

+ (NSString *)dateStringOfAPPInstallDate
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"APPInstallTime"];
}

+ (void)setAPPInstallDateWithDateString:(NSString *)dateString
{
    [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"APPInstallTime"];
}

// Import Reminder
+ (NSString *)formatDateByDateString:(NSString *)dateString
{
    if ([NSString isEmpty:dateString]) {
        return nil;
    }

    NSDateFormatter *dateFormatter = [self utcDateFormatter];
    dateFormatter.dateFormat = RRULE_REPEAT_END_DATE_FORMAT_2;

    NSDate *date = [dateFormatter dateFromString:dateString];

    if (date) {
        return date.yyyyMMddWithTimeZone;
    }
    else {
        return nil;
    }
}

@end
