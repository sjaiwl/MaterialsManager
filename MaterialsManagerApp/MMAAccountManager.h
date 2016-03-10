//
//  MMAAccountManager.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMAEnum.h"
@class AccountModel;

typedef void (^MMASignInCompletionHandler)(MMASignInResult result);

@interface MMAAccountManager : NSObject

+ (instancetype)sharedManager;
//login
- (void)signInWithSiteUrl:(NSString *)siteUtl
             AccountModel:(AccountModel *)accountModel
             completionHandler:(MMASignInCompletionHandler)completionHandler;
//sign in
- (void)doSignIn;
//sign out
- (void)doSignOut;
@end
