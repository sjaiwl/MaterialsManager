//
//  CategoryModel.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "CategoryModel.h"
#import "MMAConstants.h"

@implementation CategoryModel

// init
- (instancetype)initWithCategoryID:(NSString *)categoryID name:(NSString *)name imageName:(NSString *)imageName taskCount:(NSUInteger)taskCount{
    if (self = [super init]) {
        self.categoryID = categoryID;
        self.name = name;
        self.imageName = imageName;
        self.taskCount = taskCount;
    }
    return self;
}

- (instancetype)initWithCategoryID:(NSString *)categoryID name:(NSString *)name imageName:(NSString *)imageName{
    if (self = [super init]) {
        self.categoryID = categoryID;
        self.name = name;
        self.imageName = imageName;
        self.taskCount = 0;
    }
    return self;
}

//category accessor
+ (instancetype)categoryRelease{
    return [[self alloc] initWithCategoryID:RELEASE_ITEM_ID name:RELEASE_ITEM_NAME imageName:RELEASE_ITEM_IMAGE_NAME];
}

+ (instancetype)categoryCheck{
    return [[self alloc] initWithCategoryID:CHECK_ITEM_ID name:CHECK_ITEM_NAME imageName:CHECK_ITEM_IMAGE_NAME];
}

+ (instancetype)categoryUpload{
    return [[self alloc] initWithCategoryID:UPLOAD_ITEM_ID name:UPLOAD_ITEM_NAME imageName:UPLOAD_ITEM_IMAGE_NAME];
}

+ (instancetype)categoryRecord{
    return [[self alloc] initWithCategoryID:RECORD_ITEM_ID name:RECORD_ITEM_NAME imageName:RECORD_ITEM_IMAGE_NAME];
}

+ (instancetype)categoryAsset{
    return [[self alloc] initWithCategoryID:ASSET_ITEM_ID name:ASSET_ITEM_NAME imageName:ASSET_ITEM_IMAGE_NAME];
}

+ (instancetype)categoryTransfer{
    return [[self alloc] initWithCategoryID:TRANSFER_ITEM_ID name:TRANSFER_ITEM_NAME imageName:TRANSFER_ITEM_IMAGE_NAME];
}
@end
