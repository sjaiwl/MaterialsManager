//
//  WorkTypeModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/4/2.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKJSONSerializedModel.h"

@interface WorkTypeModel : TKJSONSerializedModel


@property (nonatomic, assign) NSNumber *wid;

@property (nonatomic, copy) NSString *wname;

@property (nonatomic, copy) NSString *wdescribe;


@end
