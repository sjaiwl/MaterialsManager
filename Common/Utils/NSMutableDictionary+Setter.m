//
//  NSMutableDictionary+Setter.m
//  Appest
//
//  Created by 猪登登 on 14-7-30.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import "NSMutableDictionary+Setter.h"
#import "TTUtils.h"

@implementation NSMutableDictionary (Setter)

#pragma mark - Public

- (void)setBool:(BOOL)aBool forKey:(id<NSCopying>)key
{
    [self setObject:@(aBool) forKey:key];
}

- (void)setDate:(NSDate *)aDate forKey:(id<NSCopying>)key
{
    if ([self checkValue:aDate key:key]) {
        [self setObject:aDate forKey:key];
    }
}

- (void)setString:(NSString *)aString forKey:(id<NSCopying>)key
{
    if ([self checkValue:aString key:key]) {
        [self setObject:aString forKey:key];
    }
}

- (void)setMutableString:(NSMutableString *)aMutableString forKey:(id<NSCopying>)key
{
    if ([self checkValue:aMutableString key:key]) {
        [self setObject:aMutableString forKey:key];
    }
}

- (void)setSet:(NSSet *)aSet forKey:(id<NSCopying>)key
{
    if ([self checkValue:aSet key:key]) {
        [self setObject:aSet forKey:key];
    }
}

- (void)setMutableSet:(NSMutableSet *)aMutableSet forKey:(id<NSCopying>)key
{
    if ([self checkValue:aMutableSet key:key]) {
        [self setObject:aMutableSet forKey:key];
    }
}

- (void)setArray:(NSArray *)anArray forKey:(id<NSCopying>)key
{
    if ([self checkValue:anArray key:key]) {
        [self setObject:anArray forKey:key];
    }
}

- (void)setMutableArray:(NSMutableArray *)aMutalbeArray forKey:(id<NSCopying>)key
{
    if ([self checkValue:aMutalbeArray key:key]) {
        [self setObject:aMutalbeArray forKey:key];
    }
}

- (void)setDictionary:(NSDictionary *)aDictionary forKey:(id<NSCopying>)key
{
    if ([self checkValue:aDictionary key:key]) {
        [self setObject:aDictionary forKey:key];
    }
}

- (void)setMutableDictionary:(NSMutableDictionary *)aMutableDictionary forKey:(id<NSCopying>)key
{
    if ([self checkValue:aMutableDictionary key:key]) {
        [self setObject:aMutableDictionary forKey:key];
    }
}

#pragma mark - Number

- (void)setNumber:(NSNumber *)aNumber forKey:(id<NSCopying>)key
{
    if ([self checkValue:aNumber key:key]) {
        [self setObject:aNumber forKey:key];
    }
}

- (void)setInteger:(NSInteger)anInteger forKey:(id<NSCopying>)key
{
    [self setObject:@(anInteger) forKey:key];
}

- (void)setUnsignedInteger:(NSUInteger)anUnsignedInteger forKey:(id<NSCopying>)key
{
    [self setObject:@(anUnsignedInteger) forKey:key];
}

- (void)setShort:(short)aShort forKey:(id<NSCopying>)key
{
    [self setObject:@(aShort) forKey:key];
}

- (void)setLong:(short)aLong forKey:(id<NSCopying>)key
{
    [self setObject:@(aLong) forKey:key];
}

- (void)setLongLong:(short)aLongLong forKey:(id<NSCopying>)key
{
    [self setObject:@(aLongLong) forKey:key];
}

#pragma mark -

- (void)setData:(NSData *)data forKey:(id<NSCopying>)key
{
    if ([self checkValue:data key:key]) {
        [self setObject:data forKey:key];
    }
}


#pragma mark - Private

- (BOOL)checkValue:(id)value key:(id)key
{
    return !TTObjectIsNilOrNull(value) && !TTObjectIsNilOrNull(key);
}

@end
