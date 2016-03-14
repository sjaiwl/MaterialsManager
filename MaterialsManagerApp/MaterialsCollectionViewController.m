//
//  MaterialsCollectionViewController.m
//  MaterialsManagerApp
//
//  Created by 王林 on 16/3/6.
//  Copyright © 2016年 sjaiwl. All rights reserved.
//

#import "MaterialsCollectionViewController.h"
#import "MaterialsCollectionViewCell.h"
#import "MMAColors.h"
#import "MMAConstants.h"
#import "CategoryViewModel.h"
#import "UserCenterViewController.h"
#import "UIViewController+Utils.h"
#import "UINavigationBar+Utils.h"
#import "TaskListViewController.h"
#import "UIImage+Utils.h"
#import "IIViewDeckController.h"
#import "MMAConfig.h"

@interface MaterialsCollectionViewController ()<UICollectionViewDelegateFlowLayout>

//data
@property (nonatomic, strong) CategoryViewModel *viewModel;
@property (nonatomic, copy) NSArray *categoryModelArray;

//view controller
@property (nonatomic, strong) UserCenterViewController *userCenterViewController;
@end

@implementation MaterialsCollectionViewController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self initObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - accessor
- (CategoryViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [CategoryViewModel sharedViewModel];
    }
    return _viewModel;
}

- (NSArray *)categoryModelArray{
    if (!_categoryModelArray) {
        _categoryModelArray = [self.viewModel getCurrentCategoryFromLocal];
    }
    return _categoryModelArray;
}

- (UserCenterViewController *)userCenterViewController{
    if (!_userCenterViewController) {
        _userCenterViewController = [UserCenterViewController loadNib];
    }
    return _userCenterViewController;
}

#pragma mark - setup subViews
- (void)setupSubViews{
    [self setupNavigationViews];
    [self setupCollectionViews];
}

- (void)setupNavigationViews{
    self.navigationItem.title = @"资产盘点";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"user_setting_avatar"] style:UIBarButtonItemStylePlain target:self action:@selector(userCenterAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_bar_sidebar"] style:UIBarButtonItemStylePlain target:self action:@selector(openLeftViewControllerAction:)];
}

- (void)setupCollectionViews{
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MaterialsCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:MaterialsCollectionViewCellIdentifier];
}

#pragma mark - init observer
- (void)initObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAccountSignIn:) name:kMMAAccountDidSignInNotification object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAccountSignOut:) name:kMMAAccountDidSignOutNotification object:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MaterialsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MaterialsCollectionViewCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    [cell configCellWithCategoryModel:self.categoryModelArray[indexPath.row]];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((IPHONE_SCREEN_WIDTH - 60) / 3.0, 200);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10 ,10);
}

#pragma mark <UICollectionViewDelegate>
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TaskListViewController *taskListViewController = [TaskListViewController loadNib];
        //push
        [self.navigationController pushViewController:taskListViewController animated:YES];
    }
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}


#pragma mark - user center action
- (void)userCenterAction:(UIBarButtonItem *)sender{
    [self.navigationController pushViewController:self.userCenterViewController animated:YES];
}

- (void)openLeftViewControllerAction:(UIBarButtonItem *)sender{
    IIViewDeckController *deckController = nil;
    if ([self.parentViewController.parentViewController isKindOfClass:[IIViewDeckController class]]) {
        deckController = (IIViewDeckController *)self.parentViewController.parentViewController;
    }
    [deckController openLeftViewAnimated:YES];
}

#pragma mark - observer action
- (void)didAccountSignIn:(NSNotification *)notification{

}

- (void)didAccountSignOut:(NSNotification *)notification{
    IIViewDeckController *deckController = nil;
    if ([self.parentViewController.parentViewController isKindOfClass:[IIViewDeckController class]]) {
        deckController = (IIViewDeckController *)self.parentViewController.parentViewController;
    }
    [deckController dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kMMANavigationControllerDidDismissedNotification object:nil];
    }];
}
@end
