//
//  TaskDetailsTableViewCell.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "TaskDetailsTableViewCell.h"

NSString *const kMMATaskDetailsTableViewCellIdentifier = @"kMMATaskDetailsTableViewCellIdentifier";
NSInteger const kMMTaskDetailsTableViewCellHeight = 44;
@interface TaskDetailsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentField;

@property (nonatomic, copy) NSString *originalString;

@end

@implementation TaskDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contentField.enabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)configCellWithDescribeString:(NSString *)describeString contentString:(NSString *)contentString{
    self.originalString = contentString;
    self.describeLabel.text = describeString;
    self.contentField.text = contentString;
}

@end
