//
//  MMAConfig.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/9.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

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

//window
#define CURRENT_WINDOW [[[UIApplication sharedApplication] delegate] window]

// Screen bounds
#define IPHONE_SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define IPHONE_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define LEFT_CONTAINER_VIEW_WIDTH (TARGET_DEVICE_IPHONE ? (IPHONE_SCREEN_WIDTH - 44) : 320)

@interface MMAConfig : NSObject

@end
