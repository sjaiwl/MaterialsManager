//
//  MMAPreferenceManager.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kMMAUserNameDefaultsKey;
extern NSString *const kMMAUserPasswordDefaultsKey;
extern NSString *const kMMARememberPasswordDefaultsKey;

@interface MMAPreferenceManager : NSObject

+ (instancetype)sharedManager;

- (void)setUserDefaultsForUserName:(NSString *)userName;
- (void)setUserDefaultsForUserPassword:(NSString *)userPassword;
- (void)setUserDefaultsForRememberPassword:(BOOL)rememberPassword;

- (NSString *)getUserDefaultsForUserName;
- (NSString *)getUserDefaultsForUserPassword;
- (BOOL)getUserDefaultsForRememberPassword;
@end
