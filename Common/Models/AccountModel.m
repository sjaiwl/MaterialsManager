//
//  AccountModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/10.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

#pragma mark - Override
- (void)initializeDefaultPropertyValues{
    [super initializeDefaultPropertyValues];
    if (!self.sid) {
        self.sid = @(0);
    }
}

#pragma mark - MTLJSONSerializing
+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    NSMutableDictionary *dict = [super JSONKeyPathsByPropertyKey].mutableCopy;

    [dict addEntriesFromDictionary:
     @{
       @"sid" : @"sid",
       @"sname" : @"sname",
       @"ssex" : @"ssex",
       @"saccount" : @"saccount",
       @"spassword" : @"spassword",
       @"stype" : @"stype",
       @"sinductiontime" : @"sinductiontime",
       @"sbirth" : @"sbirth",
       @"sstatus" : @"sstatus"
       }];
    return dict;
}

#pragma mark - Transfer
+ (MTLValueTransformer *)sinductiontimeJSONTransformer
{
    return [[self class] dateTransformer];
}

+ (MTLValueTransformer *)sbirthJSONTransformer
{
    return [[self class] dateTransformer];
}

@end
