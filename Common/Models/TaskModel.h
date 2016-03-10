//
//  TaskModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/10.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

//task model
#import "TKJSONSerializedModel.h"

@interface TaskModel : TKJSONSerializedModel
//任务id
@property (nonatomic, strong) NSNumber *tid;
//员工id
@property (nonatomic, strong) NSNumber *staffid;
//任务下达人id
@property (nonatomic, strong) NSNumber *tassignsid;
//物种id
@property (nonatomic, strong) NSNumber *specialid;
//任务类别
@property (nonatomic, copy) NSString *ttype;
//原计划时间
@property (nonatomic, strong) NSDate *toriginaltime;
//开始时间
@property (nonatomic, strong) NSDate *tinspectionbegintime;
//结束时间
@property (nonatomic, strong) NSDate *tinspectionendtime;
//修改时间
@property (nonatomic, strong) NSDate *tmodifiedtime;
//状态标识
@property (nonatomic, copy) NSString *tstatus;

@end
