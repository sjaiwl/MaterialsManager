//
//  ItemListViewModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/4/2.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "ItemListViewModel.h"
#import "MMAHTTPManager.h"
#import "MMAConstants.h"
#import "WorkTypeModel.h"
#import "MMALogs.h"
#import "AccountModel.h"

@interface ItemListViewModel ()

@property (nonatomic, strong) MMAHTTPManager* httpManager;
@property (nonatomic, copy) NSArray *allWorkTypeArray;
@property (nonatomic, strong) NSMutableDictionary *workTypeStaffDictionary;

@end

@implementation ItemListViewModel

+ (instancetype)sharedViewModel{
    static ItemListViewModel *_sharedInstance = nil;
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

- (NSArray *)allWorkTypeArray{
    if (!_allWorkTypeArray) {
        _allWorkTypeArray = [NSArray new];
    }
    return _allWorkTypeArray;
}

- (NSMutableDictionary *)workTypeStaffDictionary{
    if (!_workTypeStaffDictionary) {
        _workTypeStaffDictionary = [NSMutableDictionary new];
    }
    return _workTypeStaffDictionary;
}

#pragma mark - public
- (NSArray *)getCurentWorkTypeStaffByWID:(NSNumber*)wid{
    return self.workTypeStaffDictionary[wid];
}

- (void)reloadWorkTypeInformation{
    if (!self.workTypeStaffDictionary || self.workTypeStaffDictionary.count <= 0) {
        [self getAllWorkType];
    }
}

#pragma mark - private
- (void)getAllWorkType{
    __weak ItemListViewModel* weakSelf = self;
    [self.httpManager getAllWorkTypeListWithSiteUrl:AllWorkTypeListUrl success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@",responseObject);
        NSNumber *codeSign = responseObject[@"code"];
        if (codeSign.integerValue == 0) {
            weakSelf.allWorkTypeArray = [WorkTypeModel createModelsWithJSONArray:responseObject[@"data"]];
            [weakSelf getEveryWorkTypeStaff];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)getEveryWorkTypeStaff{
    if (self.allWorkTypeArray && self.allWorkTypeArray.count > 0) {
        __weak ItemListViewModel *weakSelf = self;
        [self.allWorkTypeArray enumerateObjectsUsingBlock:^(WorkTypeModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [weakSelf getWorkTypeStaffByWorkTypeID:obj.wid];
        }];
    }
}

- (void)getWorkTypeStaffByWorkTypeID:(NSNumber *)wid{
    __weak ItemListViewModel* weakSelf = self;
    [self.httpManager getWorkTypeStaffListWithSiteUrl:WorkTypeStaffListUrl workType:wid success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLog(@"%@", responseObject);
        NSNumber *codeSign = responseObject[@"code"];
        if (codeSign.integerValue == 0) {
            NSArray *result = [AccountModel createModelsWithJSONArray:responseObject[@"data"]];
            weakSelf.workTypeStaffDictionary[wid] = result;
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"%@", error);
    }];
}

@end
