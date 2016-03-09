//
//  NSString+Time.m
//  TickTick
//
//  Created by 猪登登 on 14/12/19.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import "NSString+Time.h"
#import "TTDateUtils.h"

@implementation NSString (Time)

+ (NSString *)stringOfTimeDuration:(NSTimeInterval)seconds {
    if (seconds < OneMinuteTimeInterval) {
        return [NSString stringWithFormat:@"%.2zd:%.2zd", 0, (NSInteger)seconds];
    } else if (seconds < OneHourTimeInterval) {
        NSInteger minutes = (NSInteger)seconds / (NSInteger)OneMinuteTimeInterval;
        seconds -= minutes * (NSInteger)OneMinuteTimeInterval;
        return [NSString stringWithFormat:@"%.2zd:%.2zd", minutes, (NSInteger)seconds];
    } else {
        NSInteger hours = (NSInteger)seconds / (NSInteger)OneHourTimeInterval;
        NSInteger minutes = ((NSInteger)seconds - hours * (NSInteger)OneHourTimeInterval)
            / OneMinuteTimeInterval;
        seconds -=
            hours * (NSInteger)OneHourTimeInterval + minutes * (NSInteger)OneMinuteTimeInterval;
        return [NSString stringWithFormat:@"%.2zd:%.2zd:%.2zd", hours, minutes, (NSInteger)seconds];
    }
}

@end
