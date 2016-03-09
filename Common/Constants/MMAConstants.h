//
//  MMAConstants.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

//category item id
#define COLLECTION_ITEM_APPEND_ID(x) [@"MMA_" stringByAppendingString:x]
#define RELEASE_ITEM_ID COLLECTION_ITEM_APPEND_ID(@"RELEASE_ITEM_ID")
#define CHECK_ITEM_ID COLLECTION_ITEM_APPEND_ID(@"CHECK_ITEM_ID")
#define UPLOAD_ITEM_ID COLLECTION_ITEM_APPEND_ID(@"UPLOAD_ITEM_ID")
#define RECORD_ITEM_ID COLLECTION_ITEM_APPEND_ID(@"RECORD_ITEM_ID")
#define ASSET_ITEM_ID COLLECTION_ITEM_APPEND_ID(@"ASSET_ITEM_ID")
#define TRANSFER_ITEM_ID COLLECTION_ITEM_APPEND_ID(@"TRANSFER_ITEM_ID")
//category item name
#define RELEASE_ITEM_NAME @"任务下达"
#define CHECK_ITEM_NAME @"盘点任务"
#define UPLOAD_ITEM_NAME @"任务上传"
#define RECORD_ITEM_NAME @"盘点历史"
#define ASSET_ITEM_NAME @"模糊资产"
#define TRANSFER_ITEM_NAME @"资产调拨"

//category item imagename
#define RELEASE_ITEM_IMAGE_NAME @"materials_list_release"
#define CHECK_ITEM_IMAGE_NAME @"materials_list_check"
#define UPLOAD_ITEM_IMAGE_NAME @"materials_list_upload"
#define RECORD_ITEM_IMAGE_NAME @"materials_list_record"
#define ASSET_ITEM_IMAGE_NAME @"materials_list_asset"
#define TRANSFER_ITEM_IMAGE_NAME @"materials_list_transfer"

//user setting name
#define USER_SETTING_SECTION_ACCOUNT @"个人信息"
#define USER_SETTING_SECTION_NOTIFICATION @"通知提醒"
#define USER_SETTING_SECTION_ABOUT_BACK @"意见反馈"
#define USER_SETTING_SECTION_ABOUT_APP @"关于软件"
#define USER_SETTING_SECTION_CACHE @"清除缓存"
#define USER_SETTING_SECTION_SIGNOUT @"退出登录"

extern NSString *const kMMAAccountDidSignInNotification;
extern NSString *const kMMAAccountDidSignOutNotification;
extern NSString *const kMMANavigationControllerDidDismissedNotification;

extern NSString *const kTTSettingsServerDateFormat;
extern NSString *const kTTServerDateFormat;
extern NSString *const kTTNewServerDateFormat;

@interface MMAConstants : NSObject

@end
