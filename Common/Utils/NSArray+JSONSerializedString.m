//
//  NSArray+JSONSerializedString.m
//  TickTick
//
//  Created by 猪登登 on 15/2/6.
//  Copyright (c) 2015年 Appest Limited. All rights reserved.
//

#import "NSArray+JSONSerializedString.h"
#import "MMALogs.h"

@implementation NSArray (JSONSerializedString)

- (NSString *)jSONSerializedString {
  NSError *error = nil;
  NSData *data =
      [NSJSONSerialization dataWithJSONObject:self
                                      options:NSJSONWritingPrettyPrinted
                                        error:&error];
    
  if (error) {
    ELog(error);
    return nil;
  }
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
