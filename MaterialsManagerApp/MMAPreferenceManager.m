//
//  MMAPreferenceManager.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MMAPreferenceManager.h"
#define STANDARD_USER_DEFAULTS [NSUserDefaults standardUserDefaults]

NSString *const kMMAUserNameDefaultsKey = @"kMMAUserNameDefaultsKey";
NSString *const kMMAUserPasswordDefaultsKey = @"kMMAUserPasswordDefaultsKey";
NSString *const kMMARememberPasswordDefaultsKey = @"kMMARememberPasswordDefaultsKey";

@implementation MMAPreferenceManager

+ (instancetype)sharedManager {
    static MMAPreferenceManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void)setUserDefaultsForUserName:(NSString *)userName{
    [STANDARD_USER_DEFAULTS setValue:userName forKey:kMMAUserNameDefaultsKey];
}
- (void)setUserDefaultsForUserPassword:(NSString *)userPassword{
    [STANDARD_USER_DEFAULTS setValue:userPassword forKey:kMMAUserPasswordDefaultsKey];
}

- (void)setUserDefaultsForRememberPassword:(BOOL)rememberPassword{
    [STANDARD_USER_DEFAULTS setBool:rememberPassword forKey:kMMARememberPasswordDefaultsKey];
}

- (NSString *)getUserDefaultsForUserName{
    return [STANDARD_USER_DEFAULTS valueForKey:kMMAUserNameDefaultsKey];
}
- (NSString *)getUserDefaultsForUserPassword{
    return [STANDARD_USER_DEFAULTS valueForKey:kMMAUserPasswordDefaultsKey];
}
- (BOOL)getUserDefaultsForRememberPassword{
    return [STANDARD_USER_DEFAULTS boolForKey:kMMARememberPasswordDefaultsKey];
}
@end
