//
//  MFHousingResourcesTableViewController.m
//  MissF
//
//  Created by wyao on 2017/7/7.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFHousingListViewController.h"
#import "MFHouseListCell.h"
#import "MFHouseListModel.h"
#import "MFHouseBottomView.h"
#import "MFHouseViewModel.h"
#import "MFHouseTableViewProxy.h"

@interface MFHousingListViewController ()<MFHouseViewModelDelegate>
/** 底部删除编辑视图 */
@property (nonatomic, copy) MFHouseBottomView * houseBottomView;
/** 负责逻辑处理 */
@property (nonatomic, strong) MFHouseViewModel *houseViewModel;
/** tableView代理 */
@property (nonatomic, strong) MFHouseTableViewProxy *houseTableViewProxy;
@end

@implementation MFHousingListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isExpandItem = NO;
    [self.view addSubview:self.houseTableView];
    [self layoutSubview];
    [self requestShopcartListData];
}

-(void)setIsExpandItem:(BOOL)isExpandItem{
    _isExpandItem = isExpandItem;
    
    self.houseTableViewProxy.isExpend = isExpandItem;
    
    if (isExpandItem == YES) {
        self.houseTableView.mj_header = nil;
        self.houseTableView.mj_footer = nil;
    }else{
        
        weak(self);
        //设置下拉刷新
        _houseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.houseViewModel requestDataWithRet:YES];
            [weakSelf.houseTableView.mj_header endRefreshing];
        }];
        _houseTableView.mj_header.automaticallyChangeAlpha = YES;
        
        //设置上拉加载更多
        _houseTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.houseViewModel requestDataWithRet:NO];
            [weakSelf.houseTableView.mj_footer endRefreshing];
        }];
        
    }
    
    [self.houseTableView reloadData];
}

#pragma mark - MFHouseViewModel delegate
- (void)requestShopcartListData {
    [self.houseViewModel requestDataWithRet:YES];
}

-(void)houseListModelRequestDidSuccessWithArray:(NSMutableArray *)dataArray{
    self.houseTableViewProxy.dataArray = dataArray;
    [self.houseTableView reloadData];
}


- (void)houseListModelRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray{
    
}
- (void)houseViewModelTotalCount:(NSInteger)totalCount isAllSelected:(BOOL)isAllSelected{
    NSLog(@"%zd",totalCount);
    [self updateBottomViewWithCount:totalCount];
}

- (void)houseListModelWillDeleteSelectedProducts:(NSArray *)selectedProducts{
    
    if (selectedProducts.count == 0) {
        return;
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确认要删除这%ld个房源吗？", selectedProducts.count] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.houseViewModel deleteSelectedProducts:selectedProducts];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)houseListModelHasDeleteAllProducts{
    [self.houseTableView reloadData];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %@", @(buttonIndex));
}


#pragma mark getters
- (UITableView *)houseTableView {
    if (_houseTableView == nil){
        _houseTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _houseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_houseTableView registerClass:[MFHouseListCell class] forCellReuseIdentifier:@"MFHouseListCell"];
        _houseTableView.showsVerticalScrollIndicator = NO;
        _houseTableView.backgroundColor = BACKGROUNDCOLOR;
        _houseTableView.delegate = self.houseTableViewProxy;
        _houseTableView.dataSource = self.houseTableViewProxy;
        _houseTableView.sectionFooterHeight = 10;
        _houseTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        _houseTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        
        weak(self);
        //设置下拉刷新
        _houseTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.houseViewModel requestDataWithRet:YES];
            [weakSelf.houseTableView.mj_header endRefreshing];
        }];
        _houseTableView.mj_header.automaticallyChangeAlpha = YES;
        
        //设置上拉加载更多
        _houseTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.houseViewModel requestDataWithRet:NO];
            [weakSelf.houseTableView.mj_footer endRefreshing];
        }];
        
        [_houseTableView.mj_header beginRefreshing];
    }
    return _houseTableView;
}

- (MFHouseTableViewProxy *)houseTableViewProxy {
    if (_houseTableViewProxy == nil){
        _houseTableViewProxy = [[MFHouseTableViewProxy alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        
        _houseTableViewProxy.HouseProxySelectBlock = ^(BOOL isSelected, NSIndexPath *indexPath){
            [weakSelf.houseViewModel selectProductAtIndexPath:indexPath isSelected:isSelected];
        };
        
        _houseTableViewProxy.HouseProxyPublishBlock = ^(UIButton *sender, NSIndexPath *indexPath) {
            [weakSelf.houseViewModel publishSelectedProduct:indexPath];
        };

        _houseTableViewProxy.HouseProxyDeleteBlock = ^(NSIndexPath *indexPath){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认要删除这个宝贝吗？" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.houseViewModel deleteProductAtIndexPath:indexPath];
            }]];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        };
    }
    return _houseTableViewProxy;
}


- (MFHouseBottomView *)houseBottomView {
    if (_houseBottomView == nil){
        _houseBottomView = [[MFHouseBottomView alloc] init];
        _houseBottomView.backgroundColor = GLOBALCOLOR;
        _houseBottomView.hidden = NO;
        
        __weak __typeof(self) weakSelf = self;
        _houseBottomView.shopcartBotttomViewDeleteBlock = ^(){
            [weakSelf.houseViewModel beginToDeleteSelectedProducts];
        };
    }
    return _houseBottomView;
}

- (MFHouseViewModel *)houseViewModel {
    if (_houseViewModel == nil){
        _houseViewModel = [[MFHouseViewModel alloc] init];
        _houseViewModel.delegate = self;
    }
    return _houseViewModel;
}


- (void)layoutSubview {
    
    self.houseTableView.sd_layout
    .topSpaceToView(self.view, 0)
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
}

-(void)updateBottomViewWithCount:(NSInteger)count{
    
        if (count>0) {
            
            self.houseTableView.sd_resetLayout
            .topSpaceToView(self.view, 0)
            .leftSpaceToView(self.view, 0)
            .rightSpaceToView(self.view, 0)
            .bottomSpaceToView(self.view, 50);
            
            [self.view addSubview:self.houseBottomView];
            
            self.houseBottomView.sd_layout
            .leftSpaceToView(self.view, 0)
            .rightSpaceToView(self.view, 0)
            .bottomSpaceToView(self.view, 0)
            .heightIs(50);
            
        }else{
            
            self.houseTableView.sd_resetLayout
            .topSpaceToView(self.view, 0)
            .leftSpaceToView(self.view, 0)
            .rightSpaceToView(self.view, 0)
            .bottomSpaceToView(self.view, 0);
            
            if (self.houseBottomView) {
                [self.houseBottomView removeFromSuperview];
            }
        }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
