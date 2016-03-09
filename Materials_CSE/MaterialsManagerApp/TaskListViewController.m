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

@interface TaskListViewController ()

@end

@implementation TaskListViewController

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
    return 10;
}

//cell
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMMATaskTableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMMATaskTableViewCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Configure the cell...
    
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
    TaskDetailsViewController *detailsViewController = [TaskDetailsViewController loadNib];
    // Pass the selected object to the new view controller.

    // Push the view controller.
    [self.navigationController pushViewController:detailsViewController animated:YES];
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
    AddTaskViewController *addTaskViewController = [AddTaskViewController loadNib];
    MMANavViewController *nav = [[MMANavViewController alloc] initWithRootViewController:addTaskViewController];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

@end
