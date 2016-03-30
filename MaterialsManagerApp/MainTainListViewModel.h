//
//  MainTainListViewModel.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMABlocks.h"

@interface MainTainListViewModel : NSObject

+ (instancetype)sharedViewModel;

//get current modele
- (void)getCurrentMainTainModelsWithType: (NSInteger)type
                                 success:(TTResultBlockWithArray)success
                                 failure:(TTResultAndErrorBlock) failure;

@end
