//
//  NSDictionary+JSONSerialization.m
//  TickTick
//
//  Created by 猪登登 on 15/2/6.
//  Copyright (c) 2015年 Appest Limited. All rights reserved.
//

#import "NSDictionary+JSONSerialization.h"
#import "MMALogs.h"

@implementation NSDictionary (JSONSerialization)

- (NSString *)jSONSerializedString {
  NSError *error = nil;
  NSData *data =
      [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
  if (error) {
    ELog(error);
    return nil;
  }
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
