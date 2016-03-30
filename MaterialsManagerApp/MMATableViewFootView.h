//
//  MMATableViewFootView.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MMATableViewFootViewDelegate <NSObject>

- (void)didClickChangeStaffButton:(UIButton *)button;

@end

@interface MMATableViewFootView : UIView

@property (nonatomic, assign) id<MMATableViewFootViewDelegate> delegate;
@end
