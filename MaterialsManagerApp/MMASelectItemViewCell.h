//
//  MMASelectItemViewCell.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccountModel;

extern NSString *const kMMASelectItemViewCellIdentifier;

@interface MMASelectItemViewCell : UICollectionViewCell

- (void)configCellWithAccountModel:(AccountModel *)model currentStaffID:(NSNumber *)currentID;

@end
