//
//  UINavigationBar+Utils.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "UINavigationBar+Utils.h"
#import "UIImage+Utils.h"
#import "MMAColors.h"

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

#pragma mark - Public

+ (void)initGlobalStyle {
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];

    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

    [UINavigationBar appearance].backIndicatorImage =
    [UINavigationBar appearance].backIndicatorTransitionMaskImage =
    [UIImage templateImageNamed:@"nav_bar_back_icon_white"];

    [[UINavigationBar appearance] setBarTintColor:MMA_BLACK(1)];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // hide title of back button
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];

    NSShadow *clearShadow = [[NSShadow alloc] init];
    clearShadow.shadowColor = [UIColor clearColor];
    clearShadow.shadowOffset = CGSizeMake(0, 0);

    UIColor *normalTitleColor = [UIColor whiteColor];
    UIColor *highlightedTitleColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : normalTitleColor,
                                                           NSShadowAttributeName : clearShadow
                                                           } forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName : highlightedTitleColor,
                                                           NSShadowAttributeName : clearShadow
                                                           } forState:UIControlStateHighlighted];
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    [[UIToolbar appearance] setBarTintColor:[UIColor whiteColor]];

//    [self updateGlobalStyle];
}

+ (void)updateGlobalStyle {
    UIImage *bgImg = [UIImage imageWithColor:MMA_BLACK(1)];
    [[UINavigationBar appearance] setBackgroundImage:bgImg forBarMetrics:UIBarMetricsDefault];

    [[UIToolbar appearance] setTintColor:MMA_BLACK(1)];
}

@end
