//
//  MainTainListViewModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MainTainListViewModel.h"
#import "MainTainModel.h"
#import "MMALogs.h"
#import "MMAHTTPManager.h"
#import "MMAConstants.h"

@interface MainTainListViewModel ()

@property (nonatomic, strong) MMAHTTPManager* httpManager;

@end

@implementation MainTainListViewModel

+ (instancetype)sharedViewModel{
    static MainTainListViewModel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

//httpmanager
- (MMAHTTPManager *)httpManager{
    if (!_httpManager) {
        _httpManager = [MMAHTTPManager sharedManager];
    }
    return _httpManager;
}

//get current modele
- (void)getCurrentMainTainModelsWithType: (NSInteger)type
                                 success:(TTResultBlockWithArray)success

                                 failure:(TTResultAndErrorBlock) failure{
    NSString *siteUrl = nil;
    if (type == 0) {
        siteUrl = TodayDoneMainTainListUrl;
    }else{
        siteUrl = NotDoneMainTainListUrl;
    }
    [self.httpManager getMainTainListWithSiteUrl:siteUrl success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        NSNumber *codeSign = responseObject[@"code"];
        if (codeSign.integerValue == 0) {
            NSArray *result = [MainTainModel createModelsWithJSONArray:responseObject[@"data"]];
            if (success) {
                success(YES, result);
            }
        } else {
            if (success) {
                success(YES, [NSArray new]);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@",error);
        failure(NO, error);
    }];
}

@end
