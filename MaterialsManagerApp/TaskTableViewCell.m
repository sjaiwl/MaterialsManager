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
#import "UIImageView+CornerRadius.h"
#import "TTDateUtils.h"
#import "UIButton+Utils.h"

NSString *const kMMATaskTableViewCellIdentifier = @"kMMATaskTableViewCellIdentifier";
NSInteger const kMMATaskTableViewCellHeight = 100;

@interface TaskTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backGroundView;

@property (weak, nonatomic) IBOutlet UIImageView *peopleImageView;
@property (weak, nonatomic) IBOutlet UILabel *taskLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation TaskTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.peopleImageView.cornerRadius_MMA = self.peopleImageView.frame.size.height / 2.0;
    self.peopleLabel.textColor = MMA_BLUE(1);
    self.dateLabel.textColor = MMA_BLACK(0.5);
    self.taskLabel.textColor = MMA_BLACK(1);
    self.durationLabel.textColor = MMA_BLACK(1);
    [self.statusButton setTitleColor:MMA_BLACK(0.5) forState:UIControlStateNormal];
    self.statusButton.cornerRadius_MMA = self.statusButton.frame.size.height / 2.0;
    self.statusButton.layer.borderColor = MMA_BLUE(0.5).CGColor;
    self.statusButton.layer.borderWidth = 1;
    self.bottomView.backgroundColor = MMA_BLACK(0.2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - config
- (void)configCellWithTaskModel:(TaskModel *)taskModel{
    self.peopleLabel.text = taskModel.hmmsStaffName;
    self.taskLabel.text = taskModel.hmmsSpecialName;
    self.durationLabel.text = taskModel.tinspectionbegintime.stringForTimeYYYYMMDD;
    self.dateLabel.text = taskModel.toriginaltime.stringForTimeYYYYMMDD;
    [self.statusButton setTitle:[self getStatusString:taskModel.tstatus]  forState:UIControlStateNormal];
}

- (NSString *)getStatusString:(NSString *)status{
    NSDictionary *dic = @{@"0" : @"未下达",
                          @"1" : @"未获取",
                          @"2" : @"执行中",
                          @"3" : @"已完成",
                          @"4" : @"已取消",
                          };
    return dic[status];
}
@end
