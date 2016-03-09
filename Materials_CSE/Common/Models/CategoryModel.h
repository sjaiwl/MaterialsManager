//
//  CategoryModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic, copy) NSString *categoryID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, assign) NSUInteger taskCount;

//collection category
+ (instancetype)categoryRelease;
+ (instancetype)categoryCheck;
+ (instancetype)categoryUpload;
+ (instancetype)categoryRecord;
+ (instancetype)categoryAsset;
+ (instancetype)categoryTransfer;

@end
