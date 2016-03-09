//
//  UserSettingModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "UserSettingModel.h"
#import "MMAConstants.h"
#import "MMAEnum.h"

@implementation UserSettingModel

//init
- (instancetype)initWithSectionIndex:(NSInteger) sectionIndex imageName:(NSString *)imageName name:(NSString *)name{
    if (self = [super init]) {
        _sectionIndex = sectionIndex;
        _imageName = imageName;
        _name = name;
    }
    return self;
}
- (instancetype)initWithSectionIndex:(NSInteger) sectionIndex name:(NSString *)name{
    if (self = [super init]) {
        _sectionIndex = sectionIndex;
        _imageName = nil;
        _name = name;
    }
    return self;
}

+ (instancetype)settingAccount{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoAccount name:USER_SETTING_SECTION_ACCOUNT];
}
+ (instancetype)settingNotification{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoNotification name:USER_SETTING_SECTION_NOTIFICATION];
}
+ (instancetype)settingAboutBack{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoAbout name:USER_SETTING_SECTION_ABOUT_BACK];
}
+ (instancetype)settingAboutApp{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoAbout name:USER_SETTING_SECTION_ABOUT_APP];
}
+ (instancetype)settingCache{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoCache name:USER_SETTING_SECTION_CACHE];
}
+ (instancetype)settingSignOut{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoSignOut name:USER_SETTING_SECTION_SIGNOUT];
}

@end
