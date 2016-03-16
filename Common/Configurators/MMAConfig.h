//
//  MMAConfig.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/9.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

//device
#if TARGET_OS_IOS

#import <UIKit/UIKit.h>
#define TTDevice UIDevice

#define TARGET_DEVICE_IPHONE (UIUserInterfaceIdiomPhone == UI_USER_INTERFACE_IDIOM())
#define TARGET_DEVICE_IPAD (UIUserInterfaceIdiomPad == UI_USER_INTERFACE_IDIOM())

#elif TARGET_OS_WATCH

#import <WatchKit/WatchKit.h>
#define TTDevice WKInterfaceDevice

#define TARGET_DEVICE_IPHONE NO
#define TARGET_DEVICE_IPAD NO

#endif

#define SYSTEM_VERSION_EQUAL_TO(v)                                                                 \
([[[TTDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)                                                             \
([[[TTDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)                                                 \
([[[TTDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                                                                \
([[TTDevice currentDevice].systemVersion compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)                                                    \
([[[TTDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SYSTEM_VERSION_IOS_9_0_AND_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")

// Orientation

#define CURRENT_STATUS_BAR_ORIENTATION ([[UIApplication sharedApplication] statusBarOrientation])
#define CURRENT_INTERFACE_ORIENTATION_IS_PORTRAIT                                                  \
UIInterfaceOrientationIsPortrait(CURRENT_STATUS_BAR_ORIENTATION)
#define CURRENT_INTERFACE_ORIENTATION_IS_LANDSCAPE                                                 \
UIInterfaceOrientationIsLandscape(CURRENT_STATUS_BAR_ORIENTATION)

#define INTERFACE_ORIENTATION_IS_PORTRAIT(interfaceOrientation)                                    \
(UIInterfaceOrientationPortrait == interfaceOrientation                                        \
|| UIInterfaceOrientationPortraitUpsideDown == interfaceOrientation)
#define INTERFACE_ORIENTATION_IS_LANDSCAPE(interfaceOrientation)                                   \
(UIInterfaceOrientationLandscapeLeft == interfaceOrientation                                   \
|| UIInterfaceOrientationLandscapeRight == interfaceOrientation)

// Screen bounds
#define IPHONE_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHONE_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define PORTRAIT_SCREEN_WIDTH (TARGET_DEVICE_IPHONE ? IPHONE_SCREEN_WIDTH : 768)
#define PORTRAIT_SCREEN_HEIGHT (TARGET_DEVICE_IPHONE ? IPHONE_SCREEN_HEIGHT : 1024)

#define LANDSCAPE_SCREEN_WIDTH (TARGET_DEVICE_IPHONE ? IPHONE_SCREEN_HEIGHT : 1024)
#define LANDSCAPE_SCREEN_HEIGHT (TARGET_DEVICE_IPHONE ? IPHONE_SCREEN_WIDTH : 768)

#define CURRENT_SCREEN_WIDTH                                                                       \
(CURRENT_INTERFACE_ORIENTATION_IS_PORTRAIT ? PORTRAIT_SCREEN_WIDTH : LANDSCAPE_SCREEN_WIDTH)

#define SCREEN_WIDTH(interfaceOrientation)                                                         \
(INTERFACE_ORIENTATION_IS_PORTRAIT(interfaceOrientation) ? PORTRAIT_SCREEN_WIDTH               \
: LANDSCAPE_SCREEN_WIDTH)

#define CURRENT_SCREEN_HEIGHT                                                                      \
(CURRENT_INTERFACE_ORIENTATION_IS_PORTRAIT ? PORTRAIT_SCREEN_HEIGHT : LANDSCAPE_SCREEN_HEIGHT)
#define SCREEN_HEIGHT(interfaceOrientation)                                                        \
(INTERFACE_ORIENTATION_IS_PORTRAIT(interfaceOrientation) ? PORTRAIT_SCREEN_HEIGHT              \
: LANDSCAPE_SCREEN_HEIGHT)

#define CURRENT_WINDOW [[[UIApplication sharedApplication] delegate] window]

#define CURRENT_WINDOW_WIDTH                                                                       \
((SYSTEM_VERSION_IOS_9_0_AND_LATER && TARGET_DEVICE_IPAD)                                      \
? CGRectGetWidth([AppDelegate getInstance].window.bounds)                                          \
: CURRENT_SCREEN_WIDTH)

#define LEFT_CONTAINER_VIEW_WIDTH (TARGET_DEVICE_IPHONE ? (IPHONE_SCREEN_WIDTH - 44) : 320)

@interface MMAConfig : NSObject

@end
