//
//  TaskTableViewCell.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "TaskTableViewCell.h"
#import "UIView+Utils.h"
#import "MMAColors.h"
#import "TaskModel.h"
#import "MMALogs.h"

NSString *const kMMATaskTableViewCellIdentifier = @"kMMATaskTableViewCellIdentifier";
NSInteger const kMMATaskTableViewCellHeight = 200;

@interface TaskTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backGroundView;

@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;

@end

@implementation TaskTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backGroundView.cornerRadius_MMA = 5;
    self.backGroundView.layer.borderColor = MMA_BLACK_LIGHT.CGColor;
    self.backGroundView.layer.borderWidth = 0.6;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - config
- (void)configCellWithTaskModel:(TaskModel *)taskModel{
    DLog(@"%@",taskModel);
}
@end
