//
//  TaskListViewModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/11.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "TaskListViewModel.h"
#import "TaskModel.h"
#import "MMALogs.h"
#import "MMAHTTPManager.h"
#import "MMAConstants.h"

@interface TaskListViewModel ()

@property (nonatomic, strong) MMAHTTPManager* httpManager;

@end

@implementation TaskListViewModel

+ (instancetype)sharedViewModel{
    static TaskListViewModel *_sharedInstance = nil;
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
- (void)getCurrentTaskModelsWithSuccessCompletionHandle:(TTResultBlockWithArray)success
                                                failure:(TTResultAndErrorBlock) failure{
    [self.httpManager getTodayInspectionTaskListWithSiteUrl:TaskListUrl success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        NSNumber *codeSign = responseObject[@"code"];
        if (codeSign.integerValue == 0) {
            NSArray *result = [TaskModel createModelsWithJSONArray:responseObject[@"data"]];
            if (success) {
                success(YES, result);
            }
        } else {
            if (success) {
                success(YES, [NSArray new]);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(NO, error);
        }
    }];
}
@end
