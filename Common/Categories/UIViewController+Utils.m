//
//  UIViewController+Utils.m
//  Appest
//
//  Created by 猪登登 on 14-8-25.
//  Copyright (c) 2014年 Appest. All rights reserved.
//

#import "UIViewController+Utils.h"
#import <objc/runtime.h>
#import "MMALogs.h"

@implementation UIViewController (Utils)

#pragma mark - Accessors

- (UIPopoverController *)popoverController {
    return objc_getAssociatedObject(self, @selector(popoverController));
}

- (void)setPopoverController:(UIPopoverController *)popoverController {
    objc_setAssociatedObject(self,
                             @selector(popoverController),
                             popoverController,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public

+ (instancetype)loadNib {
    id viewController = nil;
    @try {
        viewController =
            [[[self class] alloc] initWithNibName:NSStringFromClass([self class]) bundle:nil];
    }
    @catch (NSException *exception) {
        DLog(@"%@", exception);
    }
    @finally {
        return viewController;
    }
}

+ (instancetype)loadFromStoryboard {
    return [[self class] loadFromStoryboardWithIdentifier:NSStringFromClass([self class])];
}

+ (instancetype)loadFromStoryboardWithIdentifier:(NSString *)identifier {
    
    static UIStoryboard *_mainStoryboard = nil;
    if (!_mainStoryboard) {
        _mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    }
    
    id viewController = nil;
    @try {
        viewController = [_mainStoryboard instantiateViewControllerWithIdentifier:identifier];
    }
    @catch (NSException *exception) {
        DLog(@"%@", exception);
    }
    @finally {
        return viewController;
    }
}

#pragma mark - Public

- (UIViewController *)topMostViewController {
    return
        [self topMostViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (BOOL)isJustBeingPushed {
    return self.isMovingToParentViewController;
}

- (BOOL)isJustBeingPopped {
    return self.isMovingFromParentViewController;
}

- (BOOL)isJustBeingPresented {
    if (!self.navigationController) {
        return self.isBeingPresented;
    }
    return self.navigationController.isBeingPresented;
}

- (BOOL)isJustBeingDismissed {
    if (!self.navigationController) {
        return self.isBeingDismissed;
    }
    return self.navigationController.isBeingDismissed;
}

#pragma mark - Private

- (UIViewController *)topMostViewController:(UIViewController *)rootViewController {
    if (!rootViewController.presentedViewController) {
        return rootViewController;
    }
    if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController
            = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topMostViewController:lastViewController];
    }
    UIViewController *presentedViewController
        = (UIViewController *)rootViewController.presentedViewController;
    return [self topMostViewController:presentedViewController];
}

@end
