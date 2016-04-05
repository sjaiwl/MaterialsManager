//
//  MMASelectItemViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/30.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MMASelectItemViewController.h"
#import "MMAColors.h"
#import "MMASelectItemViewCell.h"
#import "MMAConfig.h"
#import "ItemListViewModel.h"
#import "AccountModel.h"

@interface MMASelectItemViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

//data
@property (nonatomic, strong) NSNumber* currentStaffID;
@property (nonatomic, strong) NSNumber* currentWorkTypeID;
@property (nonatomic, strong) NSIndexPath *currentSelectIndexPath;
@property (nonatomic, strong) AccountModel *currentSelectAccount;
@property (nonatomic, copy) MMASelectItemViewCancelHandle cancelHandle;
@property (nonatomic, copy) MMASelectItemViewDoneHandle doneHandle;

@property (nonatomic ,copy) NSArray *staffArray;

@property (nonatomic, strong)ItemListViewModel *viewModel;
@end

@implementation MMASelectItemViewController

- (instancetype)initWithCurrentSid:(NSNumber *)sid workTypeID:(NSNumber *)wid  cancelHandle:(MMASelectItemViewCancelHandle)cancelHandle doneHandle:(MMASelectItemViewDoneHandle)doneHandle{
    if (self = [super init]) {
        _currentStaffID = sid;
        _currentWorkTypeID = wid;
        _cancelHandle = cancelHandle;
        _doneHandle = doneHandle;
        [self getDataSource];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self sutupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessor
- (ItemListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [ItemListViewModel sharedViewModel];
    }
    return _viewModel;
}

#pragma mark - set up
- (void)sutupSubViews{
    [self setupTopView];
    [self setupCollectionView];
}

- (void)setupTopView{
    self.titleLabel.textColor = MMA_BLACK(1);
}

- (void)setupCollectionView{
    //设置collectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.collectionViewLayout = flowLayout;
    //设置数据源和代理
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    //设置背景颜色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MMASelectItemViewCell class]) bundle:nil] forCellWithReuseIdentifier:kMMASelectItemViewCellIdentifier];
}

#pragma mark - get data
- (void)getDataSource{
    [self.viewModel reloadWorkTypeInformation];
    self.staffArray = [self.viewModel getCurentWorkTypeStaffByWID:self.currentWorkTypeID];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - collectionView的数据源和代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.staffArray.count;
}
//设置cell
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MMASelectItemViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMMASelectItemViewCellIdentifier forIndexPath:indexPath];
    //config cell
    AccountModel *model = self.staffArray[indexPath.row];
    [cell configCellWithAccountModel:model currentStaffID:self.currentStaffID];
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView.backgroundColor = MMA_BLACK(0.5);
    if (model.sid == self.currentStaffID) {
        self.currentSelectIndexPath = indexPath;
        self.currentSelectAccount = model;
    }
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((IPHONE_SCREEN_WIDTH - 60) / 4.0, 80);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10 ,10);
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentSelectIndexPath != indexPath) {
        NSLog(@"%@",self.currentSelectIndexPath);
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:self.currentSelectIndexPath];
        cell.selected = NO;
        self.currentSelectIndexPath = indexPath;
        self.currentSelectAccount = self.staffArray[indexPath.row];
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - Public
- (CGFloat)heightForDisplay {
    return self.view.frame.size.height;
}

- (void)refreshCurrentViewData{
    [self.collectionView reloadData];
}

- (IBAction)cancelAction:(UIButton *)sender {
    self.cancelHandle();
}

- (IBAction)doneAction:(UIButton *)sender {
    self.doneHandle(self.currentSelectAccount);
}
@end
