//
//  TKJSONSerializedModel.h
//  TickTick
//
//  Created by 猪登登 on 15/2/9.
//  Copyright (c) 2015年 Appest Limited. All rights reserved.
//

#import "Mantle.h"

@interface TKJSONSerializedModel : MTLModel <MTLJSONSerializing>

- (void)initializeDefaultPropertyValues;

+ (instancetype)createModelWithJSONDictionary:(NSDictionary *)JSONDictionary;

+ (NSArray *)createModelsWithJSONArray:(NSArray *)JSONArray;

- (NSDictionary *)JSONDictionary;

- (NSString *)JSONSerializedString;

+ (MTLValueTransformer *)dateTransformer;

@end
