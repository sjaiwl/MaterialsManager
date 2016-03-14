//
//  MMAHTTPManager.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/9.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^TTHTTPRequestSuccessCompletionHandler)(
                                                      AFHTTPRequestOperation *operation, id responseObject);
typedef void (^TTHTTPRequestFailureCompletionHandler)(
                                                      AFHTTPRequestOperation *operation, NSError *error);

typedef void (^TTHTTPDownloadCompletionHandler)(BOOL successfully, NSURL *fileURL);

@interface MMAHTTPManager : NSObject

+ (instancetype)sharedManager;

#pragma mark - Sign In
- (void)signInWithSiteUrl:(NSString *)siteUrl
                    username:(NSString *)username
                    password:(NSString *)password
                     type:(NSString *)type
                     success:(TTHTTPRequestSuccessCompletionHandler)success
                     failure:(TTHTTPRequestFailureCompletionHandler)failure;
@end
