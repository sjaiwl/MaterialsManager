//
//  UIColor+Hex.h
//  TickTick
//
//  Created by 猪登登 on 15/3/17.
//  Copyright (c) 2015年 Appest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)

//+ (instancetype)colorWithHex:(unsigned int)hex;
//+ (instancetype)colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

+ (instancetype)colorWithHexString:(NSString *)hexString;
+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
