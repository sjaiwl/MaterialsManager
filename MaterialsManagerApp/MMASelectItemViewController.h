//
//  MMASelectItemViewController.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MMASelectItemViewCancelHandle)();
typedef void(^MMASelectItemViewDoneHandle)(NSInteger sid);

@interface MMASelectItemViewController : UIViewController
- (instancetype)initWithCurrentSid:(NSInteger)sid cancelHandle:(MMASelectItemViewCancelHandle)cancelHandle doneHandle:(MMASelectItemViewDoneHandle)doneHandle;
- (CGFloat)heightForDisplay;

@end
