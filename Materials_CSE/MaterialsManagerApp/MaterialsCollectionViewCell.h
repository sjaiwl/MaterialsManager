//
//  MaterialsCollectionViewCell.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CategoryModel;
extern NSString *const MaterialsCollectionViewCellIdentifier;

@interface MaterialsCollectionViewCell : UICollectionViewCell

- (void)configCellWithCategoryModel:(CategoryModel *)categoryModel;

@end
