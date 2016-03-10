//
//  NSMutableDictionary+Setter.h
//  Appest
//
//  Created by 猪登登 on 14-7-30.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Setter)

- (void)setBool:(BOOL)aBool forKey:(id<NSCopying>)key;

- (void)setDate:(NSDate *)aDate forKey:(id<NSCopying>)key;

- (void)setString:(NSString *)aString forKey:(id<NSCopying>)key;
- (void)setMutableString:(NSMutableString *)aMutableString forKey:(id<NSCopying>)key;

- (void)setSet:(NSSet *)aSet forKey:(id<NSCopying>)key;
- (void)setMutableSet:(NSMutableSet *)aMutableSet forKey:(id<NSCopying>)key;

- (void)setArray:(NSArray *)anArray forKey:(id<NSCopying>)key;
- (void)setMutableArray:(NSMutableArray *)aMutalbeArray forKey:(id<NSCopying>)key;

- (void)setDictionary:(NSDictionary *)aDictionary forKey:(id<NSCopying>)key;
- (void)setMutableDictionary:(NSMutableDictionary *)aMutableDictionary forKey:(NSString *)key;

- (void)setNumber:(NSNumber *)aNumber forKey:(id<NSCopying>)key;
- (void)setInteger:(NSInteger)anInteger forKey:(id<NSCopying>)key;
- (void)setUnsignedInteger:(NSUInteger)anUnsignedInteger forKey:(id<NSCopying>)key;
- (void)setShort:(short)aShort forKey:(id<NSCopying>)key;
- (void)setLong:(short)aLong forKey:(id<NSCopying>)key;
- (void)setLongLong:(short)aLongLong forKey:(id<NSCopying>)key;

- (void)setData:(NSData *)data forKey:(id<NSCopying>)key;

@end
