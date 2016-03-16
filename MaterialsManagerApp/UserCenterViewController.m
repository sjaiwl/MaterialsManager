//
//  UserCenterViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "UserCenterViewController.h"
#import "MMAConstants.h"
#import "MMAEnum.h"
#import "UserSettingViewModel.h"
#import "UserSettingModel.h"
#import "SDImageCache.h"
#import "MMAAccountManager.h"
#import "MMAColors.h"
#import "UIImage+Utils.h"
#import "IIViewDeckController.h"

static NSString *const kMMAUserCenterCellReuseIdentifier = @"userCenterCellResueIdentifier";

@interface UserCenterViewController ()<UIAlertViewDelegate>
//viewModel
@property (nonatomic, strong) UserSettingViewModel *settingViewModel;
//data
@property (nonatomic, copy) NSDictionary *settingModelDictionary;


@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessor
- (UserSettingViewModel *)settingViewModel{
    if (!_settingViewModel) {
        _settingViewModel = [UserSettingViewModel sharedViewModel];
    }
    return _settingViewModel;
}
- (NSDictionary *)settingModelDictionary{
    if (!_settingModelDictionary) {
        _settingModelDictionary = [self.settingViewModel getCurrentUserSettingInfo];
    }
    return _settingModelDictionary;
}

#pragma mark - setup subViews
- (void)setupSubViews{
    [self setupNavigationViews];
    [self setupTableViews];
}

- (void)setupNavigationViews{
    //设置nav文字颜色
    self.navigationItem.title = @"个人管理";
}

- (void)setupTableViews{
    //register cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kMMAUserCenterCellReuseIdentifier];
    //设置分割线缩进
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.settingModelDictionary.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.settingModelDictionary[@(section)];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMMAUserCenterCellReuseIdentifier forIndexPath:indexPath];

    //data model
    NSArray *array = self.settingModelDictionary[@(indexPath.section)];
    UserSettingModel *dataModal = array[indexPath.row];

    // Configure the cell...
    switch (indexPath.section) {
        case SettingSectionInfoAccount:
        case SettingSectionInfoNotification:
        case SettingSectionInfoAbout:
        case SettingSectionInfoCache:
            cell.textLabel.textColor = MMA_BLACK(1);
            cell.textLabel.text = dataModal.name;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (dataModal.imageName) {
                cell.imageView.tintColor = MMA_BLACK(0.8);
                cell.imageView.image = [UIImage templateImageNamed:dataModal.imageName];
            }
            break;

        case SettingSectionInfoSignOut:
            cell.textLabel.text = dataModal.name;
            cell.textLabel.textColor = MMA_RED(1);
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            break;

        default:
            break;
    }
    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    //清除tableview选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Create the next view controller.
    switch (indexPath.section) {
            //acount
        case SettingSectionInfoAccount:
            break;
            //notification
        case SettingSectionInfoNotification:
            break;
            //about
        case SettingSectionInfoAbout:
            if (indexPath.row == 0) {

            } else {

            }
            break;
            //cache
        case SettingSectionInfoCache:
            [self clearCache];
            break;
            //sign out
        case SettingSectionInfoSignOut:
            [self doSignOut];
            break;

        default:
            break;
    }
}

#pragma mark - TableView Selection Action
- (void)clearCache{
    //计算缓存大小
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    CGFloat cache = size / 1024.0 / 1024.0;
    //字符串
    NSString *str = [NSString stringWithFormat:@"%.2fM",cache];
    //初始化弹窗
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"清除缓存" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = 102;
    //显示弹框
    [alertView show];
}

- (void)doSignOut{
    //初始化弹窗
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"退出登录" message:@"你确定要退出登录吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alertView.tag = 101;
    //显示弹框
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 102 && buttonIndex == 1) {
        //清除缓存
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
    }else if (alertView.tag == 101 && buttonIndex == 1) {
        [[MMAAccountManager sharedManager] doSignOut];
    }
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
