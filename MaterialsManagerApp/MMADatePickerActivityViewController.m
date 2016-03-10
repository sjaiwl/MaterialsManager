//
//  TaskActionActivityViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/9.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MMADatePickerActivityViewController.h"

@interface MMADatePickerActivityViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

//data
@property (nonatomic, strong)NSDate *currentDate;
@property (nonatomic, copy) MMADatePickerActivityCancelHandle cancelHandle;
@property (nonatomic, copy) MMADatePickerActivityDoneHandle doneHandle;

@end

@implementation MMADatePickerActivityViewController

//init
- (instancetype)initWithCurrentDate:(NSDate *)currentDate cancelHandle:(MMADatePickerActivityCancelHandle)cancelHandle doneHandle:(MMADatePickerActivityDoneHandle)doneHandle{
    if (self = [super init]) {
        if (currentDate) {
            _datePicker.date = currentDate;
            _currentDate = currentDate;
        }
        _cancelHandle = cancelHandle;
        _doneHandle = doneHandle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Public
- (CGFloat)heightForDisplay {
    return self.view.frame.size.height;
}

#pragma mark - button action

- (IBAction)cancelButtonAction:(UIButton *)sender {
    self.cancelHandle();
}

- (IBAction)doneButtonAction:(UIButton *)sender {
    self.doneHandle(self.datePicker.date);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
