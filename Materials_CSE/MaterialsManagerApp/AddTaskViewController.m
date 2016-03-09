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
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

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
    self.navigationController.navigationBar.backgroundColor_MMA = MMA_BLUE_LIGHT;
    self.navigationController.navigationBar.tintColor = MMA_BLACK(1);
    self.navigationItem.title = @"任务编辑";
}

- (void)setupLabel{
    //label
    self.departmentLabel.backgroundColor = MMA_BLUE_LIGHT;
    self.departmentLabel.cornerRadius_MMA = 3;

    self.assetLabel.backgroundColor = MMA_BLUE_LIGHT;
    self.assetLabel.cornerRadius_MMA = 3;

    self.peopleLabel.backgroundColor = MMA_BLUE_LIGHT;
    self.peopleLabel.cornerRadius_MMA = 3;

    self.durationLabel.backgroundColor = MMA_BLUE_LIGHT;
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

    [self.cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelButton.backgroundColor = MMA_BLUE_LIGHT;
//    self.cancelButton.layer.borderColor = MMA_BLACK_LIGHT.CGColor;
//    self.cancelButton.layer.borderWidth = 0.6;
//    self.cancelButton.cornerRadius_MMA = 5;

    [self.doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.doneButton.backgroundColor = MMA_BLUE_LIGHT;
//    self.doneButton.layer.borderColor = MMA_BLACK_LIGHT.CGColor;
//    self.doneButton.layer.borderWidth = 0.6;
//    self.doneButton.cornerRadius_MMA = 5;
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
- (IBAction)doneAction:(UIButton *)sender {
}

- (IBAction)cancelAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
