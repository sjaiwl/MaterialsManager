//
//  NSDate+Utils.m
//  Appest
//
//  Created by 猪登登 on 14-7-31.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import "NSDate+Utils.h"
#import "TTStringUtils.h"
#import "TTDateUtils.h"
#import "MMAConstants.h"

@implementation NSDate (Utils)

+ (NSCalendar *)currentCalendar {
    static NSCalendar *CurrentCalendar = nil;
    if (!CurrentCalendar) {
        CurrentCalendar = [NSCalendar currentCalendar];
    }
    return CurrentCalendar;
}

#pragma mark - Accessors

- (NSInteger)getEar
{
    return [[[self class] currentCalendar] components:NSCalendarUnitYear fromDate:self].era;
}

- (NSInteger)getYear
{
    return [[[self class] currentCalendar] components:NSCalendarUnitYear fromDate:self].year;
}

- (NSInteger)getMonth
{
    return [[[self class] currentCalendar] components:NSCalendarUnitMonth fromDate:self].month;
}

- (NSInteger)getDay
{
    return [[[self class] currentCalendar] components:NSCalendarUnitDay fromDate:self].day;
}

- (NSInteger)getHour
{
    return [[[self class] currentCalendar] components:NSCalendarUnitHour fromDate:self].hour;
}

- (NSInteger)getMinute
{
    return [[[self class] currentCalendar] components:NSCalendarUnitMinute fromDate:self].minute;
}

- (NSInteger)getSecond
{
    return [[[self class] currentCalendar] components:NSCalendarUnitSecond fromDate:self].second;
}

- (NSInteger)getWeekDay
{
    NSDateComponents *components =
        [[[self class] currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitWeekday
                                          fromDate:self];
    return components.weekday;
}

#pragma mark - Public

+ (BOOL)is24HourFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];
    return amRange.location == NSNotFound && pmRange.location == NSNotFound;
}

- (BOOL)isEarlierThanNow {
    return [self isEarlierThan:[NSDate date]];
}

- (BOOL)isEarlierThan:(NSDate *)anotherDate {
    return [self compare:anotherDate] == NSOrderedAscending;
}

- (BOOL)isLaterThanNow {
    return [self isLaterThan:[NSDate date]];
}

- (BOOL)isEarlierThanOrEqualTo:(NSDate *)anotherDate {
    return [self isEarlierThan:anotherDate] || [self isEqualToDate:anotherDate];
}

- (BOOL)isLaterThan:(NSDate *)anotherDate {
    return [self compare:anotherDate] == NSOrderedDescending;
}

- (BOOL)isLaterThanOrEqualTo:(NSDate *)anotherDate {
    return [self isLaterThan:anotherDate] || [self isEqualToDate:anotherDate];
}

- (NSString *)stringFromUTCDate
{
    return [[[self class] utcDateFormatter] stringFromDate:self];
}

- (NSString *)stringFromRemoteDailyRemindTime
{
    return [[[self class] remoteDailyRemindTimeFormatter] stringFromDate:self];
}

- (NSString *)dayString
{
    NSDateComponents *components =
        [[[self class] currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return [NSString stringWithFormat:@"%ld", (long)components.day];
}

- (NSString *)weekdayString
{
    NSDateComponents *components =
        [[[self class] currentCalendar] components:NSCalendarUnitEra | NSCalendarUnitWeekday
                                          fromDate:self];
    return @[ @"", @"Su", @"Mo", @"Tu", @"We", @"Th", @"Fr", @"Sa" ][components.weekday];
}

- (NSString *)stringForTimeYYYYMMDD
{
    return [[[self class] yyyyMMddDateFormatter] stringFromDate:self];
}

- (NSString *)stringForTimeHHMMSS
{
    return [[[self class] hhmmssDateFormatter] stringFromDate:self];
}

- (NSString *)yyyyMMddWithTimeZone
{
    NSCalendar *currentCalendar = [[self class] currentCalendar];
    NSDateComponents *dateComponents =
        [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                           fromDate:self];
    return [NSString stringWithFormat:@"%04ld%02ld%02ld", (long)dateComponents.year,
                     (long)dateComponents.month, (long)dateComponents.day];
}

- (NSInteger)weekOfYearWithFirstWeekday:(TTWeekday)firstWeekday
{
    NSCalendar *currentCalendar = [[self class] currentCalendar];
    currentCalendar.firstWeekday = firstWeekday;
    NSDateComponents *components =
        [currentCalendar components:NSCalendarUnitEra | NSCalendarUnitWeekOfYear fromDate:self];
    return components.weekOfYear;
}

- (NSDate *)dateFormatterOnlyYYYYMMDD
{
    NSCalendar *currentCalendar = [[self class] currentCalendar];
    NSDateComponents *dateComponents =
        [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                           fromDate:self];
    NSString *dateString = [NSString stringWithFormat:@"%zd-%zd-%zd", dateComponents.year,
                                     dateComponents.month, dateComponents.day];
    return [dateString dateForYYYYMMDD];
}

#pragma mark - Same Day

- (BOOL)isTheSameDayAs:(NSDate *)anotherDate {
    if (anotherDate == nil) {
        return NO;
    }
    return [self isTheSameDayAs:anotherDate timeZone:[NSTimeZone defaultTimeZone]];
}

- (BOOL)isTheSameDayAs:(NSDate *)anotherDate timeZone:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = timeZone;
    NSDateComponents *components1 =
        [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                    fromDate:self];
    NSDateComponents *components2 =
        [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                    fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month]
        && [components1 day] == [components2 day]);
}

#pragma mark - Private

+ (NSDateFormatter *)utcDateFormatter
{
    static NSDateFormatter *utcDateFormatter = nil;
    if (utcDateFormatter == nil) {
        utcDateFormatter = [[NSDateFormatter alloc] init];
        utcDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        utcDateFormatter.dateFormat = kTTServerDateFormat;
    }
    return utcDateFormatter;
}

+ (NSDateFormatter *)remoteDailyRemindTimeFormatter
{
    static NSDateFormatter *remoteDailyRemindTimeFormatter = nil;
    if (remoteDailyRemindTimeFormatter == nil) {
        remoteDailyRemindTimeFormatter = [[NSDateFormatter alloc] init];
        remoteDailyRemindTimeFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        remoteDailyRemindTimeFormatter.dateFormat = kTTSettingsServerDateFormat;
    }
    return remoteDailyRemindTimeFormatter;
}

+ (NSDateFormatter *)hhmmssDateFormatter
{
    static NSDateFormatter *hhmmssDateFormatter = nil;
    if (hhmmssDateFormatter == nil) {
        hhmmssDateFormatter = [[NSDateFormatter alloc] init];
        hhmmssDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        hhmmssDateFormatter.dateFormat = @"HH:mm:ss";
    }
    return hhmmssDateFormatter;
}

+ (NSDateFormatter *)yyyyMMddDateFormatter
{
    static NSDateFormatter *yyyyMMddDateFormatter = nil;
    if (yyyyMMddDateFormatter == nil) {
        yyyyMMddDateFormatter = [[NSDateFormatter alloc] init];
        yyyyMMddDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        yyyyMMddDateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return yyyyMMddDateFormatter;
}

#pragma mark -

+ (NSDate *)dateIngoringSeconds {
    NSDateComponents *dateComponents = [[self currentCalendar] components:NSCalendarUnitYear
                                                                        | NSCalendarUnitMonth
                                                                        | NSCalendarUnitDay
                                                                        | NSCalendarUnitHour
                                                                        | NSCalendarUnitMinute
                                                                 fromDate:[NSDate date]];
    return [[[self class] currentCalendar] dateFromComponents:dateComponents];
}

+ (instancetype)nextHour {
    NSTimeInterval time = floor([[NSDate date] timeIntervalSinceReferenceDate]
                              / OneHourTimeInterval) * OneHourTimeInterval;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:time + OneHourTimeInterval];
}

+ (instancetype)startOfDayForYesterday {
    return [[[self class] startOfDayForToday] dateByAddingDay:-1];
}

+ (instancetype)startOfDayForToday {
    return [self startOfDayForDate:[NSDate date]];
}

+ (instancetype)startOfDayForTomorrow {
    return [[self startOfDayForToday] dateByAddingDay:1];
}

+ (instancetype)startOfDayForTheDayInOneWeek {
    return [[self startOfDayForToday] dateByAddingWeek:1];
}

+ (instancetype)startOfDayForTheDayInOneMonth {
    return [[self startOfDayForToday] dateByAddingMonth:1];
}

+ (instancetype)startOfDayForDate:(NSDate *)date {
    NSCalendar *currentCalendar = [self currentCalendar];
    NSDateComponents *dateComponents =
    [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                       fromDate:date];
    return [currentCalendar dateFromComponents:dateComponents];
}

+ (instancetype)endOfDayForToday {
    return [self endOfDayForDate:[NSDate date]];
}

+ (instancetype)endOfDayForTomorrow {
    return [self endOfDayForDate:[[NSDate date] dateByAddingDay:1]];
}

+ (instancetype)endOfDayForDate:(NSDate *)date {
    return [[self startOfDayForDate:date] dateByAddingTimeInterval:OneDayTimeInterval - 1];
}

#pragma mark -

- (instancetype)dateByAddingYear:(NSInteger)year {
    NSCalendar *calendar = [[self class] currentCalendar];
    NSDateComponents *addedDateComponents = [[NSDateComponents alloc] init];
    addedDateComponents.year = year;
    return [calendar dateByAddingComponents:addedDateComponents toDate:self options:0];
}

- (instancetype)dateByAddingMonth:(NSInteger)month {
    NSCalendar *calendar = [[self class] currentCalendar];
    NSDateComponents *addedDateComponents = [[NSDateComponents alloc] init];
    addedDateComponents.month = month;
    return [calendar dateByAddingComponents:addedDateComponents toDate:self options:0];
}

- (instancetype)dateByAddingWeek:(NSInteger)week {
    return [self dateByAddingTimeInterval:week * OneWeekTimeInterval];
}

- (instancetype)dateByAddingDay:(NSInteger)day {
    return [self dateByAddingTimeInterval:day * OneDayTimeInterval];
}

- (instancetype)dateByAddingHour:(NSInteger)hour {
    return [self dateByAddingTimeInterval:hour * OneHourTimeInterval];
}

- (instancetype)dateByAddingMinute:(NSInteger)minute {
    return [self dateByAddingTimeInterval:minute * OneMinuteTimeInterval];
}

- (instancetype)dateByAddingSecond:(NSInteger)second {
    return [self dateByAddingTimeInterval:second];
}

- (NSInteger)differenceOfDayFromNow {
    return [self differenceOfDayFrom:[NSDate date]];
}

- (NSInteger)differenceOfDayFrom:(NSDate *)fromDate {
    return [self differenceOfDayFrom:fromDate timeZone:[NSTimeZone defaultTimeZone]];
}

- (NSInteger)differenceOfDayFrom:(NSDate *)fromDate timeZone:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    calendar.timeZone = timeZone;
    
    NSCalendarUnit unitFlags =  NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    NSDateComponents *components1 = [calendar components:unitFlags fromDate:fromDate];
    fromDate = [calendar dateFromComponents:components1];
    
    NSDateComponents *components2 = [calendar components:unitFlags fromDate:self];
    NSDate *toDate = [calendar dateFromComponents:components2];
    
    NSDateComponents *components =
        [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return components.day;
}

#pragma mark -


- (BOOL)isLunarCalendarFestival
{
    NSCalendar *localeCalendar =
        [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDate *nextDay_date = [self dateByAddingDay:1];
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:nextDay_date];

    if (1 == localeComp.month && 1 == localeComp.day) {
        return YES;
    }

    localeComp = [localeCalendar components:unitFlags fromDate:self];
    NSInteger monthNum = localeComp.month;
    NSInteger dayNum = localeComp.day;

    if (monthNum == 1 && dayNum == 1) {
        return YES;
    }
    else if (monthNum == 1 && dayNum == 2) {
        return YES;
    }
    else if (monthNum == 1 && dayNum == 3) {
        return YES;
    }
    else if (monthNum == 1 && dayNum == 4) {
        return YES;
    }
    else if (monthNum == 1 && dayNum == 5) {
        return YES;
    }
    else if (monthNum == 1 && dayNum == 6) {
        return YES;
    }
    else if (monthNum == 1 && dayNum == 7) {
        return YES;
    }
    else if (monthNum == 1 && dayNum == 15) {
        return YES;
    }
    else if (monthNum == 5 && dayNum == 5) {
        return YES;
    }
    else if (monthNum == 7 && dayNum == 7) {
        return YES;
    }
    else if (monthNum == 7 && dayNum == 15) {
        return YES;
    }
    else if (monthNum == 8 && dayNum == 15) {
        return YES;
    }
    else if (monthNum == 9 && dayNum == 9) {
        return YES;
    }
    else if (monthNum == 12 && dayNum == 8) {
        return YES;
    }
    else if (monthNum == 12 && dayNum == 24) {
        return YES;
    }
    return NO;
}

- (NSString *)festivalInLunarCalendar
{
    NSArray *chineseMonths =
        [NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月",
                 @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月", nil];

    NSArray *chineseDays =
        [NSArray arrayWithObjects:@"初一", @"初二", @"初三", @"初四", @"初五", @"初六",
                 @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三",
                 @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                 @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七",
                 @"廿八", @"廿九", @"三十", nil];

    NSCalendar *localeCalendar =
        [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDate *nextDay_date = [self dateByAddingDay:1];
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:nextDay_date];

    if (1 == localeComp.month && 1 == localeComp.day) {
        return @"除夕";
    }

    localeComp = [localeCalendar components:unitFlags fromDate:self];
    NSInteger monthNum = localeComp.month;
    NSInteger dayNum = localeComp.day;

    if (monthNum == 1 && dayNum == 1) {
        return @"春节";
    }
    else if (monthNum == 1 && dayNum == 15) {
        return @"元宵";
    }
    else if (monthNum == 5 && dayNum == 5) {
        return @"端午";
    }
    else if (monthNum == 7 && dayNum == 7) {
        return @"七夕";
    }
    else if (monthNum == 7 && dayNum == 15) {
        return @"中元";
    }
    else if (monthNum == 8 && dayNum == 15) {
        return @"中秋";
    }
    else if (monthNum == 9 && dayNum == 9) {
        return @"重阳";
    }
    else if (monthNum == 12 && dayNum == 8) {
        return @"腊八";
    }
    else if (monthNum == 12 && dayNum == 24) {
        return @"小年";
    }
    else if (dayNum == 1) {
        return chineseMonths[monthNum - 1];
    }
    return chineseDays[dayNum - 1];
}

- (NSString *)displayDayInLunarCalendar
{
    NSArray *chineseMonths =
        [NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月",
                 @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月", nil];

    NSArray *chineseDays =
        [NSArray arrayWithObjects:@"初一", @"初二", @"初三", @"初四", @"初五", @"初六",
                 @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三",
                 @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                 @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七",
                 @"廿八", @"廿九", @"最后一天", nil];

    NSCalendar *lunarCalendar =
        [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDateComponents *dateComponents = [lunarCalendar components:unitFlags fromDate:self];
    NSInteger monthNum = dateComponents.month;
    NSInteger dayNum = dateComponents.day;

    return
        [NSString stringWithFormat:@"%@%@", chineseMonths[monthNum - 1], chineseDays[dayNum - 1]];
}

- (NSString *)displayDayInLunarCalendarHasLastDay
{
    NSArray *chineseMonths =
        [NSArray arrayWithObjects:@"正月", @"二月", @"三月", @"四月", @"五月", @"六月",
                 @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月", nil];

    NSArray *chineseDays =
        [NSArray arrayWithObjects:@"初一", @"初二", @"初三", @"初四", @"初五", @"初六",
                 @"初七", @"初八", @"初九", @"初十", @"十一", @"十二", @"十三",
                 @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                 @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七",
                 @"廿八", @"廿九", @"三十", nil];

    NSCalendar *localeCalendar =
        [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;

    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    NSInteger monthNum = localeComp.month;
    NSInteger dayNum = localeComp.day;

    return
        [NSString stringWithFormat:@"%@%@", chineseMonths[monthNum - 1], chineseDays[dayNum - 1]];
}

@end
