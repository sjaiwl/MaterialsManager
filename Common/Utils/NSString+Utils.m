//
//  NSString+Utils.m
//  Appest
//
//  Created by wind on 6/30/14.
//  Copyright (c) 2014 com.TickTIck. All rights reserved.
//

#import "NSString+Utils.h"
#import "MMALogs.h"
#import "MMAConstants.h"
#import "TTDateUtils.h"

static CGFloat const DEFAULT_LINE_SPACING = 0;
static CGFloat const DEFAULT_LINE_BREAK_MODE = NSLineBreakByWordWrapping;

@implementation NSString (Utils)

#pragma mark - Utils

+ (BOOL)isEmpty:(NSString *)str
{
    return !str || str == (id)[NSNull null] || str.length == 0;
}

+ (BOOL)isEmptyAfterRemovingSpacesAndLineBreaks:(NSString *)str
{
    return [[self class] isEmpty:str.stringByRemovingSpacesAndLineBreaks];
}

+ (BOOL)isEmptyAfterTrimmingSpacesAndLineBreaks:(NSString *)str
{
    return [[self class] isEmpty:str.stringByTrimmingSpacesAndLineBreaks];
}

- (BOOL)tt_containsStringSensitively:(NSString *)aString
{
    return [self containsString:aString];
}

- (BOOL)tt_containsStringInsensitively:(NSString *)aString
{
    aString = aString.uppercaseString;
    return [self.uppercaseString containsString:aString];
}

- (instancetype)stringByRemovingSpacesAndLineBreaks
{
    NSString *tempStr = self;
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    tempStr = [tempStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    tempStr =
        [tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return tempStr;
}

- (instancetype)stringByTrimmingSpacesAndLineBreaks
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark - Format

- (BOOL)isEmailFormat {
    return
        [self matchesPattern:@"\\w+([-+.]\\w+)*@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$"];
}

- (BOOL)containsSpecialCharacter {
    return [self matchesPattern:@"[\\\\/\"#:*?<>|]"];
}

- (BOOL)isDefaultAvatarURL
{
    return [self matchesPattern:@"https://www\\.dida365\\.com/static/img/avatar.*\\.png"];
}

- (BOOL)matchesPattern:(NSString *)pattern
{
    NSError *error = nil;
    NSRegularExpression *regex =
        [NSRegularExpression regularExpressionWithPattern:pattern
                                                  options:NSRegularExpressionCaseInsensitive
                                                    error:&error];
    if (error) {
        ELog(error);
    }

    NSUInteger numberOfMatches =
        [regex numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)];
    return numberOfMatches > 0;
}

#pragma mark -

- (CGFloat)widthWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self widthWithFont:font constrainedToSize:size lineBreakMode:DEFAULT_LINE_BREAK_MODE];
}

- (CGFloat)widthWithFont:(UIFont *)font
       constrainedToSize:(CGSize)size
           lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode].width;
}

- (CGFloat)heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self heightWithFont:font constrainedToSize:size lineBreakMode:DEFAULT_LINE_BREAK_MODE];
}

- (CGFloat)heightWithFont:(UIFont *)font
        constrainedToSize:(CGSize)size
            lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode].height;
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    return [self sizeWithFont:font constrainedToSize:size lineSpacing:DEFAULT_LINE_SPACING];
}

- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
         lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    return [self sizeWithFont:font
            constrainedToSize:size
                  lineSpacing:DEFAULT_LINE_SPACING
                lineBreakMode:lineBreakMode];
}

- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
           lineSpacing:(CGFloat)lineSpacing
{
    return [self sizeWithFont:font
            constrainedToSize:size
                  lineSpacing:lineSpacing
                lineBreakMode:DEFAULT_LINE_BREAK_MODE];
}

- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
           lineSpacing:(CGFloat)lineSpacing
         lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize expectedLabelSize = CGSizeZero;

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    paragraphStyle.lineBreakMode = lineBreakMode;

    NSDictionary *attributes =
        @{NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle};

    expectedLabelSize = [self boundingRectWithSize:size
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil].size;
    return CGSizeMake(ceil(expectedLabelSize.width) + 1, ceil(expectedLabelSize.height) + 1);
}

#pragma mark - Encode & Decode

- (NSString *)base64EncodeString
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodeString
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - Conversion

- (NSArray *)arrayFromJsonEncodedString
{
    NSError *error = nil;
    NSArray *array =
        [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                        options:NSJSONReadingAllowFragments
                                          error:&error];
    if (error) {
        ELog(error);
        return nil;
    }
    return array;
}

- (NSDictionary *)dictionaryFromJsonEncodedString
{
    NSError *error = nil;
    NSDictionary *dict =
        [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                        options:NSJSONReadingAllowFragments
                                          error:&error];
    if (error) {
        ELog(error);
        return nil;
    }
    return dict;
}

- (NSDate *)dateFromUTCFormatedString
{
    if ([NSString isEmpty:self]) {
        return nil;
    }

    NSDate *date = [[[self class] utcDateFormatter] dateFromString:self];
    if (date == nil) {
        return [[[self class] utcDateFormatter_new] dateFromString:self];
    }
    return date;
}

- (NSDate *)dailyReminderDateFormUTCFormateString
{
    if ([NSString isEmpty:self]) {
        return nil;
    }

    NSDate *date = [[[self class] remoteDailyRemindTimeFormatter] dateFromString:self];
    return date;
}

- (NSDate *)dateForYYYYMMDDHHMMSS
{
    if ([NSString isEmpty:self]) {
        return nil;
    }

    NSDate *date = [[[self class] yyyyMMddHHmmssDateFormatter] dateFromString:self];
    return date;
}

- (NSDate *)dateForYYYYMMDD
{
    if ([NSString isEmpty:self]) {
        return nil;
    }

    NSDate *date = [[[self class] yyyyMMddDateFormatter] dateFromString:self];
    return date;
}

- (NSDate *)dateForYYYYMMDDWithTimeZone
{
    // 日期拖动排序的日期字符串样式为: 20150225
    NSString *yearString = [self substringToIndex:4];
    NSString *monthString = [self substringWithRange:NSMakeRange(4, 2)];
    NSString *dayString = [self substringWithRange:NSMakeRange(6, 2)];

    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents =
        [currentCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
                           fromDate:[NSDate date]];
    dateComponents.year = [yearString integerValue];
    dateComponents.month = [monthString integerValue];
    dateComponents.day = [dayString integerValue];
    return [currentCalendar dateFromComponents:dateComponents];
}

#pragma mark - Private

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

+ (NSDateFormatter *)utcDateFormatter_new
{
    static NSDateFormatter *utcDateFormatter_new = nil;
    if (utcDateFormatter_new == nil) {
        utcDateFormatter_new = [[NSDateFormatter alloc] init];
        utcDateFormatter_new.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        utcDateFormatter_new.dateFormat = kTTNewServerDateFormat;
    }
    return utcDateFormatter_new;
}

+ (NSDateFormatter *)yyyyMMddHHmmssDateFormatter
{
    static NSDateFormatter *yyyyMMddHHmmssDateFormatter = nil;
    if (yyyyMMddHHmmssDateFormatter == nil) {
        yyyyMMddHHmmssDateFormatter = [[NSDateFormatter alloc] init];
        yyyyMMddHHmmssDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        yyyyMMddHHmmssDateFormatter.dateFormat = yyyy_MM_dd_HH_mm_ss;
    }
    return yyyyMMddHHmmssDateFormatter;
}

+ (NSDateFormatter *)yyyyMMddDateFormatter
{
    static NSDateFormatter *yyyyMMddDateFormatter = nil;
    if (yyyyMMddDateFormatter == nil) {
        yyyyMMddDateFormatter = [[NSDateFormatter alloc] init];
        yyyyMMddDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        yyyyMMddDateFormatter.dateFormat = yyyy_MM_dd;
    }
    return yyyyMMddDateFormatter;
}

- (BOOL)isAValidCalendarSubscriptionURL
{
    if ([self matchesPattern:@"^webcal://.*"]) {
        return YES;
    }
    if ([self matchesPattern:@"^http://.*"]) {
        return YES;
    }
    if ([self matchesPattern:@"^https://.*"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isConformYYYYMMDDTHHMMSS
{
    if ([self matchesPattern:@"^\\d{8}T\\d{6}$"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isConformYYYYMMDDTHHMMSSZ
{
    if ([self matchesPattern:@"^\\d{8}T\\d{6}Z$"]) {
        return YES;
    }
    return NO;
}

@end
