//
//  UIView+Utils.m
//  Appest
//
//  Created by 猪登登 on 14-8-28.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

+ (instancetype)loadNib {
    UIView *view = nil;
    @try {
        view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                             owner:self
                                           options:nil].firstObject;
        return view;
    }
    @catch (NSException *exception) {
    }
}

- (void)setCornerRadius_MMA:(CGFloat)cornerRadius_MMA{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius_MMA;
}

- (CGFloat)cornerRadius_MMA{
    return self.layer.cornerRadius;
}

@end
