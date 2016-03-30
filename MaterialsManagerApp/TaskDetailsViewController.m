//
//  TaskDetailsViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "TaskDetailsViewController.h"
#import "TaskDetailsTableViewCell.h"
#import "TaskModel.h"
#import "TTDateUtils.h"

@interface TaskDetailsViewController ()

@property (nonatomic, strong) TaskModel *originModel;

@property (nonatomic, strong) TaskModel *revisedTask;

@end

@implementation TaskDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup subViews
- (void)setupSubViews{
    [self setupNavigationViews];
    [self setupTableViews];
}

- (void)setupNavigationViews{
    self.navigationItem.title = @"任务详情";
}

- (void)setupTableViews{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TaskDetailsTableViewCell class]) bundle:nil] forCellReuseIdentifier:kMMATaskDetailsTableViewCellIdentifier];
}

#pragma mark - init method
- (void)initWithTaskModel:(TaskModel *)taskModel{
    self.originModel = taskModel;
    self.revisedTask = taskModel.copy;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMMATaskDetailsTableViewCellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    switch (indexPath.row) {
        case 0:
            [cell configCellWithDescribeString:@"巡检员工:" contentString:self.revisedTask.hmmsStaffName];
            break;

        case 1:
            [cell configCellWithDescribeString:@"任务:" contentString:self.revisedTask.hmmsSpecialName];
            break;

        case 2:
            [cell configCellWithDescribeString:@"下达人:" contentString:self.revisedTask.hmmsStaffByTassignsName];
            break;

        case 3:
            [cell configCellWithDescribeString:@"任务开始时间:" contentString:self.revisedTask.tinspectionbegintime.stringForTimeYYYYMMDD];
            break;

        case 4:
            [cell configCellWithDescribeString:@"任务修改时间:" contentString:self.revisedTask.tmodifiedtime.stringForTimeYYYYMMDD];
            break;

        case 5:
            [cell configCellWithDescribeString:@"任务类别:" contentString:[self getTaskTypeStringWithType : self.self.revisedTask.ttype]];
            break;

        case 6:
            [cell configCellWithDescribeString:@"任务状态:" contentString:[self getStatusString : self.self.revisedTask.tstatus]];
            break;

        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMMTaskDetailsTableViewCellHeight;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //清除tableview选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
   [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - public method
- (NSString *)getTaskTypeStringWithType:(NSString *)type{
    NSDictionary *dic = @{@"1" : @"常规巡检",
                          @"2" : @"临时巡检",
                          @"3" : @"跳过"
                          };
    return dic[type];
}

- (NSString *)getStatusString:(NSString *)status{
    NSDictionary *dic = @{@"0" : @"未下达",
                          @"1" : @"未获取",
                          @"2" : @"执行中",
                          @"3" : @"已完成",
                          @"4" : @"已取消",
                          };
    return dic[status];
}

@end
