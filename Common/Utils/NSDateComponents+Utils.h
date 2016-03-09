//
//  NSDateComponents+Utils.h
//  TickTick
//
//  Created by 猪登登 on 15/4/7.
//  Copyright (c) 2015年 Appest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateComponents (Utils)

- (NSDate *)dateFromCurrentCalendar;
- (NSDate *)dateFromCalendar:(NSCalendar *)calendar;

@end
