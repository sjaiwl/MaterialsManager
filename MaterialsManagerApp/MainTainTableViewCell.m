//
//  MainTainTableViewCell.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MainTainTableViewCell.h"
#import "UIImageView+CornerRadius.h"
#import "MainTainModel.h"
#import "UIView+Utils.h"
#import "MMAColors.h"
#import "TTDateUtils.h"

NSString *const kMMAMainTainTableViewCellIdentifier = @"kMMAMainTainTableViewCellIdentifier";
NSInteger const kMMAMainTainTableViewCellHeight = 95;

@interface MainTainTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *peopleImageView;
@property (weak, nonatomic) IBOutlet UILabel *peopleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *derroritemsLabel;
@property (weak, nonatomic) IBOutlet UILabel *derrordescribeLabel;
@property (weak, nonatomic) IBOutlet UILabel *repairtimeLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation MainTainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupCellAppearance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCellAppearance{
    self.peopleImageView.cornerRadius_MMA = self.peopleImageView.frame.size.height / 2.0;
    self.peopleNameLabel.textColor = MMA_BLACK(0.5);
    self.bottomView.backgroundColor = MMA_BLACK(0.2);
}

- (void)changeLabelTextColorByStatus:(NSString *)status{
    if ([status isEqualToString:@"0"]) {
        //未完成
        self.derroritemsLabel.textColor = MMA_BLACK(1);
        self.derrordescribeLabel.textColor = MMA_BLACK(1);
        self.repairtimeLabel.textColor = MMA_RED(1);
    }else{
        //已完成
        self.derroritemsLabel.textColor = MMA_BLACK(0.5);
        self.derrordescribeLabel.textColor = MMA_BLACK(0.5);
        self.repairtimeLabel.textColor = MMA_BLACK(0.5);
    }
}

- (void)configCellWithMainTainModel:(MainTainModel *)mainTainModel{
    self.peopleNameLabel.text = mainTainModel.sname;
    [self changeLabelTextColorByStatus:mainTainModel.mstatus];
    self.derroritemsLabel.text = mainTainModel.tderroritems;
    self.derrordescribeLabel.text = mainTainModel.tderrordescribe;
    self.repairtimeLabel.text = mainTainModel.mrepairtime.stringForTimeYYYYMMDD;
}

@end
