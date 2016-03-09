//
//  MMAAccountManager.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMAAccountManager : NSObject

+ (instancetype)sharedManager;

//sign in
- (void)doSignIn;
//sign out
- (void)doSignOut;
@end
