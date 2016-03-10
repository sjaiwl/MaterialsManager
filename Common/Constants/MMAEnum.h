//
//  MMAEnum.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/9.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

//user section info
typedef NS_ENUM(NSInteger, SettingSectionInfo) {
    SettingSectionInfoAccount,
    SettingSectionInfoNotification,
    SettingSectionInfoAbout,
    SettingSectionInfoCache,
    SettingSectionInfoSignOut,
};

typedef NS_ENUM(NSUInteger, TTWeekday) {
    TTWeekdaySunday = 1,
    TTWeekdayMonday = 2,
    TTWeekdayTuesday = 3,
    TTWeekdayWednesday = 4,
    TTWeekdayThursday = 5,
    TTWeekdayFriday = 6,
    TTWeekdaySaturday = 7
};

typedef NS_ENUM(NSUInteger, MMASignInResult) {
    MMASignInResultSuccess = 0,
    MMASignInResultWrongUsername = 1,
    MMASignInResultWrongPassword = 2,
    MMASignInResultOldClientVersion = 3,
    MMASignInResultOtherError = 4
};

@interface MMAEnum : NSObject

@end
