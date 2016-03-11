//
//  TaskListViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "TaskListViewController.h"
#import "TaskTableViewCell.h"
#import "TaskTableViewSectionView.h"
#import "UIColor+Hex.h"
#import "UIView+Utils.h"
#import "TaskDetailsViewController.h"
#import "UIViewController+Utils.h"
#import "AddTaskViewController.h"
#import "MMANavViewController.h"
#import "TaskModel.h"
#import "TaskListViewModel.h"
#import "MMALogs.h"

@interface TaskListViewController ()
//details controller
@property (nonatomic, strong) TaskDetailsViewController *taskDetailsController;
//add task controller
@property (nonatomic, strong) AddTaskViewController *addTaskController;

@property (nonatomic, strong) TaskListViewModel *viewModel;
@property (nonatomic, copy) NSArray *taskModelArray;

@end

@implementation TaskListViewController

#pragma mark - Accessor
- (TaskDetailsViewController *)taskDetailsController{
    if (!_taskDetailsController) {
        _taskDetailsController = [TaskDetailsViewController loadNib];
    }
    return _taskDetailsController;
}

- (AddTaskViewController *)addTaskController{
    if (!_addTaskController) {
        _addTaskController = [AddTaskViewController loadNib];
    }
    return _addTaskController;
}

- (TaskListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [TaskListViewModel sharedViewModel];
    }
    return _viewModel;
}

- (NSArray *)taskModelArray{
    if (!_taskModelArray) {
        _taskModelArray = [self.viewModel getCurrentTaskModels];
    }
    return _taskModelArray;
}

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

#pragma mark - setup subviews
- (void)setupSubViews{
    [self setupNavigationViews];
    [self setupTableViews];
}

- (void)setupNavigationViews{
    self.navigationItem.title = @"任务下达";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTask:)];
}

- (void)setupTableViews{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TaskTableViewCell class]) bundle:nil] forCellReuseIdentifier:kMMATaskTableViewCellIdentifier];

//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TaskTableViewSectionView class]) bundle:nil] forCellReuseIdentifier:kMMATaskTableViewSectionViewIdentifier];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taskModelArray.count;
}

//cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMMATaskTableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMMATaskTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    TaskModel *model = self.taskModelArray[indexPath.row];
    [cell configCellWithTaskModel:model];
    return cell;
}

//section
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *sectionView = [tableView dequeueReusableCellWithIdentifier:kMMATaskTableViewSectionViewIdentifier];
//    return sectionView;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return kMMATaskTableViewSectionViewHeight;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"任务排班表";
    }
    return nil;
}

#pragma mark - Tableview delegate
// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    TaskModel *model = self.taskModelArray[indexPath.row];
    // Pass the selected object to the new view controller.
    [self.taskDetailsController initWithTaskModel:model];
    
    // Push the view controller.
    [self.navigationController pushViewController:self.taskDetailsController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - bar button action
- (void)addTask:(UIBarButtonItem *)sender{
    MMANavViewController *nav = [[MMANavViewController alloc] initWithRootViewController:self.addTaskController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
