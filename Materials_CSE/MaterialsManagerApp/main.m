//
//  main.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/1/17.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
/**数据模型与字典数组方法在extention中
*数据模型构造在taskModel中，其中字段名也许理解有误
*数据模型字典转换的第三方框架，按项目需要，采用字典数组和模型转换函数，它还有其它转换函数*/
#import "extension.h"
#import "taskModel.h"
#import "MJExtension.h"
/**测试数据:数据模型转字典数组*/
void test1(){
    
    taskModel* model1=[[taskModel alloc]init];
    model1.pdepartment=@"信息科";
    model1.gname=@{@"gname":@[@"鼠标",@"键盘"]};
    model1.sname=@"李四";
    model1.abegintime=@"2016-1-21";
    model1.ginspectioncycle=@10;
    model1.aendtime=@"2016-1-31";
    
    taskModel* model2=[[taskModel alloc]init];
    model2.pdepartment=@"住院科";
    model2.gname=@{@"gname":@[@"键盘"]};
    model2.sname=@"张三";
    model2.abegintime=@"2016-1-19";
    model2.ginspectioncycle=@3;
    model2.aendtime=@"2016-1-25";
    
    NSArray* array=@[model1,model2];
    NSArray *dictArray = [extension modelToJson:array];
    NSLog(@"\n--数据模型转字典数组结果：%@",dictArray);
}
/**测试数据：字典数组转数据模型*/
void test2(){
    NSArray* json=@[@{@"pdepartment":@"信息科",
                      @"gname":@[@"鼠标",@"键盘"],
                      @"sname":@"李四",
                      @"abegintime":@"2016-1-21",
                      @"ginspectioncycle":@10,
                      @"aendtime":@"2016-3-1",
                      },
                    @{@"pdepartment":@"住院部",
                      @"gname":@[@"键盘"],
                      @"sname":@"李武",
                      @"abegintime":@"2016-1-29",
                      @"ginspectioncycle":@15,
                      @"aendtime":@"2016-2-20",
                      }
                    ];
    NSArray *modelArray=[extension jsonToModel:json];
    for (taskModel *task in modelArray) {
         NSLog(@"\n－－科室是%@,－－任务是%@,--盘点人是%@,－－任务开始时间是%@,－－巡检周期是%@,－－任务结束时间是%@",task.pdepartment,task.gname,task.sname,task.abegintime,task.ginspectioncycle,task.aendtime);
    }

}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        test1();
        test2();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
