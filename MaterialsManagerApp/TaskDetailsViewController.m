//
//  TaskDetailsViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/7.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "TaskDetailsViewController.h"
#import "TaskDetailsTableViewCell.h"

@interface TaskDetailsViewController ()

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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMMATaskDetailsTableViewCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
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
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
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

@end
