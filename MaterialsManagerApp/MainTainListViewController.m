//
//  MainTainListViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MainTainListViewController.h"
#import "UITableView+EmptyData.h"
#import "MMALogs.h"
#import "SRRefreshView.h"
#import "MMAColors.h"
#import "MainTainListViewModel.h"
#import "MainTainTableViewCell.h"
#import "MainTainModel.h"
#import "MainTainDetailsViewController.h"
#import "UIViewController+Utils.h"

@interface MainTainListViewController ()<SRRefreshDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) SRRefreshView *slimeRefreshView;
@property (nonatomic, strong) MainTainDetailsViewController *detailsViewController;

//data
@property (nonatomic, strong) NSMutableArray *todayListArray;
@property (nonatomic, strong) NSMutableArray *notDoneListArray;
@property (nonatomic, strong) MainTainListViewModel *viewModel;

// Sync
@property (nonatomic, assign) BOOL reloading;

@end

@implementation MainTainListViewController

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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self doneLoadingTableViewData:@(YES)];
}

#pragma mark - Accessor
- (UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"已维修",@"未维修"]];
        [_segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
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

- (MainTainListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [MainTainListViewModel sharedViewModel];
    }
    return _viewModel;
}

- (NSMutableArray *)todayListArray{
    if (!_todayListArray) {
        _todayListArray = [NSMutableArray new];
    }
    return _todayListArray;
}

- (NSMutableArray *)notDoneListArray{
    if (_notDoneListArray) {
        _todayListArray = [NSMutableArray new];
    }
    return _notDoneListArray;
}

- (MainTainDetailsViewController *)detailsViewController{
    if (!_detailsViewController) {
        _detailsViewController = [MainTainDetailsViewController loadNib];
    }
    return _detailsViewController;
}

#pragma mark - setup subViews
- (void)setupSubViews{
    [self setupNavigationBar];
    [self setupTableViews];
    //refresh data
    [self refreshData];
}

- (void)setupNavigationBar{
    self.navigationItem.titleView = self.segmentedControl;
    self.segmentedControl.selectedSegmentIndex = 0;
    [self didClicksegmentedControlAction:self.segmentedControl];
}

- (void)setupTableViews{
    //register cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainTainTableViewCell class]) bundle:nil] forCellReuseIdentifier:kMMAMainTainTableViewCellIdentifier];
    //add slime view
    [self.tableView addSubview:self.slimeRefreshView];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //update slime view
    [self.slimeRefreshView update:64];
}

- (void)refreshData{
    __weak MainTainListViewController *weakSelf = self;
    [self.viewModel getCurrentMainTainModelsWithType:0 success:^(BOOL successfully, NSArray *result) {
        if (successfully) {
            weakSelf.todayListArray = result.mutableCopy;
        }

    } failure:^(BOOL successfully, NSError *error) {

    }];

    [self.viewModel getCurrentMainTainModelsWithType:1 success:^(BOOL successfully, NSArray *result) {
        if (successfully) {
            weakSelf.notDoneListArray = result.mutableCopy;
        }
    } failure:^(BOOL successfully, NSError *error) {

    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.segmentedControl.selectedSegmentIndex == 0 ? self.todayListArray.count : self.notDoneListArray.count;
    [tableView tableViewDisplayWitMsg:@"没有相关记录" ifNecessaryForRowCount:count];
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     MainTainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMMAMainTainTableViewCellIdentifier forIndexPath:indexPath];

    MainTainModel *model = nil;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        model = self.todayListArray[indexPath.row];
    }else{
        model = self.notDoneListArray[indexPath.row];
    }
    
    // Configure the cell...
    [cell configCellWithMainTainModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMMAMainTainTableViewCellHeight;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    __weak MainTainListViewController *weakSelf = self;
    MainTainModel *model = nil;
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        model = self.todayListArray[indexPath.row];
    }else{
        model = self.notDoneListArray[indexPath.row];
    }
    
    // Pass the selected object to the new view controller.
    [self.detailsViewController initWithMainTainModel:model changeActionBlock:^(id selected) {
        MainTainModel *changeModel = (MainTainModel *)selected;
        if (selected != nil && changeModel.sid != model.sid) {
            DLog(@"%@", changeModel);
            [weakSelf.notDoneListArray replaceObjectAtIndex:indexPath.row withObject:changeModel];
            [weakSelf refreshTableViewData];
        }
    }];

    // Push the view controller.
    [self.navigationController pushViewController:self.detailsViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
    __weak MainTainListViewController *weakSelf = self;
    [self.viewModel getCurrentMainTainModelsWithType:self.segmentedControl.selectedSegmentIndex success:^(BOOL successfully, NSArray *result) {
        if (successfully) {
            if (weakSelf.segmentedControl.selectedSegmentIndex == 0) {
                weakSelf.todayListArray = result.mutableCopy;
            }else{
                weakSelf.notDoneListArray = result.mutableCopy;
            }
            [weakSelf doneLoadingTableViewData:@(YES)];
            [weakSelf refreshTableViewData];
        }
    } failure:^(BOOL successfully, NSError *error) {
        DLog(@"%@",error);
        [weakSelf doneLoadingTableViewData:@(YES)];
    }];
}

- (void)doneLoadingTableViewData:(NSNumber *)isFocusSync {
    self.reloading = NO;
    [self.slimeRefreshView endRefresh];
    self.tableView.showsVerticalScrollIndicator = YES;
}

#pragma mark - TableView ReloadData
- (void)refreshTableViewData{
    [self.tableView reloadData];
}

#pragma mark - action
-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    NSInteger Index = Seg.selectedSegmentIndex;
    switch (Index) {
        case 0:
            [self showTodayDoneMaintainListView];
            break;
        case 1:
            [self showNotDoneMaintainListView];
            break;
        default:
            break;
    }
}

- (void)showTodayDoneMaintainListView{
    [self refreshTableViewData];
}

- (void)showNotDoneMaintainListView{
    [self refreshTableViewData];
}

@end
