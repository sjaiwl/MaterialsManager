//
//  TaskListViewModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/11.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskListViewModel : NSObject

+ (instancetype)sharedViewModel;

//get current modele
- (NSArray *)getCurrentTaskModels;

@end
