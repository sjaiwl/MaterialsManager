//
//  TTUtils.m
//  TickTick
//
//  Created by ChenChao on 9/29/14.
//  Copyright (c) 2014 Appest. All rights reserved.
//

#import "TTUtils.h"

@implementation TTUtils

BOOL TTObjectIsEqualToObject(id obj1, id obj2)
{
    if ([obj1 isEqual:@""]) {
        obj1 = nil;
    }
    if ([obj2 isEqual:@""]) {
        obj2 = nil;
    }
    if (obj1 == nil) {
        return obj2 == nil;
    }
    else {
        return [obj1 isEqual:obj2];
    }
}

BOOL TTObjectIsDifferentFromObject(id obj1, id obj2)
{
    return !TTObjectIsEqualToObject(obj1, obj2);
}

BOOL TTObjectIsNilOrNull(id obj)
{
    if (obj == nil || obj == [NSNull null]) {
        return YES;
    }
    return NO;
}

@end
