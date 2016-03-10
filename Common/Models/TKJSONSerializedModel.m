//
//  TKJSONSerializedModel.m
//  TickTick
//
//  Created by 猪登登 on 15/2/9.
//  Copyright (c) 2015年 Appest Limited. All rights reserved.
//

#import "TKJSONSerializedModel.h"
#import "MMALogs.h"
#import "MMAUtils.h"

@implementation TKJSONSerializedModel

#pragma mark - Override

- (instancetype)initWithDictionary:(NSDictionary *)dictionaryValue
                             error:(NSError *__autoreleasing *)error
{
    self = [super initWithDictionary:dictionaryValue error:error];
    if (self) {
        [self initializeDefaultPropertyValues];
    }
    return self;
}

- (void)initializeDefaultPropertyValues
{
    // to be implemented by subclass
}

#pragma mark - JSON <-> Model

#pragma mark - Public

+ (instancetype)createModelWithJSONDictionary:(NSDictionary *)JSONDictionary
{
    NSError *error = nil;
    TKJSONSerializedModel *model =
        [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:JSONDictionary error:&error];
    if (error) {
        ELog(error);
    }
    return model;
}

+ (NSArray *)createModelsWithJSONArray:(NSArray *)JSONArray
{
    NSError *error = nil;
    NSArray *models =
        [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:JSONArray error:&error];
    if (error) {
        ELog(error);
    }
    return models;
}

- (NSDictionary *)JSONDictionary
{
    NSError *error = nil;
    NSDictionary *dictionary = [MTLJSONAdapter JSONDictionaryFromModel:self error:&error];
    if (error) {
        ELog(error);
    }
    return dictionary;
}

- (NSString *)JSONSerializedString
{
    return self.JSONDictionary.jSONSerializedString;
}

+ (MTLValueTransformer *)dateTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString * value, BOOL *success, NSError *__autoreleasing *error) {
        return value.dateFromUTCFormatedString;
    } reverseBlock:^id(NSDate* value, BOOL *success, NSError *__autoreleasing *error) {
        return value.stringFromUTCDate;
    }];
}

#pragma mark - MTLJSONSerializing

// required

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{};
}

@end
