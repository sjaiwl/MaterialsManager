//
//  ArrangeModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/10.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "ArrangeModel.h"

@implementation ArrangeModel
#pragma mark - Override
- (void)initializeDefaultPropertyValues{
    [super initializeDefaultPropertyValues];
    if (!self.aid) {
        self.aid = @(0);
    }
    if (!self.gid) {
        self.gid = @(0);
    }
    if (!self.sid) {
        self.sid = @(0);
    }
    if (!self.aoperatorid) {
        self.aoperatorid = @(0);
    }
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *dict = [super JSONKeyPathsByPropertyKey].mutableCopy;
    [dict addEntriesFromDictionary:
     @{
       @"aid" : @"aid",
       @"gid" : @"gid",
       @"sid" : @"sid",
       @"abegintime" : @"abegintime",
       @"aendtime" : @"aendtime",
       @"astatus" : @"astatus",
       @"aoperatorid" : @"aoperatorid",
       @"amodifiedtime" : @"amodifiedtime"
       }];
    return dict;
}

#pragma mark - Transfer
+ (MTLValueTransformer *)abegintimeJSONTransformer
{
    return [[self class] dateTransformer];
}

+ (MTLValueTransformer *)aendtimeJSONTransformer
{
    return [[self class] dateTransformer];
}

+ (MTLValueTransformer *)amodifiedtimeJSONTransformer
{
    return [[self class] dateTransformer];
}

@end
