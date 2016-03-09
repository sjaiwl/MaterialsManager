//
//  MMABlocks.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TTGeneralBlock)();
typedef void (^TTIBActionBlock)(id sender);
typedef void (^TTResultBlock)(BOOL successfully);
typedef void (^TTDifferBlock)(BOOL hasChanges);
typedef void (^TTResultAndDifferBlock)(BOOL successfully, BOOL hasChanges);
typedef void (^TTResultAndErrorBlock)(BOOL successfully, NSError *error);

typedef void (^TTTimePickerCompletionBlock)(NSDate *newTime);

@interface MMABlocks : NSObject

@end
