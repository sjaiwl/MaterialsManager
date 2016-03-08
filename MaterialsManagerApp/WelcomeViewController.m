//
//  ViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/1/17.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "WelcomeViewController.h"
#import "MMAColors.h"
#import "MMALogs.h"
#import "MMAConstants.h"
#import "UIButton+Utils.h"
#import "UIViewController+Utils.h"
#import "MaterialsCollectionViewController.h"
#import "MMANavViewController.h"

@interface WelcomeViewController ()<UITextFieldDelegate>
//app info
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
//input field
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
//remember pass
@property (weak, nonatomic) IBOutlet UIButton *rememberPasswordButton;
@property (weak, nonatomic) IBOutlet UILabel *rememberPasswordLabel;
//login field
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginIndicator;

@property (nonatomic, strong) MaterialsCollectionViewController *materialsCollectionViewController;

@end

@implementation WelcomeViewController

#pragma mark - private
-(MaterialsCollectionViewController *)materialsCollectionViewController{
    if (!_materialsCollectionViewController) {
        _materialsCollectionViewController = [MaterialsCollectionViewController loadFromStoryboard];
    }
    return _materialsCollectionViewController;
}

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupSubViews];
    [self initObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup subViews
- (void)setupSubViews{
    [self setupTextFieldViews];
    [self setupRememberPasswordViews];
    [self setupLoginButtonViews];
}

- (void)setupTextFieldViews{
    //return type
    self.userNameField.returnKeyType = UIReturnKeyNext;
    self.passwordField.returnKeyType = UIReturnKeyDone;
    self.passwordField.secureTextEntry = YES;

    self.userNameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)setupRememberPasswordViews{
    [self.rememberPasswordButton setImage:[UIImage imageNamed:@"btn_check"] forState:UIControlStateNormal];
    [self.rememberPasswordButton setImage:[UIImage imageNamed:@"btn_checked"] forState:UIControlStateSelected];
}

- (void)setupLoginButtonViews{
    self.loginIndicator.hidden = YES;
    [self.loginButton setTitleColor:MMA_BLACK(1) forState:UIControlStateNormal];
    self.loginButton.backgroundColor = MMA_BLUE_LIGHT;
    self.loginButton.layer.borderWidth = 0.6;
    self.loginButton.layer.borderColor = MMA_BLACK_LIGHT.CGColor;
    self.loginButton.cornerRadius_MMA = 5;
}

#pragma mark - init observer
- (void)initObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainNavigationControllerDismissed:) name:kMMANavigationControllerDidDismissedNotification object:nil];
}

#pragma mark - button action
- (IBAction)rememberPasswordButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    DLog(@"%d",sender.selected);
}

- (IBAction)loginButtonAction:(UIButton *)sender {

    [self loginSuccess];
}

#pragma mark - login success
- (void)loginSuccess{
    MMANavViewController *nav = [[MMANavViewController alloc] initWithRootViewController:self.materialsCollectionViewController];
    self.materialsCollectionViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == self.userNameField) {
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField){
        [self.view endEditing:YES];
    }
    return YES;
}

#pragma mark - 返回状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

#pragma mark - observer action
- (void)mainNavigationControllerDismissed:(NSNotification *)notification{
    self.materialsCollectionViewController = nil;
}
@end
