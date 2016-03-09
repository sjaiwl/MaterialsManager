//
//  UIImage+Utils.m
//  Appest
//
//  Created by 猪登登 on 14-8-25.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)dotImageWithColor:(UIColor *)color radius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, radius * 2, radius * 2);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextRef, color.CGColor);
    CGContextFillEllipseInRect(contextRef, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)circleImageWithColor:(UIColor *)color radius:(CGFloat)radius width:(CGFloat)width {
    CGRect rect = CGRectMake(0, 0, radius * 2, radius * 2);
    CGRect circleRect = CGRectMake(width / 2, width / 2, radius * 2 - width, radius * 2 - width);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(contextRef, width);
    CGContextSetStrokeColorWithColor(contextRef, color.CGColor);
    CGContextSetFillColorWithColor(contextRef, [UIColor whiteColor].CGColor);
    CGContextFillEllipseInRect(contextRef, rect);
    CGContextStrokeEllipseInRect(contextRef, circleRect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)imageByScalingForSize:(CGSize)size {
    CGSize originSize = self.size;
    CGFloat originWidth = originSize.width;
    CGFloat originHeight = originSize.height;

    CGSize targetSize = size;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;

    CGFloat scaledWidth = originWidth;
    CGFloat scaledHeight = originHeight;
    CGFloat scaleFactor = 1.0f;

    if (originWidth <= targetWidth && originHeight <= targetHeight) {
        return self;
    }

    if (CGSizeEqualToSize(originSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / originWidth;
        CGFloat heightFactor = targetHeight / originHeight;

        if (widthFactor < heightFactor) {
            scaleFactor = widthFactor; // scale to fit height
        }
        else {
            scaleFactor = heightFactor; // scale to fit width
        }
    }
    scaledWidth *= scaleFactor;
    scaledHeight *= scaleFactor;

    UIGraphicsBeginImageContext(CGSizeMake(scaledWidth, scaledHeight));
    [self drawInRect:CGRectMake(0.0f, 0.0f, scaledWidth, scaledHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0f, 0.0f);
    if (height <= targetHeight && width <= targetWidth) {
        return self;
    }

    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;

        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;

        // center the image
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.2;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }

    UIGraphicsBeginImageContext(targetSize); // this will crop

    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [sourceImage drawInRect:thumbnailRect];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

+ (UIImage *)originalImageNamed:(NSString *)name {
    return [UIImage imageNamed:name].originalImage;
}

+ (UIImage *)templateImageNamed:(NSString *)name {
    return [UIImage imageNamed:name].templateImage;
}

- (UIImage *)originalImage {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)templateImage {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

@end
