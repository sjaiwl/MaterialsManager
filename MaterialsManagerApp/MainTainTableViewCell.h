//
//  MainTainTableViewCell.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTainModel;

extern NSString *const kMMAMainTainTableViewCellIdentifier;
extern NSInteger const kMMAMainTainTableViewCellHeight;

@interface MainTainTableViewCell : UITableViewCell

- (void)configCellWithMainTainModel:(MainTainModel *)mainTainModel;

@end
