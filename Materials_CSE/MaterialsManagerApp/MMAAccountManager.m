//
//  MMAAccountManager.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MMAAccountManager.h"
#import "MMAConstants.h"

@implementation MMAAccountManager

#pragma mark - Singleton

+ (instancetype)sharedManager {
    static MMAAccountManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

//sign in
- (void)doSignIn{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMMAAccountDidSignInNotification object:nil];
}
//sign out
- (void)doSignOut{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMMAAccountDidSignOutNotification object:nil];
}
@end
