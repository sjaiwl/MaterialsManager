//
//  UIButton+Utils.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "UIButton+Utils.h"

@implementation UIButton (Utils)

- (void)setCornerRadius_MMA:(CGFloat)cornerRadius_MMA{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius_MMA;
}

- (CGFloat)cornerRadius_MMA{
    return self.layer.cornerRadius;
}

@end
