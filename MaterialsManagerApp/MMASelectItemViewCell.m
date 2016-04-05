//
//  MMASelectItemViewCell.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MMASelectItemViewCell.h"
#import "MMAColors.h"
#import "UIImageView+CornerRadius.h"
#import "UIView+Utils.h"
#import "AccountModel.h"

NSString *const kMMASelectItemViewCellIdentifier = @"kMMASelectItemViewCellIdentifier";

@interface MMASelectItemViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation MMASelectItemViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = MMA_WHITE(1);
    self.cornerRadius_MMA = 5;
    self.imageView.cornerRadius_MMA = self.imageView.frame.size.height / 2.0;
    self.nameLabel.textColor = MMA_BLACK(1);
}

- (void)configCellWithAccountModel:(AccountModel *)model
                    currentStaffID:(NSNumber *)currentID{
    self.nameLabel.text = model.sname;
    if (model.sid == currentID) {
        self.selected = YES;
    }else{
        self.selected = NO;
    }
}

@end
