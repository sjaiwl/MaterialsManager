//
//  TTStringUtils.m
//  GNotes
//
//  Created by chenchao on 12-8-6.
//  Copyright (c) 2012年 Appest. All rights reserved.
//

#import "TTStringUtils.h"

@implementation TTStringUtils

#pragma mark - UUID

+ (NSString *)generate32UUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil); // create a new UUID
    // get the string representation of the UUID
    CFStringRef cfString = CFUUIDCreateString(nil, uuidObj);
    NSString *uuidString = (__bridge NSString *)cfString;
    CFRelease(uuidObj);
    NSString *uuid32 = [uuidString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(cfString);
    NSString *lowUUID32 = [uuid32 lowercaseString];
    return lowUUID32;
}

@end
