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

NSString *const MaterialsCollectionViewCellIdentifier = @"MaterialsCollectionViewCellReuseIdentifier";

@interface MaterialsCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;


@end

@implementation MaterialsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = MMA_GRAY_LIGHT;
    self.layer.borderWidth = 0.6;
    self.layer.borderColor = MMA_BLACK_LIGHT.CGColor;
    self.cornerRadius_MMA = 5;
    self.numberLabel.hidden = YES;
}

- (void)configCellWithCategoryModel:(CategoryModel *)categoryModel{
    self.logoImageView.image = [UIImage imageNamed:categoryModel.imageName];
    self.nameLabel.text = categoryModel.name;
    if (categoryModel.taskCount) {
        self.numberLabel.text = [NSString stringWithFormat:@"%lu",categoryModel.taskCount];
        self.numberLabel.hidden = NO;
    }
}

@end
