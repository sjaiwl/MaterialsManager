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
- (instancetype)initWithSectionIndex:(NSInteger) sectionIndex name:(NSString *)name imageName:(NSString *)imageName{
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

- (instancetype)initWithName:(NSString *) name imageName:(NSString *)imageName{
    if (self = [super init]) {
        _sectionIndex = 0;
        _imageName = imageName;
        _name = name;
    }
    return self;
}

//setting info
+ (instancetype)settingAccount{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoAccount name:USER_SETTING_SECTION_ACCOUNT imageName:TABLE_VIEW_IMAGE_ACCOUNT];
}
+ (instancetype)settingNotification{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoNotification name:USER_SETTING_SECTION_NOTIFICATION imageName:TABLE_VIEW_IMAGE_NOTIFICATION];
}
+ (instancetype)settingAboutBack{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoAbout name:USER_SETTING_SECTION_ABOUT_BACK imageName:TABLE_VIEW_IMAGE_FEEDBACK];
}
+ (instancetype)settingAboutApp{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoAbout name:USER_SETTING_SECTION_ABOUT_APP imageName:TABLE_VIEW_IMAGE_ABOUT];
}
+ (instancetype)settingCache{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoCache name:USER_SETTING_SECTION_CACHE imageName:TABLE_VIEW_IMAGE_CLEARCACHE];
}
+ (instancetype)settingSignOut{
    return [[self alloc] initWithSectionIndex:SettingSectionInfoSignOut name:USER_SETTING_SECTION_SIGNOUT];
}


+ (instancetype)leftViewAccount{
    return [[self alloc] initWithName:LEFT_VIEW_ACCOUNT imageName:TABLE_VIEW_IMAGE_ACCOUNT];
}
+ (instancetype)leftViewTask{
    return [[self alloc] initWithName:LEFT_VIEW_TASK imageName:TABLE_VIEW_IMAGE_TASK];
}
+ (instancetype)leftViewSetting{
    return [[self alloc] initWithName:LEFT_VIEW_SETTING imageName:TABLE_VIEW_IMAGE_SETTING];
}
+ (instancetype)leftViewAbout{
    return [[self alloc] initWithName:LEFT_VIEW_ABOUT imageName:TABLE_VIEW_IMAGE_ABOUT];
}

@end
