//
//  taskModel.h
//  实训－字典模型转换
//
//  Created by 陈受恩 on 16/3/9.
//  Copyright © 2016年 chenshouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface taskModel : NSObject
/**科室，任务也就是物资种类，盘点人(命名冲突)，任务开始时间，巡检周期，任务结束时间*/
@property(nonatomic,copy)NSString* pdepartment;
@property(nonatomic,strong)NSArray* gname;
@property(nonatomic,copy)NSString* sname;
@property(nonatomic,strong)NSString* abegintime;
@property(nonatomic,strong)NSNumber*ginspectioncycle;
@property(nonatomic,strong)NSString* aendtime;


@end
