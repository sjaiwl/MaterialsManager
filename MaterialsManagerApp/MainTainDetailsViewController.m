//
//  MainTainDetailsViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MainTainDetailsViewController.h"
#import "MainTainModel.h"
#import "TaskDetailsTableViewCell.h"
#import "TTDateUtils.h"
#import "MMATableViewHeaderFooterView.h"
#import "MMAColors.h"
#import "UIButton+Utils.h"
#import "MMATableViewFootView.h"
#import "UIView+Utils.h"
#import "MMAConfig.h"
#import "MMASheetView.h"
#import "MMASelectItemViewController.h"

@interface MainTainDetailsViewController ()<MMATableViewFootViewDelegate>

@property (nonatomic, strong) MMATableViewFootView *footView;

@property (nonatomic, strong) MainTainModel *originModel;

@property (nonatomic, strong) MainTainModel *revisedTask;

//sheet view
@property (nonatomic, strong) MMASheetView *sheetView;
@property (nonatomic, strong) MMASelectItemViewController *actionActivityViewController;

@end

@implementation MainTainDetailsViewController

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

- (MMATableViewFootView *)footView{
    if (!_footView) {
        _footView = [[MMATableViewFootView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_SCREEN_WIDTH, 50)];
    }
    return _footView;
}

#pragma mark - setup subViews
- (void)setupSubViews{
    [self setupNavigationViews];
    [self setupTableViews];
}

- (void)setupNavigationViews{
    self.navigationItem.title = @"维修详情";
}

- (void)setupTableViews{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TaskDetailsTableViewCell class]) bundle:nil] forCellReuseIdentifier:kMMATaskDetailsTableViewCellIdentifier];

    [self.tableView registerClass:[MMATableViewHeaderFooterView class]forHeaderFooterViewReuseIdentifier:kMMATableViewHeaderFooterViewReuseIdentifier];
}

//init
- (void)initWithMainTainModel:(MainTainModel *)mainTainModel{
    self.originModel = mainTainModel;
    self.revisedTask = mainTainModel.copy;
    [self addFootViewIfNeeded];
    [self.tableView reloadData];
}

- (void)addFootViewIfNeeded{
    if ([self.revisedTask.mstatus isEqualToString:@"0"]) {
        self.footView.delegate = self;
        self.tableView.tableFooterView = self.footView;
    }else{
        self.tableView.tableFooterView = nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kMMATableViewHeaderFooterViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *array = @[@"任务信息", @"维修信息"];
    MMATableViewHeaderFooterView *headerView =
    [tableView dequeueReusableHeaderFooterViewWithIdentifier:kMMATableViewHeaderFooterViewReuseIdentifier];
    headerView.contentView.backgroundColor = MMA_WHITE(1.f);
    headerView.viewForBackgroundColor.backgroundColor = MMA_WHITE(1.f);
    headerView.viewForBackgroundColor.hidden = NO;
    headerView.titleLabel.textColor = MMA_BLUE(1.f);
    headerView.titleFont = [UIFont systemFontOfSize:17.f];
    headerView.title = array[section];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMMATaskDetailsTableViewCellIdentifier forIndexPath:indexPath];
    if (indexPath.section == 0) {
        //任务信息
        // Configure the cell...
        switch (indexPath.row) {
            case 0:
                [cell configCellWithDescribeString:@"异常项:" contentString:self.revisedTask.tderroritems];
                break;

            case 1:
                [cell configCellWithDescribeString:@"异常描述:" contentString:self.revisedTask.tderrordescribe];
                break;

            case 2:
                [cell configCellWithDescribeString:@"位置:" contentString:self.revisedTask.pposition];
                break;

            case 3:
                [cell configCellWithDescribeString:@"报修时间:" contentString:self.revisedTask.mrepairtime.stringForTimeYYYYMMDD];
                break;

            default:
                break;
        }

    }else if (indexPath.section == 1){
        //维修信息
        switch (indexPath.row) {
            case 0:
                [cell configCellWithDescribeString:@"维修员工:" contentString:self.revisedTask.sname];
                break;

            case 1:
                if(self.revisedTask.mmaintaintime) {
                    [cell configCellWithDescribeString:@"维修时间:" contentString:self.revisedTask.mmaintaintime.stringForTimeYYYYMMDD];
                }else{
                    [cell configCellWithDescribeString:@"维修时间:" contentString:@"无"];
                }
                break;

            case 2:
                [cell configCellWithDescribeString:@"维修状态:" contentString:[self getStatusString:self.revisedTask.mstatus]];
                break;
                
            default:
                break;
        }
    }
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kMMTaskDetailsTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //清除tableview选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *)getStatusString:(NSString *)status{
    NSDictionary *dic = @{@"0" : @"未完成",
                          @"1" : @"已完成"
                          };
    return dic[status];
}

#pragma mark - foot view delegate
- (void)didClickChangeStaffButton:(UIButton *)button{
    __weak MainTainDetailsViewController *weakSelf = self;

    self.actionActivityViewController = [[MMASelectItemViewController alloc] initWithCurrentSid:self.revisedTask.sid cancelHandle:^{
        [weakSelf.sheetView dismiss];
    } doneHandle:^(NSInteger sid) {
        [weakSelf.sheetView dismiss];
    }];

    self.sheetView =
    [[MMASheetView alloc]
     initWithContentView:self.actionActivityViewController.view
     contentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), self.actionActivityViewController.heightForDisplay)
     sheetType:TTSheetViewTypeBottom];
    [self.sheetView show];

}

@end
