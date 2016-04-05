//
//  WorkTypeModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/4/2.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "WorkTypeModel.h"

@implementation WorkTypeModel

#pragma mark - Override
- (void)initializeDefaultPropertyValues{
    [super initializeDefaultPropertyValues];
    if (!self.wid) {
        self.wid = @(0);
    }
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *dict = [super JSONKeyPathsByPropertyKey].mutableCopy;
    [dict addEntriesFromDictionary:
     @{
       @"wid" : @"wid",
       @"wname" : @"wname",
       @"wdescribe" : @"wdescribe",
       }];
    return dict;
}

@end
