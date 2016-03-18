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
#import "MMAColors.h"
#import "SRRefreshView.h"
#import "TTScrollToLoadTableFooterView.h"
#import "UIScrollView+SVInfiniteScrolling.h"

@interface TaskListViewController ()<SRRefreshDelegate,SWTableViewCellDelegate>
//details controller
@property (nonatomic, strong) TaskDetailsViewController *taskDetailsController;
//add task controller
@property (nonatomic, strong) AddTaskViewController *addTaskController;

@property (nonatomic, strong) TaskListViewModel *viewModel;
@property (nonatomic, copy) NSArray *taskModelArray;

@property (nonatomic, strong) SRRefreshView *slimeRefreshView;
// Sync
@property (nonatomic, assign) BOOL reloading;

//foot view
@property (nonatomic, strong) TTScrollToLoadTableFooterView *loadingFooterView;
@property (nonatomic, strong) TTScrollToLoadTableFooterView *viewMoreFooterView;

@property (nonatomic, strong) SWTableViewCell *currentSelectedCell;
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

- (SRRefreshView *)slimeRefreshView {
    if (_slimeRefreshView == nil) {
        _slimeRefreshView = [[SRRefreshView alloc] init];
        _slimeRefreshView.delegate = self;
        _slimeRefreshView.slimeMissWhenGoingBack = YES;
        _slimeRefreshView.slime.bodyColor = MMA_BLACK(1);
        _slimeRefreshView.slime.skinColor = [UIColor whiteColor];
        _slimeRefreshView.slime.lineWith = 1;
        _slimeRefreshView.slime.shadowBlur = 0;

        _slimeRefreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    return _slimeRefreshView;
}

- (TTScrollToLoadTableFooterView *)loadingFooterView {
    if (!_loadingFooterView) {
        _loadingFooterView = [TTScrollToLoadTableFooterView
                              loadFromNibWithState:TTScrollToLoadTableFooterViewStateLoading
                              unlocalizedTitle:@"正在加载..."];
    }
    return _loadingFooterView;
}

- (TTScrollToLoadTableFooterView *)viewMoreFooterView {
    if (!_viewMoreFooterView) {
        _viewMoreFooterView = [TTScrollToLoadTableFooterView
                               loadFromNibWithUnlocalizedTitle:@"查看更多"
                               retryHandler:^{
                                   [self.tableView triggerInfiniteScrolling];
                                   [self doLoadingMoreTask];
                               }];
    }
    return _viewMoreFooterView;
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
    //register cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TaskTableViewCell class]) bundle:nil] forCellReuseIdentifier:kMMATaskTableViewCellIdentifier];
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TaskTableViewSectionView class]) bundle:nil] forCellReuseIdentifier:kMMATaskTableViewSectionViewIdentifier];
    //add slime view
    [self.tableView addSubview:self.slimeRefreshView];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //update slime view
    [self.slimeRefreshView update:64];
    //add scroll footer
    [self addIndiniteScrollingView];
    //add tap gesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.tableView addGestureRecognizer:tapGesture];
}

- (void)tapGestureAction:(UITapGestureRecognizer *)sender{
    [self hideCurrentCellButtonView];
}

- (void)addIndiniteScrollingView{
    __weak TaskListViewController *weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf doLoadingMoreTask];
    }];

    [self.tableView.infiniteScrollingView setCustomView:self.viewMoreFooterView forState:SVInfiniteScrollingStateStopped];

    [self.tableView.infiniteScrollingView setCustomView:self.loadingFooterView forState:SVInfiniteScrollingStateLoading];

    [self.tableView.infiniteScrollingView setCustomView:self.loadingFooterView forState:SVInfiniteScrollingStateTriggered];

    self.tableView.infiniteScrollingView.enabled = YES;
    self.tableView.showsInfiniteScrolling = YES;
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
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    cell.rightUtilityButtons = [self rightButtonsArray];
    cell.delegate = self;
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

#pragma mark - TableView delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isCurrentCellButtonShow]) {
        [self hideCurrentCellButtonView];
        return NO;
    }
    return YES;
}

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //清除tableview选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here, for example:
    // Create the next view controller.
    TaskModel *model = self.taskModelArray[indexPath.row];
    // Pass the selected object to the new view controller.
    [self.taskDetailsController initWithTaskModel:model];
    
    // Push the view controller.
    [self.navigationController pushViewController:self.taskDetailsController animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.slimeRefreshView scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.slimeRefreshView scrollViewDidEndDraging];
}

#pragma mark - SRRefreshDelegate
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView {
    self.reloading = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    __weak TaskListViewController *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf doneLoadingTableViewData:@(YES)];
    });
}

- (void)doneLoadingTableViewData:(NSNumber *)isFocusSync {
    self.reloading = NO;
    [self.slimeRefreshView endRefresh];
    self.tableView.showsVerticalScrollIndicator = YES;
}

#pragma mark -load moretask
- (void)doLoadingMoreTask{
    __weak TaskListViewController *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
        weakSelf.tableView.showsInfiniteScrolling = YES;
    });
}

#pragma mark - SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    switch (index) {
        case 0:
            DLog(@"edit cell task");
            break;

        case 1:
            DLog(@"dele cell task");
            break;

        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state{
    if (kCellStateCenter != state) {
        self.currentSelectedCell = cell;
    }
}
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell{
    return YES;
}
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state{
    return YES;
}

#pragma mark - SWTableViewCell Right Buttons
- (NSArray *)rightButtonsArray
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:MMA_ORANGE(1)
                                                title:@"编辑"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:MMA_RED(1)
                                                title:@"删除"];

    return rightUtilityButtons;
}

#pragma mark - close cell button
- (void)hideCurrentCellButtonView{
    if ([self isCurrentCellButtonShow]) {
        [self.currentSelectedCell hideUtilityButtonsAnimated:YES];
        self.currentSelectedCell = nil;
        return;
    }
}

- (BOOL)isCurrentCellButtonShow{
    return self.currentSelectedCell && ![self.currentSelectedCell isUtilityButtonsHidden];
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
