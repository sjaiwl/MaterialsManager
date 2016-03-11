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
#import "MMAAccountManager.h"
#import "MMAConstants.h"
#import "MBProgressHUD.h"
#import "MMAPreferenceManager.h"

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

@property (assign, nonatomic, getter=isShowingActivity) BOOL showingActivity;

@property (nonatomic, strong) MaterialsCollectionViewController *materialsCollectionViewController;

@property (nonatomic, strong) MBProgressHUD *toastIndictorManager;
@property (nonatomic, assign, getter=isIndictorShowing) BOOL indictorShowing;

//preference
@property (nonatomic, strong) MMAPreferenceManager *preferenceManager;

@end

@implementation WelcomeViewController

#pragma mark - private
- (MaterialsCollectionViewController *)materialsCollectionViewController{
    if (!_materialsCollectionViewController) {
        _materialsCollectionViewController = [MaterialsCollectionViewController loadFromStoryboard];
    }
    return _materialsCollectionViewController;
}

- (MMAPreferenceManager *)preferenceManager{
    if (!_preferenceManager) {
        _preferenceManager = [MMAPreferenceManager sharedManager];
    }
    return _preferenceManager;
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
    //set preference
    [self setupPreferenceValue];
    //return type
    self.userNameField.returnKeyType = UIReturnKeyNext;
    self.passwordField.returnKeyType = UIReturnKeyDone;
    self.passwordField.secureTextEntry = YES;
    self.userNameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)setupPreferenceValue{
    NSString *name = [self.preferenceManager getUserDefaultsForUserName];
    NSString *password = [self.preferenceManager getUserDefaultsForUserPassword];
    if (name) {
        self.userNameField.text = name;
    }
    if (password && [self.preferenceManager getUserDefaultsForRememberPassword]) {
        self.passwordField.text = password;
    }
}

- (void)savePreferenceValue{
    [self.preferenceManager setUserDefaultsForUserName:self.userNameField.text];
    [self.preferenceManager setUserDefaultsForUserPassword:self.passwordField.text];
}

- (void)setupRememberPasswordViews{
    [self.rememberPasswordButton setImage:[UIImage imageNamed:@"btn_check"] forState:UIControlStateNormal];
    [self.rememberPasswordButton setImage:[UIImage imageNamed:@"btn_checked"] forState:UIControlStateSelected];
    self.rememberPasswordButton.selected = [self.preferenceManager getUserDefaultsForRememberPassword];
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
    [self.preferenceManager setUserDefaultsForRememberPassword:sender.isSelected];
}

- (IBAction)loginButtonAction:(UIButton *)sender {
    if ([self checkNameAndPassWord]) {
        [self loginBegin];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self loginSuccess];
        });
    } else {
        [self showToastWithMessage:@"用户名或密码为空"];
    }
}

#pragma mark - check text
- (BOOL)checkNameAndPassWord{
    if ([self.userNameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

#pragma mark - login success
- (void)loginBegin{
    [self endViewEditingMode];
    [self showToastWithIndicatorView];
    [self savePreferenceValue];
}
- (void)loginSuccess{
    [self hideToastWithIndicatorView];
    MMANavViewController *nav = [[MMANavViewController alloc] initWithRootViewController:self.materialsCollectionViewController];
    self.materialsCollectionViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)loginFailed{
    [self hideToastWithIndicatorView];
    [self showToastWithMessage:@"登录失败"];
}

#pragma mark - button state
- (void)startLoginNormalState{
    self.loginButton.enabled = YES;
    self.loginIndicator.hidden = YES;
    if (self.loginIndicator.isAnimating) {
        [self.loginIndicator stopAnimating];
    }
}

- (void)startLoginingState{
    self.loginButton.enabled = NO;
    self.loginIndicator.hidden = NO;
    if (!self.loginIndicator.isAnimating) {
        [self.loginIndicator startAnimating];
    }
}

#pragma mark - toast function
- (void)showToastWithMessage:(NSString *)string{
    MBProgressHUD *toast = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    toast.mode = MBProgressHUDModeText;
    toast.label.text = string;
    [toast hideAnimated:YES afterDelay:2];
}

- (void)showToastWithIndicatorView{
    if (!self.isIndictorShowing) {
        self.indictorShowing = YES;
        self.toastIndictorManager = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.toastIndictorManager.mode = MBProgressHUDModeIndeterminate;
    }
}

- (void)hideToastWithIndicatorView{
    if (self.isIndictorShowing) {
        self.indictorShowing = NO;
        [self.toastIndictorManager hideAnimated:YES];
    }
}

#pragma mark - end editing mode
- (void)endViewEditingMode{
    [self.view endEditing:YES];
}

#pragma Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endViewEditingMode];
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
