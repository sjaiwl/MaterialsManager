//
//  UserSettingViewModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "UserSettingViewModel.h"
#import "MMAConstants.h"
#import "UserSettingModel.h"

@implementation UserSettingViewModel

+ (instancetype)sharedViewModel{
    static UserSettingViewModel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

//current user setting info
- (NSDictionary *)getCurrentUserSettingInfo{
    return @{
             @(SettingSectionInfoAccount) : @[[UserSettingModel settingAccount]],
             @(SettingSectionInfoNotification) : @[[UserSettingModel settingNotification] ],
             @(SettingSectionInfoAbout) : @[[UserSettingModel settingAboutBack] ,[UserSettingModel settingAboutApp]],
             @(SettingSectionInfoCache) : @[[UserSettingModel settingCache]],
             @(SettingSectionInfoSignOut) : @[[UserSettingModel settingSignOut]],
             }.copy;
}
@end
