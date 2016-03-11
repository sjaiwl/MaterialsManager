//
//  TaskDetailsViewController.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaskModel;

@interface TaskDetailsViewController : UITableViewController

- (void)initWithTaskModel:(TaskModel *)taskModel;

@end
