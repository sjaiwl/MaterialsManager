//
//  MainTainModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "TKJSONSerializedModel.h"

@interface MainTainModel : TKJSONSerializedModel
//异常
@property (nonatomic, copy) NSString *tderroritems;
//异常描述
@property (nonatomic, copy) NSString *tderrordescribe;
//位置
@property (nonatomic, copy) NSString *pposition;
//维修id
@property (nonatomic, assign) NSInteger mid;
//巡检明细id
@property (nonatomic, assign) NSInteger tdid;
//维修人id
@property (nonatomic, assign) NSInteger sid;
//维修人名称
@property (nonatomic, copy) NSString *sname;
//维修时间
@property (nonatomic, strong) NSDate *mmaintaintime;
//保修时间
@property (nonatomic, strong) NSDate *mrepairtime;
//状态
@property (nonatomic, copy) NSString *mstatus;

@end
