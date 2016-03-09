//
//  extension.h
//  实训－字典模型转换
//
//  Created by 陈受恩 on 16/3/9.
//  Copyright © 2016年 chenshouen. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MMAModelTransfer : NSObject

/**json转模型方法*/
+(NSArray*)jsonToModel:(NSArray*)json;
/**模型转json方法*/
+(NSArray*)modelToJson:(NSArray*)task;
@end
