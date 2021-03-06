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

#pragma mark - Task List
- (void)getTodayInspectionTaskListWithSiteUrl:(NSString *)siteUrl
                                      success:(TTHTTPRequestSuccessCompletionHandler)success
                                      failure:(TTHTTPRequestFailureCompletionHandler)failure;

#pragma mark - MainTain List
- (void)getMainTainListWithSiteUrl:(NSString *)siteUrl
                                      success:(TTHTTPRequestSuccessCompletionHandler)success
                                      failure:(TTHTTPRequestFailureCompletionHandler)failure;

#pragma mark - AllWorktype List
- (void)getAllWorkTypeListWithSiteUrl:(NSString *)siteUrl
                           success:(TTHTTPRequestSuccessCompletionHandler)success
                           failure:(TTHTTPRequestFailureCompletionHandler)failure;

#pragma mark - AllWorktype List
- (void)getWorkTypeStaffListWithSiteUrl:(NSString *)siteUrl
                               workType:(NSNumber *) wid
                              success:(TTHTTPRequestSuccessCompletionHandler)success
                              failure:(TTHTTPRequestFailureCompletionHandler)failure;

#pragma mark - update staff
- (void)updateStaffWithSiteUrl:(NSString *)siteUrl
                 mid:(NSNumber *)mid
                 sid:(NSNumber *)sid
                  success:(TTHTTPRequestSuccessCompletionHandler)success
                  failure:(TTHTTPRequestFailureCompletionHandler)failure;
@end
