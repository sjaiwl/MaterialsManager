//
//  MMATableViewHeaderFooterView.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kMMATableViewHeaderFooterViewReuseIdentifier;
extern NSInteger const kMMATableViewHeaderFooterViewHeight;

@interface MMATableViewHeaderFooterView : UITableViewHeaderFooterView

@property (strong, nonatomic) UIView *viewForBackgroundColor;
@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UIFont *titleFont;
@property (copy, nonatomic) NSString *title;

@end
