//
//  UINavigationBar+Utils.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "UINavigationBar+Utils.h"

@implementation UINavigationBar (Utils)

- (void)setTitleTextColor_MMA:(UIColor *) textColor_MMA{
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
- (UIColor *)titleTextColor_MMA{
    return self.titleTextAttributes[NSForegroundColorAttributeName];
}

- (void)setBackgroundColor_MMA:(UIColor *)backgroundColor_MMA{
    self.barTintColor = backgroundColor_MMA;
}
- (UIColor *)backgroundColor_MMA{
    return self.barTintColor;
}

@end
