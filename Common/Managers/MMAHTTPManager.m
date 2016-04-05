//
//  MMAHTTPManager.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/9.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MMAHTTPManager.h"

@implementation MMAHTTPManager
#pragma mark - Public
+ (instancetype)sharedManager{
    static MMAHTTPManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - Sign In
- (void)signInWithSiteUrl:(NSString *)siteUrl
                    username:(NSString *)username
                    password:(NSString *)password
                     type:(NSString *)type
                     success:(TTHTTPRequestSuccessCompletionHandler)success
                     failure:(TTHTTPRequestFailureCompletionHandler)failure{
    [self postForURLString:siteUrl
                needsToken:NO
                parameters:@{@"account" : username, @"password" : password, @"type" : type}
                   success:success failure:failure];
}

#pragma mark - Task List
- (void)getTodayInspectionTaskListWithSiteUrl:(NSString *)siteUrl
                                      success:(TTHTTPRequestSuccessCompletionHandler)success
                                      failure:(TTHTTPRequestFailureCompletionHandler)failure{
    [self getForURLString:siteUrl
               needsToken:NO
                  success:success
                  failure:failure];
}

#pragma mark - MainTain List
- (void)getMainTainListWithSiteUrl:(NSString *)siteUrl
                           success:(TTHTTPRequestSuccessCompletionHandler)success
                           failure:(TTHTTPRequestFailureCompletionHandler)failure{
    [self getForURLString:siteUrl
               needsToken:NO
                  success:success
                  failure:failure];
}

#pragma mark - AllWorktype List
- (void)getAllWorkTypeListWithSiteUrl:(NSString *)siteUrl
                              success:(TTHTTPRequestSuccessCompletionHandler)success
                              failure:(TTHTTPRequestFailureCompletionHandler)failure{
    [self getForURLString:siteUrl
               needsToken:NO
                  success:success
                  failure:failure];
}

#pragma mark - AllWorktype List
- (void)getWorkTypeStaffListWithSiteUrl:(NSString *)siteUrl
                               workType:(NSNumber *) wid
                                success:(TTHTTPRequestSuccessCompletionHandler)success
                                failure:(TTHTTPRequestFailureCompletionHandler)failure{
    [self postForURLString:siteUrl
                needsToken:NO
                parameters:@{@"wid" : wid}
                   success:success failure:failure];
}

#pragma mark - update staff
- (void)updateStaffWithSiteUrl:(NSString *)siteUrl
                           mid:(NSNumber *)mid
                           sid:(NSNumber *)sid
                       success:(TTHTTPRequestSuccessCompletionHandler)success
                       failure:(TTHTTPRequestFailureCompletionHandler)failure{
    [self postForURLString:siteUrl
                needsToken:NO
                parameters:@{@"mid" : mid, @"sid" : sid}
                   success:success
                   failure:failure];
}

#pragma mark - private method
- (NSDictionary *)customHTTPHeadersIfNeedsToken:(BOOL)needsToken
{
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    header[@"Content-Type"] = @"application/json;charset=UTF-8";
    header[@"locale"] = [NSLocale currentLocale].localeIdentifier;
    return header;
}

//http manager
- (AFHTTPRequestOperationManager *)httpRequestManagerNeedsToken:(BOOL)needsToken
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //设置相应内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
//    [[self customHTTPHeadersIfNeedsToken:needsToken]
//     enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//         [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
//     }];
    return manager;
}

#pragma mark - GET Method
- (void)getForURLString:(NSString *)urlString
             needsToken:(BOOL)needsToken
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [[self httpRequestManagerNeedsToken:needsToken] GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         [self handleSuccessWithResponse:operation.response];
        if (success) {
            success(operation, responseObject);
        }

    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self handleFailureWithResponseObject:operation.responseObject];
        if (failure) {
            failure(operation, error);
        }
    }];
}

#pragma mark - POST Method
- (void)postForURLString:(NSString *)urlString
              needsToken:(BOOL)needsToken
              parameters:(id)parameters
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [[self httpRequestManagerNeedsToken:needsToken] POST:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [self handleSuccessWithResponse:operation.response];
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self handleFailureWithResponseObject:operation.responseObject];
        if (failure) {
            failure(operation, error);
        }
    }];
}

#pragma mark - PUT Method
- (void)putForURLString:(NSString *)urlString
             needsToken:(BOOL)needsToken
             parameters:(id)parameters
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [[self httpRequestManagerNeedsToken:needsToken] PUT:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [self handleSuccessWithResponse:operation.response];
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self handleFailureWithResponseObject:operation.responseObject];
        if (failure) {
            failure(operation, error);
        }
    }];
}

#pragma mark - DELETE Method
- (void)deleteForURLString:(NSString *)urlString
                needsToken:(BOOL)needsToken
                parameters:(id)parameters
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [[self httpRequestManagerNeedsToken:needsToken] DELETE:urlString parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [self handleSuccessWithResponse:operation.response];
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [self handleFailureWithResponseObject:operation.responseObject];
        if (failure) {
            failure(operation, error);
        }
    }];
}

#pragma mark - Error Handler

- (void)handleSuccessWithResponse:(NSHTTPURLResponse *)response
{

}

- (void)handleFailureWithResponseObject:(id)responseObject
{

}
@end
