//
//  TaskTableViewCell.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"
@class TaskModel;

extern NSString *const kMMATaskTableViewCellIdentifier;
extern NSInteger const kMMATaskTableViewCellHeight;

@interface TaskTableViewCell : SWTableViewCell

- (void)configCellWithTaskModel:(TaskModel *)taskModel;

@end
