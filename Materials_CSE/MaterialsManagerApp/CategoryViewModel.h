//
//  CategoryViewModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryViewModel : NSObject

+ (instancetype)sharedViewModel;

//local model
- (NSArray *)getCurrentCategoryFromeLocal;

@end
