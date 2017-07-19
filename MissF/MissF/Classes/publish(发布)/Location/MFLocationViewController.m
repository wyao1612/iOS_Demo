//
//  MFLocationViewController.m
//  MissF
//
//  Created by wyao on 2017/7/19.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFLocationViewController.h"
#import "AMapTipAnnotation.h"

@interface MFLocationViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UISearchBarDelegate,UISearchResultsUpdating>
{
    
    NSMutableArray *_dataSource; /**< 数据源 */
    NSMutableArray *_searchResults; /**< 搜索结果 */
}

@property (nonatomic, strong)  UIButton    *leftBtn;
@property (nonatomic, strong)  UISearchController *searchController;
@property (nonatomic, strong)  MAMapView *mapView;
@property (nonatomic, strong)  AMapSearchAPI *search;
@property (nonatomic, strong)  NSMutableArray *tips;
@property (nonatomic, strong)  UITableView *searchListView;

/** 列表头视图 */
@property (nonatomic, strong) UIView *tableHeadView;
/** 蒙版视图 */
@property (nonatomic, strong) UIView *searchView;
/** 搜索框背景颜色 */
@property (nonatomic, strong) UIImage *searchGrayImage;
/** 搜索框背景颜色 */
@property (nonatomic, strong) UIImage *searchWhiteImage;
@end

#define BusLinePaddingEdge 20
@implementation MFLocationViewController

- (id)init{
    if (self = [super init])
    {
        self.tips = [NSMutableArray array];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAutoBack = NO;
    [self setNav];
}

-(void)setNav{
    self.name = @"区域";
    [self setNavLeftItem];
    [self setNavRightItem];
    [self initTableView];
    self.definesPresentationContext = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.searchController.active = NO;
}

-(void)searchViewTap:(UITapGestureRecognizer*)tap{
    [self.searchController.searchBar resignFirstResponder];
    [self.searchView removeFromSuperview];
    self.searchController.active = NO;
    [self viewDidLayoutSubviews];
}



#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //提示搜索
    if (searchController.isActive && searchController.searchBar.text.length > 0){
        //[self searchTipsWithKey:searchController.searchBar.text];
//        [self.searchView removeFromSuperview];
    }else if (searchController.isActive && searchController.searchBar.text.length == 0){
//        [self.view addSubview:self.searchView];
    }
    //刷新表格
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews{
    
    if (self.searchController.active) {
        [self.tableView setFrame:CGRectMake(0, 20, SCREEN_WIDTH, self.view.height - 20)];
    }else{
        self.tableView.frame = self.view.bounds;
    }
    
    if (self.searchController.isActive && self.searchController.searchBar.text.length > 0){
        //[self searchTipsWithKey:searchController.searchBar.text];
        [self.searchView removeFromSuperview];
    }else if (self.searchController.isActive && self.searchController.searchBar.text.length == 0){
        [self.view insertSubview:self.searchView belowSubview:self.searchController.searchBar];
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    cell.textLabel.text = @(indexPath.row).description;
    return cell;
}

#pragma mark - searchBardelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    searchBar.showsCancelButton = YES; //显示“取消”按钮
    for(id cc in [searchBar subviews])
    {
        for (UIView *view in [cc subviews]) {
            if ([NSStringFromClass(view.class)   isEqualToString:@"UINavigationButton"])
            {
                UIButton *btn = (UIButton *)view;
                [btn setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
    }
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
     searchBar.showsCancelButton = NO;
     [self.searchView removeFromSuperview];
    //黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    
}

-(void)setNavLeftItem{

    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBarItem, nil];

}

-(void)setNavRightItem{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarItemClick)];
    [rightBarItem setTintColor:[UIColor whiteColor]];
    [rightBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -5;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightBarItem, nil];
}



#pragma mark - 放回按钮
-(void)backItemClick{
     [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 右侧按钮
-(void)rightBarItemClick{

}

#pragma mark - Initialization

- (void)initTableView
{
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.view.size.height - 340);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"test"];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeadView;
}

/** 搜索框*/
- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchBar.delegate = self;
        _searchController.searchResultsUpdater= self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        [_searchController.searchBar sizeToFit];
        _searchController.searchBar.placeholder = @"请输入搜索区域";
        _searchController.searchBar.tintColor =  GLOBALCOLOR;//修改取消字体颜色
        _searchController.searchBar.layer.cornerRadius = 3;
        _searchController.searchBar.layer.masksToBounds = YES;
        [_searchController.searchBar sizeToFit];
        UIOffset offset = {10.0,0};
        _searchController.searchBar.searchTextPositionAdjustment = offset;
        _searchController.searchBar.backgroundImage = self.searchGrayImage;
        _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchController.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;//关闭提示
        _searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;//关闭自动首字母大写
        [_searchController.searchBar setSearchFieldBackgroundImage:self.searchWhiteImage forState:UIControlStateNormal];
        UITextField *searchField = [_searchController.searchBar valueForKey:@"searchField"];
        
        if (searchField) {
            [searchField setBackgroundColor:[UIColor whiteColor]];
            searchField.layer.cornerRadius = 5.0f;
            searchField.layer.borderColor = GRAYCOLOR.CGColor;
            searchField.layer.borderWidth = 1;
            searchField.layer.masksToBounds = YES;
        }
        
    }
    return _searchController;
}


- (UIImage *)searchGrayImage{
    if (!_searchGrayImage) {
        _searchGrayImage = [UIImage imageWithColor:[UIColor colorWithHexString:@"f4f4f4"] size:CGSizeMake(SCREEN_WIDTH - 14, 26)];
    }
    return _searchGrayImage;
}

- (UIImage *)searchWhiteImage{
    if (!_searchWhiteImage) {
        _searchWhiteImage = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREEN_WIDTH - 14, 26)];
    }
    return _searchWhiteImage;
}



#pragma mark - 懒加载控件
-(UIButton *)leftBtn{
    
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = FONT(15);
        _leftBtn.titleLabel.textColor = WHITECOLOR;
        [_leftBtn addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (MAMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),340)];
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mapView.delegate = self;
        //YES 为打开定位，NO为关闭定位
        _mapView.showsUserLocation = YES;
        //地图跟着位置移动
        [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:NO];
        //后台定位
        _mapView.pausesLocationUpdatesAutomatically = NO;
        
    }
    return _mapView;
}

- (AMapSearchAPI *)search{
    if (!_search) {
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}


- (UIView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        _tableHeadView.backgroundColor = [UIColor whiteColor];
        UIView *grayBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        [_tableHeadView addSubview:grayBgView];
        //输入框
        [grayBgView addSubview:self.searchController.searchBar];
    }
    return _tableHeadView;
}
-(UIView *)searchView{
    if (!_searchView) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, self.view.height)];
        _searchView.backgroundColor = COVERBACKGROUND;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchViewTap:)];
        [_searchView addGestureRecognizer:tap];
    }
    return _searchView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
