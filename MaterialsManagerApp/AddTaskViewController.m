//
//  AddTaskViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "AddTaskViewController.h"
#import "MMAColors.h"
#import "UIView+Utils.h"
#import "UINavigationBar+Utils.h"
#import "UIViewController+Utils.h"
#import "MMASheetView.h"
#import "MMADatePickerActivityViewController.h"
#import "TTStringUtils.h"
#import "TTDateUtils.h"

@interface AddTaskViewController ()
//label
@property (weak, nonatomic) IBOutlet UILabel *departmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *assetLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

@property (weak, nonatomic) IBOutlet UITextField *departmentField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextField *peopleField;
@property (weak, nonatomic) IBOutlet UIButton *selectDateButton;

//sheet view
@property (nonatomic, strong) MMASheetView *sheetView;
@property (nonatomic, strong) MMADatePickerActivityViewController *actionActivityViewController;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup subViews
- (void)setupSubViews{
    [self setupNavigationViews];
    [self setupLabel];
    [self setupField];
    [self setupButton];
}

- (void)setupNavigationViews{
    self.navigationItem.title = @"任务编辑";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(navCancelAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(navDoneAction:)];
}

- (void)setupLabel{
    //label
    self.departmentLabel.backgroundColor = MMA_BLACK(0.6);
    self.departmentLabel.textColor = MMA_WHITE(1);
    self.departmentLabel.cornerRadius_MMA = 3;

    self.assetLabel.backgroundColor = MMA_BLACK(0.6);
    self.assetLabel.textColor = MMA_WHITE(1);
    self.assetLabel.cornerRadius_MMA = 3;

    self.peopleLabel.backgroundColor = MMA_BLACK(0.6);
    self.peopleLabel.textColor = MMA_WHITE(1);
    self.peopleLabel.cornerRadius_MMA = 3;

    self.durationLabel.backgroundColor = MMA_BLACK(0.6);
    self.durationLabel.textColor = MMA_WHITE(1);
    self.durationLabel.cornerRadius_MMA = 3;
}

- (void)setupField{
    self.departmentField.layer.borderWidth = 0.6;
    self.departmentField.layer.borderColor = MMA_BLACK_LIGHT.CGColor;
    self.departmentField.cornerRadius_MMA = 5;

    self.contentTextView.layer.borderWidth = 0.6;
    self.contentTextView.layer.borderColor = MMA_BLACK_LIGHT.CGColor;
    self.contentTextView.cornerRadius_MMA = 5;

    self.peopleField.layer.borderWidth = 0.6;
    self.peopleField.layer.borderColor = MMA_BLACK_LIGHT.CGColor;
    self.peopleField.cornerRadius_MMA = 5;
}

- (void)setupButton{
    self.selectDateButton.layer.borderWidth = 0.6;
    self.selectDateButton.layer.borderColor = MMA_BLACK_LIGHT.CGColor;
    self.selectDateButton.cornerRadius_MMA = 5;
    self.selectDateButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Button Action

- (IBAction)selectDateAction:(UIButton *)sender {
    __weak AddTaskViewController *weakSelf = self;
    self.actionActivityViewController = [[MMADatePickerActivityViewController alloc] initWithCurrentDate:nil cancelHandle:^{
        [weakSelf.sheetView dismiss];
    } doneHandle:^(NSDate *selectedDate) {
        [weakSelf.sheetView dismiss];
        [weakSelf.selectDateButton setTitle:selectedDate.stringForTimeYYYYMMDD forState:UIControlStateNormal];
        NSLog(@"%@",selectedDate);
    }];
    self.sheetView =
    [[MMASheetView alloc]
     initWithContentView:self.actionActivityViewController.view
     contentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), self.actionActivityViewController.heightForDisplay)
     sheetType:TTSheetViewTypeBottom];
    [self.sheetView show];
}

#pragma mark - button action
- (void)navDoneAction:(UIBarButtonItem *)sender {

}

- (void)navCancelAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
