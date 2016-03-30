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
#import "UIImage+Utils.h"
#import "AccountModel.h"
#import "IIViewDeckController.h"
#import "MaterialsLeftViewController.h"
#import "RESideMenu.h"

@interface WelcomeViewController ()<UITextFieldDelegate>
//app info
@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;
//input field
@property (weak, nonatomic) IBOutlet UIImageView *nameLeftImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UIView *userNameBottomView;

@property (weak, nonatomic) IBOutlet UIImageView *passwordLeftImageView;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIView *passwordBottomView;
//login field
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (assign, nonatomic, getter=isShowingActivity) BOOL showingActivity;

//@property (nonatomic, strong) IIViewDeckController *deckController;
@property (nonatomic, strong) RESideMenu *sideMenuController;
@property (nonatomic, strong) MaterialsCollectionViewController *materialsCollectionViewController;
@property (nonatomic, strong) MaterialsLeftViewController *materialsLeftViewController;

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

- (MaterialsLeftViewController *)materialsLeftViewController{
    if (!_materialsLeftViewController) {
        _materialsLeftViewController = [MaterialsLeftViewController loadFromStoryboard];
    }
    return _materialsLeftViewController;
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
    [self setupBackGroundView];
    [self setupTextFieldViews];
    [self setupLoginButtonViews];
}

//设置背景渐变
- (void)setupBackGroundView{
    CAGradientLayer *colorLayer = [CAGradientLayer layer];
    colorLayer.frame = self.view.frame;
    colorLayer.position = self.view.center;
    [self.view.layer insertSublayer:colorLayer atIndex:0];

    colorLayer.colors = @[(__bridge id)MMA_GRADIENT_COLOR_STARE(1).CGColor,
                          (__bridge id)MMA_GRADIENT_COLOR_CENTER(1).CGColor,
                          (__bridge id)MMA_GRADIENT_COLOR_END(1).CGColor,];

    colorLayer.startPoint = CGPointMake(1, 0);
    colorLayer.endPoint = CGPointMake(0, 1);
}

- (void)setupTextFieldViews{
    self.appNameLabel.textColor = MMA_WHITE(1);
    //set preference
    [self setupPreferenceValue];
    //name field
    [self setupNameField];
    //password field
    [self setupPasswordField];
}

- (void)setupNameField{
    //return type
    self.userNameField.returnKeyType = UIReturnKeyNext;
    //title color
    self.userNameField.textColor = MMA_WHITE(1);
    self.userNameField.delegate = self;

    if ([self.userNameField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.userNameField.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"用户名"
                                        attributes:@{ NSForegroundColorAttributeName : MMA_PLACEHOLDER_COLOR}];
    } else {
        self.userNameField.placeholder = @"用户名";
    }

    //left view
    self.nameLeftImageView.contentMode = UIViewContentModeCenter;
    self.nameLeftImageView.image = [UIImage templateImageNamed:@"sign_in_account"];
    self.nameLeftImageView.tintColor = MMA_PLACEHOLDER_COLOR;

    //bottom view
    self.userNameBottomView.backgroundColor = MMA_PLACEHOLDER_COLOR;
}

- (void)setupPasswordField{
    //return type
    self.passwordField.returnKeyType = UIReturnKeyDone;
    self.passwordField.secureTextEntry = YES;
    //title color
    self.passwordField.textColor = MMA_WHITE(1);
    self.passwordField.delegate = self;

    if ([self.passwordField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.passwordField.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"密码"
                                        attributes:@{ NSForegroundColorAttributeName : MMA_PLACEHOLDER_COLOR}];
    } else {
        self.passwordField.placeholder = @"密码";
    }
    //left view
    self.passwordLeftImageView.contentMode = UIViewContentModeCenter;
    self.passwordLeftImageView.image = [UIImage templateImageNamed:@"sign_in_password"];
    self.passwordLeftImageView.tintColor = MMA_PLACEHOLDER_COLOR;
    //bottom view
    self.passwordBottomView.backgroundColor = MMA_PLACEHOLDER_COLOR;
}

- (void)setupPreferenceValue{
    NSString *name = [self.preferenceManager getUserDefaultsForUserName];
    NSString *password = [self.preferenceManager getUserDefaultsForUserPassword];
    if (name) {
        self.userNameField.text = name;
    }
//    if (password && [self.preferenceManager getUserDefaultsForRememberPassword]) {
//        self.passwordField.text = password;
//    }
    if (password) {
        self.passwordField.text = password;
    }
}

- (void)savePreferenceValue{
    [self.preferenceManager setUserDefaultsForUserName:self.userNameField.text];
    [self.preferenceManager setUserDefaultsForUserPassword:self.passwordField.text];
}

- (void)setupLoginButtonViews{
    [self.loginButton setTitle:@"登 录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginButton.backgroundColor = MMA_GREEN(1);
    self.loginButton.cornerRadius_MMA = self.loginButton.frame.size.height / 2.0;
}

#pragma mark - init observer
- (void)initObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainNavigationControllerDismissed:) name:kMMANavigationControllerDidDismissedNotification object:nil];
}

#pragma mark - button action
- (IBAction)loginButtonAction:(UIButton *)sender {
    if ([self checkNameAndPassWord]) {
        [self loginBegin];
        AccountModel *accountModel = [[AccountModel alloc] init];
        accountModel.saccount = self.userNameField.text;
        accountModel.spassword = self.passwordField.text;
        accountModel.stype = @"1";
        [[MMAAccountManager sharedManager] signInWithSiteUrl:LoginUrl AccountModel:accountModel completionHandler:^(MMASignInResult result) {
            [self handleSignInResult:result];
        }];
    } else {
        [self showToastWithMessage:@"用户名或密码为空"];
    }
}

- (void)handleSignInResult:(MMASignInResult)result{
    switch (result) {
        case MMASignInResultSuccess:
            [self loginSuccess];
            break;

            case MMASignInResultOtherError:
            [self loginFailed];
            break;

        default:
            break;
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
    DLog(@"account:%@", [MMAAccountManager sharedManager].accountModel);
    [self hideToastWithIndicatorView];

    MMANavViewController *navCenter = [[MMANavViewController alloc] initWithRootViewController:self.materialsCollectionViewController];

//    self.deckController = [[IIViewDeckController alloc] initWithCenterViewController:navCenter leftViewController:self.materialsLeftViewController];
//    self.deckController.centerhiddenInteractivity = IIViewDeckCenterHiddenNotUserInteractiveWithTapToClose;
//    self.deckController.delegateMode = IIViewDeckDelegateOnly;
//    self.deckController.panningMode = IIViewDeckAllViewsPanning;
//    self.deckController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;


    self.sideMenuController = [[RESideMenu alloc] initWithContentViewController:navCenter leftMenuViewController:self.materialsLeftViewController rightMenuViewController:nil];
    self.sideMenuController.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.sideMenuController.contentViewShadowColor = MMA_BLACK_DARK;
    self.sideMenuController.contentViewShadowOffset = CGSizeMake(0, 0);
    self.sideMenuController.contentViewShadowOpacity = 0.6;
    self.sideMenuController.contentViewShadowRadius = 12;
    self.sideMenuController.contentViewShadowEnabled = YES;
    self.sideMenuController.scaleBackgroundImageView = YES;
    self.sideMenuController.backgroundImage = [UIImage imageWithColor:MMA_BLACK_DARK];
    self.sideMenuController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:self.sideMenuController animated:YES completion:nil];
}

- (void)loginFailed{
    [self hideToastWithIndicatorView];
    [self showToastWithMessage:@"登录失败"];
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
    return UIStatusBarStyleLightContent;
}

#pragma mark - observer action
- (void)mainNavigationControllerDismissed:(NSNotification *)notification{
    self.materialsCollectionViewController = nil;
    self.materialsLeftViewController = nil;
//    self.deckController = nil;
    self.sideMenuController = nil;
}
@end
