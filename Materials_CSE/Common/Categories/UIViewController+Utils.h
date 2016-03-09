//
//  UIViewController+Utils.h
//  Appest
//
//  Created by 猪登登 on 14-8-25.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utils)

/**
 *  用于改变箭头颜色
 */
@property (strong, nonatomic) UIPopoverController *popoverController;

+ (instancetype)loadNib;

+ (instancetype)loadFromStoryboard;

- (UIViewController *)topMostViewController;

- (BOOL)isJustBeingPushed;
- (BOOL)isJustBeingPopped;
- (BOOL)isJustBeingPresented;
- (BOOL)isJustBeingDismissed;

@end
