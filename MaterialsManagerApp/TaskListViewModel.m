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

@implementation TaskListViewModel

+ (instancetype)sharedViewModel{
    static TaskListViewModel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

//get current modele
- (NSArray *)getCurrentTaskModels{
    //test
    NSDictionary *dic = @{
                          @"tid" : @(0000),
                          @"staffid" : @(1111),
                          @"tassignsid" : @(2222),
                          @"specialid" : @(3333),
                          @"ttype" : @"临时",
                          @"toriginaltime" : @"2014-08-23T09:20:05Z",
                          @"tinspectionbegintime" : @"2016-01-23T09:20:05Z",
                          @"tinspectionendtime" : @"2016-02-23T09:20:05Z",
                          @"tmodifiedtime" : @"2014-08-23T09:20:05Z",
                          @"tstatus" : @"1"
                          };
    TaskModel *model = [TaskModel createModelWithJSONDictionary:dic];
    return @[model];
}
@end
