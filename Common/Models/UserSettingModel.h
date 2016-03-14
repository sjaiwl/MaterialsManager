//
//  UserSettingModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSettingModel : NSObject

@property (nonatomic, assign) NSInteger sectionIndex;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *name;

+ (instancetype)settingAccount;
+ (instancetype)settingNotification;
+ (instancetype)settingAboutBack;
+ (instancetype)settingAboutApp;
+ (instancetype)settingCache;
+ (instancetype)settingSignOut;

+ (instancetype)leftViewAccount;
+ (instancetype)leftViewTask;
+ (instancetype)leftViewSetting;
+ (instancetype)leftViewAbout;

@end
