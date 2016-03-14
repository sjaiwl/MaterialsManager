//
//  UINavigationBar+Utils.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Utils)

- (void)setTitleTextColor_MMA:(UIColor *) textColor_MMA;
- (UIColor *)titleTextColor_MMA;

- (void)setBackgroundColor_MMA:(UIColor *)backgroundColor_MMA;
- (UIColor *)backgroundColor_MMA;

+ (void)initGlobalStyle;
+ (void)updateGlobalStyle;
@end
