//
//  MaterialsLeftViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/14.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MaterialsLeftViewController.h"
#import "MMAAccountManager.h"
#import "AccountModel.h"
#import "MMAColors.h"
#import "UIImageView+CornerRadius.h"
#import "TTDateUtils.h"
#import "MMAConfig.h"
#import "UserSettingViewModel.h"
#import "UserSettingModel.h"
#import "UIImage+Utils.h"

static NSString *const kMMAMaterialsLeftViewCellReuseIdentifier = @"kMMAMaterialsLeftViewCellReuseIdentifier";

@interface MaterialsLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

//container view
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewWidth;
@property (weak, nonatomic) IBOutlet UIView *containerView;
//head view
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *headNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *headBirthdayLabel;
//table view
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//data
@property (nonatomic, strong) AccountModel *account;
//viewModel
@property (nonatomic, strong) UserSettingViewModel *leftViewModel;
//data
@property (nonatomic, copy) NSArray *leftViewModelArray;
@end

@implementation MaterialsLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessor
- (AccountModel *)account{
    return [[MMAAccountManager sharedManager] accountModel];
}

- (UserSettingViewModel *)leftViewModel{
    if (!_leftViewModel) {
        _leftViewModel = [UserSettingViewModel sharedViewModel];
    }
    return _leftViewModel;
}

- (NSArray *)leftViewModelArray{
    if (!_leftViewModelArray) {
        _leftViewModelArray = [self.leftViewModel getCurrentLeftViewInfo];
    }
    return _leftViewModelArray;
}

#pragma mark - setup subviews
- (void)setupSubViews{
    [self setupContainerbViews];
    [self setupHeadViews];
    [self setupTablebViews];
}

- (void)setupContainerbViews{
    self.view.backgroundColor = MMA_BLACK_DARK;
    self.containerView.backgroundColor = MMA_BLACK_DARK;
    self.containerViewWidth.constant = LEFT_CONTAINER_VIEW_WIDTH;
}

- (void)setupHeadViews{
    self.headView.backgroundColor = MMA_BLACK_DARK;
    self.headImageView.image = [UIImage imageNamed:@"default_avatar_image"];
    [self.headImageView zy_cornerRadiusRoundingRect];
    self.headNameLabel.text = self.account.saccount ? self.account.saccount : @"panhuohua";
    self.headBirthdayLabel.text = self.account.sbirth ? self.account.sbirth.stringForTimeYYYYMMDD : @"2015-09-21";
}

- (void)setupTablebViews{
    self.tableView.backgroundColor = MMA_BLACK_DARK;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //register cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kMMAMaterialsLeftViewCellReuseIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorInset = UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftViewModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMMAMaterialsLeftViewCellReuseIdentifier forIndexPath:indexPath];
    //setting selected view
    UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
    selectedView.backgroundColor = MMA_GRAY_LEFT_VIEW(0.3);
    cell.selectedBackgroundView = selectedView;
    //data model
    UserSettingModel *model = self.leftViewModelArray[indexPath.row];
    //config cell
    cell.backgroundColor = MMA_BLACK_DARK;
    cell.textLabel.textColor = MMA_WHITE(1);
    cell.textLabel.text = model.name;
    if (model.imageName) {
        cell.imageView.tintColor = MMA_GRAY_LEFT_VIEW(1);
        cell.imageView.image = [UIImage templateImageNamed:model.imageName];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //清除tableview选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
