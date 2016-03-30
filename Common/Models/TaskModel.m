//
//  TaskModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/10.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "TaskModel.h"
@implementation TaskModel

#pragma mark - Override
- (void)initializeDefaultPropertyValues{
    [super initializeDefaultPropertyValues];
    if (!self.tid) {
        self.tid = @(0);
    }
    if (!self.hmmsStaffid) {
        self.hmmsStaffid = @(0);
    }
    if (!self.hmmsStaffByTassignsid) {
        self.hmmsStaffByTassignsid = @(0);
    }
    if (!self.hmmsSpecialid) {
        self.hmmsSpecialid = @(0);
    }
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *dict = [super JSONKeyPathsByPropertyKey].mutableCopy;
    [dict addEntriesFromDictionary:
     @{
       @"tid" : @"tid",
       @"hmmsStaffid" : @"hmmsStaffid",
       @"hmmsStaffName" : @"hmmsStaffName",
       @"hmmsStaffByTassignsid" : @"hmmsStaffByTassignsid",
       @"hmmsStaffByTassignsName" : @"hmmsStaffByTassignsName",
       @"hmmsSpecialid" : @"hmmsSpecialid",
       @"hmmsSpecialName" : @"hmmsSpecialName",
       @"ttype" : @"ttype",
       @"toriginaltime" : @"toriginaltime",
       @"tinspectionbegintime" : @"tinspectionbegintime",
       @"tinspectionendtime" : @"tinspectionendtime",
       @"tmodifiedtime" : @"tmodifiedtime",
       @"tstatus" : @"tstatus"
       }];
    return dict;
}

#pragma mark - Transfer
+ (MTLValueTransformer *)toriginaltimeJSONTransformer
{
    return [[self class] dateTransformer];
}

+ (MTLValueTransformer *)tinspectionbegintimeJSONTransformer
{
    return [[self class] dateTransformer];
}

+ (MTLValueTransformer *)tinspectionendtimeJSONTransformer
{
    return [[self class] dateTransformer];
}

+ (MTLValueTransformer *)tmodifiedtimeJSONTransformer
{
    return [[self class] dateTransformer];
}

@end
