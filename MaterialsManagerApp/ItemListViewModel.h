//
//  ItemListViewModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/4/2.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMABlocks.h"

@interface ItemListViewModel : NSObject

+ (instancetype)sharedViewModel;

- (NSArray *)getCurentWorkTypeStaffByWID:(NSNumber *)wid;

- (void)reloadWorkTypeInformation;

@end
