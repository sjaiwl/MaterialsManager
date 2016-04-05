//
//  MMASelectItemViewController.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MMASelectItemViewCancelHandle)();
typedef void(^MMASelectItemViewDoneHandle)(id sid);

@interface MMASelectItemViewController : UIViewController
- (instancetype)initWithCurrentSid:(NSNumber *)sid workTypeID:(NSNumber *)wid cancelHandle:(MMASelectItemViewCancelHandle)cancelHandle doneHandle:(MMASelectItemViewDoneHandle)doneHandle;
- (CGFloat)heightForDisplay;

- (void)refreshCurrentViewData;

@end
