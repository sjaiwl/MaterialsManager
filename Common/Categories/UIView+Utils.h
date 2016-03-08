//
//  UIView+Utils.h
//  Appest
//
//  Created by 猪登登 on 14-8-28.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

+ (instancetype)loadNib;

- (void)setCornerRadius_MMA:(CGFloat)cornerRadius_MMA;
- (CGFloat)cornerRadius_MMA;
@end
