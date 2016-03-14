//
//  MaterialsCollectionViewCell.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MaterialsCollectionViewCell.h"
#import "MMAColors.h"
#import "UIView+Utils.h"
#import "CategoryModel.h"
#import "UIImage+Utils.h"

NSString *const MaterialsCollectionViewCellIdentifier = @"MaterialsCollectionViewCellReuseIdentifier";

@interface MaterialsCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *topContainerView;


@end

@implementation MaterialsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = MMA_WHITE(1);
    self.topContainerView.backgroundColor = MMA_GRAY_LIGHT;
    self.topContainerView.cornerRadius_MMA = 5;
    self.numberLabel.hidden = YES;
}

- (void)configCellWithCategoryModel:(CategoryModel *)categoryModel{
    self.logoImageView.tintColor = MMA_BLACK(0.6);
    self.logoImageView.image = [UIImage templateImageNamed:categoryModel.imageName];
    self.nameLabel.text = categoryModel.name;
    if (categoryModel.taskCount) {
        self.numberLabel.text = [NSString stringWithFormat:@"%lu",categoryModel.taskCount];
        self.numberLabel.hidden = NO;
    }
}

@end
