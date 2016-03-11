//
//  CategoryViewModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "CategoryViewModel.h"
#import "CategoryModel.h"

@implementation CategoryViewModel

+ (instancetype)sharedViewModel{
    static CategoryViewModel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}
//local model
- (NSArray *)getCurrentCategoryFromLocal{
    CategoryModel *categoryRelease = [CategoryModel categoryRelease];
    CategoryModel *categoryCheck = [CategoryModel categoryCheck];
    CategoryModel *categoryUpload = [CategoryModel categoryUpload];
    CategoryModel *categoryRecord = [CategoryModel categoryRecord];
    CategoryModel *categoryAsset = [CategoryModel categoryAsset];
    CategoryModel *categoryTransfer = [CategoryModel categoryTransfer];

    return @[categoryRelease,categoryCheck,categoryUpload,categoryRecord,categoryAsset,categoryTransfer].copy;
}

@end
