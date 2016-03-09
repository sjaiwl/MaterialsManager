//
//  NSString+Utils.h
//  Appest
//
//  Created by wind on 6/30/14.
//  Copyright (c) 2014 com.TickTIck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Utils)

+ (BOOL)isEmpty:(NSString *)str;
+ (BOOL)isEmptyAfterRemovingSpacesAndLineBreaks:(NSString *)str;
+ (BOOL)isEmptyAfterTrimmingSpacesAndLineBreaks:(NSString *)str;

// 大小写敏感
- (BOOL)tt_containsStringSensitively:(NSString *)aString;

// 大小写不敏感
- (BOOL)tt_containsStringInsensitively:(NSString *)aString;

- (instancetype)stringByRemovingSpacesAndLineBreaks;
- (instancetype)stringByTrimmingSpacesAndLineBreaks;

- (BOOL)isEmailFormat;
- (BOOL)containsSpecialCharacter;

- (BOOL)isDefaultAvatarURL;

- (CGFloat)widthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)widthWithFont:(UIFont *)font
       constrainedToSize:(CGSize)size
           lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)heightWithFont:(UIFont *)font
        constrainedToSize:(CGSize)size
            lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
         lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
           lineSpacing:(CGFloat)lineSpacing;

- (instancetype)base64EncodeString;
- (instancetype)base64DecodeString;

- (NSArray *)arrayFromJsonEncodedString;

- (NSDictionary *)dictionaryFromJsonEncodedString;
- (NSDate *)dateFromUTCFormatedString;

- (NSDate *)dailyReminderDateFormUTCFormateString;

// 用于判断日历订阅时输入的url是否合法
- (BOOL)isAValidCalendarSubscriptionURL;

// 用于判断订阅的日历的event的时间格式
- (BOOL)isConformYYYYMMDDTHHMMSS;
- (BOOL)isConformYYYYMMDDTHHMMSSZ;

- (NSDate *)dateForYYYYMMDDHHMMSS;
- (NSDate *)dateForYYYYMMDD;

// 任务列表按日期排序下, 把日期字符串转成Date
- (NSDate *)dateForYYYYMMDDWithTimeZone;

@end
