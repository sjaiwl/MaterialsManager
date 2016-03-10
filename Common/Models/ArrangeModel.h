//
//  ArrangeModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/10.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

//arrange model
#import "TKJSONSerializedModel.h"

@interface ArrangeModel : TKJSONSerializedModel
//安排id
@property (nonatomic, strong) NSNumber *aid;
//物资id
@property (nonatomic, strong) NSNumber *gid;
//员工id
@property (nonatomic, strong) NSNumber *sid;
//开始时间
@property (nonatomic, strong) NSDate *abegintime;
//结束时间
@property (nonatomic, strong) NSDate *aendtime;
//状态标识
@property (nonatomic, copy) NSString *astatus;
//操作者id
@property (nonatomic, strong) NSNumber *aoperatorid;
//修改时间
@property (nonatomic, strong) NSDate *amodifiedtime;


@end
