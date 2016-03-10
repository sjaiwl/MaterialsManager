//
//  NSDictionary+Getter.h
//  Appest
//
//  Created by 猪登登 on 14-7-30.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Getter)

- (BOOL)boolForKey:(id)key;

- (NSDate *)dateForKey:(id)key;

- (NSString *)stringForKey:(id)key;
- (NSMutableString *)mutableStringForKey:(id)key;

- (NSSet *)setForKey:(id)key;
- (NSMutableSet *)mutableSetForKey:(NSString *)key;

- (NSArray *)arrayForKey:(id)key;
- (NSMutableArray *)mutableArrayForKey:(id)key;

- (NSDictionary *)dictionaryForKey:(id)key;
- (NSMutableDictionary *)mutableDictionaryForKey:(id)key;

- (NSNumber *)numberForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (NSUInteger)unsignedIntegerForKey:(id)key;
- (short)shortForKey:(id)key;
- (long)longForKey:(id)key;
- (long long)longLongForKey:(id)key;
- (float)floatForKey:(id)key;
- (double)doubleForKey:(id)key;

- (NSData *)dataForKey:(id)key;

@end
