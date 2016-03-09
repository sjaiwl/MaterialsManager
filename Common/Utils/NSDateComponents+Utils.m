//
//  NSDateComponents+Utils.m
//  TickTick
//
//  Created by 猪登登 on 15/4/7.
//  Copyright (c) 2015年 Appest. All rights reserved.
//

#import "NSDateComponents+Utils.h"

@implementation NSDateComponents (Utils)

#pragma mark - Public

- (NSDate *)dateFromCurrentCalendar {
    return [self dateFromCalendar:[[self class] currentCalendar]];
}

#pragma mark - Private

- (NSDate *)dateFromCalendar:(NSCalendar *)calendar {
    return [calendar dateFromComponents:self];
}

+ (NSCalendar *)currentCalendar
{
    static NSCalendar *CurrentCalendar = nil;
    if (!CurrentCalendar) {
        CurrentCalendar = [NSCalendar currentCalendar];
    }
    return CurrentCalendar;
}

@end
