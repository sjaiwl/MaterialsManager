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
                     success:(TTHTTPRequestSuccessCompletionHandler)success
                     failure:(TTHTTPRequestFailureCompletionHandler)failure{
    [self postForURLString:siteUrl
                needsToken:NO
                parameters:@{@"saccount" : username,@"spassword" : password}
                   success:success failure:failure];
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
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型 
    [[self customHTTPHeadersIfNeedsToken:needsToken]
     enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
         [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
     }];
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
