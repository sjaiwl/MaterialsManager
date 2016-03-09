//
//  TaskActionActivityViewController.h
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/9.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MMADatePickerActivityCancelHandle)();
typedef void (^MMADatePickerActivityDoneHandle)(NSDate *selectedDate);

@interface MMADatePickerActivityViewController : UIViewController

- (instancetype)initWithCurrentDate:(NSDate *)currentDate cancelHandle:(MMADatePickerActivityCancelHandle)cancelHandle doneHandle:(MMADatePickerActivityDoneHandle)doneHandle;
- (CGFloat)heightForDisplay;

@end
