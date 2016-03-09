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
#define MMA_BLACK(a)    [UIColor colorWithHexString:@"000000" alpha:a]

#define MMA_RED_LIGHT [UIColor colorWithHexString:@"ca0814"]
#define MMA_RED(a) [UIColor colorWithHexString:@"ff0000" alpha:a]

@interface MMAColors : NSObject

@end
