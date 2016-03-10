//
//  NSDictionary+Getter.m
//  Appest
//
//  Created by 猪登登 on 14-7-30.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import "NSDictionary+Getter.h"

@implementation NSDictionary (Getter)

#pragma mark - Public

- (BOOL)boolForKey:(id)key
{
    id object = [self notNullObjectForKey:key];
    return object ? [self[key] boolValue] : NO;
}

- (NSString *)stringForKey:(id)key
{
    return (NSString *)[self notNullObjectForKey:key];
}

- (NSMutableString *)mutableStringForKey:(id)key
{
    return (NSMutableString *)[self notNullObjectForKey:key];
}

- (NSDate *)dateForKey:(id)key
{
    return (NSDate *)[self notNullObjectForKey:key];
}

- (NSSet *)setForKey:(id)key
{
    return (NSSet *)[self notNullObjectForKey:key];
}

- (NSMutableSet *)mutableSetForKey:(id)key
{
    return (NSMutableSet *)[self notNullObjectForKey:key];
}

- (NSArray *)arrayForKey:(id)key
{
    return (NSArray *)[self notNullObjectForKey:key];
}

- (NSMutableArray *)mutableArrayForKey:(id)key
{
    return (NSMutableArray *)[self notNullObjectForKey:key];
}

- (NSDictionary *)dictionaryForKey:(id)key
{
    return (NSDictionary *)[self notNullObjectForKey:key];
}

- (NSMutableDictionary *)mutableDictionaryForKey:(id)key
{
    return (NSMutableDictionary *)[self notNullObjectForKey:key];
}

#pragma mark - Number

- (NSNumber *)numberForKey:(id)key
{
    return (NSNumber *)[self notNullObjectForKey:key];
}

- (NSInteger)integerForKey:(id)key
{
    return [[self numberForKey:key] integerValue];
}

- (NSUInteger)unsignedIntegerForKey:(id)key
{
    return [[self numberForKey:key] unsignedIntegerValue];
}

- (short)shortForKey:(id)key
{
    return [[self numberForKey:key] shortValue];
}

- (long)longForKey:(id)key
{
    return [[self numberForKey:key] longValue];
}

- (long long)longLongForKey:(id)key
{
    return [[self numberForKey:key] longLongValue];
}

- (float)floatForKey:(id)key
{
    return [[self numberForKey:key] floatValue];
}

- (double)doubleForKey:(id)key
{
    return [[self numberForKey:key] doubleValue];
}

#pragma mark - 

- (NSData *)dataForKey:(id)key
{
    return (NSData *)[self notNullObjectForKey:key];
}

#pragma mark - Private

- (id)notNullObjectForKey:(id)key
{
    id object = [self objectForKey:key];
    if (object == (id)[NSNull null]) {
        return nil;
    }
    return object;
}

@end
