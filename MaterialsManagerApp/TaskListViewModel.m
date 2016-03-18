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
                          @"toriginaltime" : @"2014-08-23 09:20:05",
                          @"tinspectionbegintime" : @"2016-01-23 09:20:05",
                          @"tinspectionendtime" : @"2016-02-23 09:20:05",
                          @"tmodifiedtime" : @"2014-08-23 09:20:05",
                          @"tstatus" : @"1"
                          };
    TaskModel *model = [TaskModel createModelWithJSONDictionary:dic];
    return @[model,model,model,model,model,model,model,model,model,model];
}
@end
