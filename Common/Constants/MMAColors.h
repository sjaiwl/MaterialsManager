//
//  MMAColors.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+Hex.h"


#define MMA_BLUE_LIGHT [UIColor colorWithHexString:@"97bef1"]
#define MMA_BLUE(a)    [UIColor colorWithHexString:@"0000ff" alpha:a]

#define MMA_BLACK_LIGHT [UIColor colorWithHexString:@"6b6d70"]
#define MMA_BLACK(a)    [UIColor colorWithHexString:@"292933" alpha:a]
#define MMA_BLACK_DARK [UIColor colorWithHexString:@"25252d"]

#define MMA_RED_LIGHT [UIColor colorWithHexString:@"ca0814"]
#define MMA_RED(a) [UIColor colorWithHexString:@"ff0000" alpha:a]

#define MMA_GRAY_LIGHT [UIColor colorWithHexString:@"f3f3f3"]
#define MMA_GRAY_CENTER [UIColor colorWithHexString:@"848487"]
#define MMA_GRAY(a) [UIColor colorWithHexString:@"212226" alpha:a]

#define MMA_GRAY_LEFT_VIEW(a) [UIColor colorWithHexString:@"75757e" alpha:a]

#define MMA_GREEN_LIGHT [UIColor colorWithHexString:@"829a9e"]
#define MMA_GREEN(a) [UIColor colorWithHexString:@"2fcdb3" alpha:a]

#define MMA_WHITE(a) [UIColor colorWithHexString:@"ffffff" alpha:a]

#define MMA_PLACEHOLDER_COLOR [UIColor colorWithHexString:@"9aadb2"]

#define MMA_GRADIENT_COLOR_STARE(a) [UIColor colorWithHexString:@"01111e" alpha:a]
#define MMA_GRADIENT_COLOR_CENTER(a) [UIColor colorWithHexString:@"1c4957" alpha:a]
#define MMA_GRADIENT_COLOR_END(a) [UIColor colorWithHexString:@"9b8f64" alpha:a]

@interface MMAColors : NSObject

@end
