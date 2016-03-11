//
//  TaskDetailsTableViewCell.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kMMATaskDetailsTableViewCellIdentifier;
extern NSInteger const kMMTaskDetailsTableViewCellHeight;

@interface TaskDetailsTableViewCell : UITableViewCell

- (void)configCellWithDescribeString:(NSString *)describeString contentString:(NSString *)contentString;

@end
