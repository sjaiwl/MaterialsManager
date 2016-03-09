//
//  UIColor+Hex.m
//  TickTick
//
//  Created by 猪登登 on 15/3/17.
//  Copyright (c) 2015年 Appest. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

#pragma mark - Public

+ (instancetype)colorWithHex:(unsigned int)hex
{
    return [self colorWithHex:hex alpha:1];
}

+ (instancetype)colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hex & 0x00FF00) >> 8)) / 255.0
                            blue:((float)((hex & 0x0000FF) >> 0)) / 255.0
                           alpha:alpha];
}

+ (instancetype)colorWithHexString:(NSString *)hexString
{
    return [[self class] colorWithHexString:hexString alpha:1.0];
}

+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha
{
    if (!hexString) {
        return [UIColor clearColor];
    }
    // 特殊处理"transparent"这个色值, Web端会设置成这个值
    if ([hexString containsString:@"transparent"]) {
        return [UIColor clearColor];
    }
    
    // Check for hash and add the missing hash
    if ('#' != [hexString characterAtIndex:0]) {
        hexString = [NSString stringWithFormat:@"#%@", hexString];
    }
    // 特殊处理色值不到7位的, 不太确定是哪一端怎么生成的这么个颜色
    if (hexString.length < 7) {
        return [UIColor clearColor];
    }
    
    // check for 3 character HexStrings
    hexString = [[self class] hexStringTransformFromThreeCharacters:hexString];

    NSString *redHex =
        [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(1, 2)]];
    unsigned redInt = [[self class] hexValueToUnsigned:redHex];

    NSString *greenHex =
        [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(3, 2)]];
    unsigned greenInt = [[self class] hexValueToUnsigned:greenHex];

    NSString *blueHex =
        [NSString stringWithFormat:@"0x%@", [hexString substringWithRange:NSMakeRange(5, 2)]];
    unsigned blueInt = [[self class] hexValueToUnsigned:blueHex];

    UIColor *color = [UIColor colorWith8BitRed:redInt green:greenInt blue:blueInt alpha:alpha];

    return color;
}

#pragma mark - Private

+ (UIColor *)colorWith8BitRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue
{
    return [[self class] colorWith8BitRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)colorWith8BitRed:(NSInteger)red
                        green:(NSInteger)green
                         blue:(NSInteger)blue
                        alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:(float)red / 255
                           green:(float)green / 255
                            blue:(float)blue / 255
                           alpha:alpha];
}

+ (NSString *)hexStringTransformFromThreeCharacters:(NSString *)hexString
{
    if (hexString.length == 4) {
        hexString = [NSString stringWithFormat:@"#%@%@%@%@%@%@",
                              [hexString substringWithRange:NSMakeRange(1, 1)],
                              [hexString substringWithRange:NSMakeRange(1, 1)],
                              [hexString substringWithRange:NSMakeRange(2, 1)],
                              [hexString substringWithRange:NSMakeRange(2, 1)],
                              [hexString substringWithRange:NSMakeRange(3, 1)],
                              [hexString substringWithRange:NSMakeRange(3, 1)]];
    }

    return hexString;
}

+ (unsigned)hexValueToUnsigned:(NSString *)hexValue
{
    unsigned value = 0;

    NSScanner *hexValueScanner = [NSScanner scannerWithString:hexValue];
    [hexValueScanner scanHexInt:&value];

    return value;
}

@end
