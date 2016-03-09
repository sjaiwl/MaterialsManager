//
//  extension.m
//  实训－字典模型转换
//
//  Created by 陈受恩 on 16/3/9.
//  Copyright © 2016年 chenshouen. All rights reserved.
//

#import "MMAModelTransfer.h"
#import "TaskModel.h"
#import "MJExtension.h"
@implementation MMAModelTransfer
/**json转模型方法*/
+(NSArray*)jsonToModel:(NSArray*)json{
    NSArray* model=[TaskModel mj_objectArrayWithKeyValuesArray:json];
    return model;
}
/**模型数组转json方法*/
+(NSArray*)modelToJson:(NSArray*)task{
    NSArray *dictArray = [TaskModel mj_keyValuesArrayWithObjectArray:task];
    return dictArray;    
}




@end
