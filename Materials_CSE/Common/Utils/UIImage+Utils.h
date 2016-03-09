//
//  UIImage+Utils.h
//  Appest
//
//  Created by 猪登登 on 14-8-25.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)dotImageWithColor:(UIColor *)color radius:(CGFloat)radius;
+ (UIImage *)circleImageWithColor:(UIColor *)color radius:(CGFloat)radius width:(CGFloat)width;

- (UIImage *)imageByScalingForSize:(CGSize)size;
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

+ (UIImage *)originalImageNamed:(NSString *)name;
+ (UIImage *)templateImageNamed:(NSString *)name;

- (UIImage *)originalImage;
- (UIImage *)templateImage;

@end
