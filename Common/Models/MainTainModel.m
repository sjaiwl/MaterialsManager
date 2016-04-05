//
//  MainTainModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MainTainModel.h"

@implementation MainTainModel

- (void)initializeDefaultPropertyValues{
    [super initializeDefaultPropertyValues];
    if (!self.wid) {
        self.wid = 0;
    }
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *dict = [super JSONKeyPathsByPropertyKey].mutableCopy;
    [dict addEntriesFromDictionary:
     @{
       @"mid" : @"mid",
       @"tdid" : @"tdid",
       @"sid" : @"sid",
       @"wid" : @"wid",
       @"sname" : @"sname",
       @"mrepairtime" : @"mrepairtime",
       @"mmaintaintime" : @"mmaintaintime",
       @"mstatus" : @"mstatus",
       @"tderroritems" : @"tderroritems",
       @"tderrordescribe" : @"tderrordescribe",
       @"pposition" : @"pposition"
       }];
    return dict;
}

#pragma mark - Transfer
+ (MTLValueTransformer *)mrepairtimeJSONTransformer
{
    return [[self class] dateTransformer];
}

+ (MTLValueTransformer *)mmaintaintimeJSONTransformer
{
    return [[self class] dateTransformer];
}

@end
