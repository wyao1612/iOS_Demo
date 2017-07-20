//
//  MainViewController.m
//  GDMapPlaceAroundDemo
//
//  Created by Mr.JJ on 16/6/14.
//  Copyright © 2016年 Mr.JJ. All rights reserved.
//

#import "MainViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MapPoiTableView.h"
#import "LocationDetailVC.h"
#import "SearchResultTableVC.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

#define CELL_HEIGHT                     55.f
#define CELL_COUNT                      5
#define TITLE_HEIGHT                    64.f
// 是否为iOS8.4
#define isNotVersion84                  ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.4)

@interface MainViewController () <MAMapViewDelegate,MapPoiTableViewDelegate,AMapSearchDelegate,UISearchBarDelegate,SearchResultTableVCDelegate,UISearchResultsUpdating>
/** 右侧按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) SearchResultTableVC *searchResultTableVC;
/** 搜索框背景颜色 */
@property (nonatomic, strong) UIImage *searchGrayImage;
/** 搜索框背景颜色 */
@property (nonatomic, strong) UIImage *searchWhiteImage;
/** 地图*/
@property (nonatomic, strong) MAMapView *mapView;
/** 搜索视图*/
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation MainViewController
{
    // 地图中心点的标记
    UIImageView *_centerMaker;
    // 地图中心点POI列表
    MapPoiTableView *_tableView;
    // 高德API不支持定位开关，需要自己设置
    UIButton *_locationBtn;
    UIImage *_imageLocated;
    UIImage *_imageNotLocate;
    // 搜索API
    AMapSearchAPI *_searchAPI;
    
    // 第一次定位标记
    BOOL isFirstLocated;
    // 搜索页数
    NSInteger searchPage;

    // 禁止连续点击两次
    BOOL _isMapViewRegionChangedFromTableView;}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"区域";
    self.isAutoBack = NO;
    [self setNotifier];
    [self setNav];
    [self initMapView];
    [self initCenterMarker];
    [self initLocationButton];
    [self initTableView];
    [self initSearch];
}

#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    // 首次定位
    if (updatingLocation && !isFirstLocated) {
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
        isFirstLocated = YES;
    }
}

#pragma mark - 重新定位
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if (!_isMapViewRegionChangedFromTableView && isFirstLocated) {
        AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
        [self searchReGeocodeWithAMapGeoPoint:point];
        [self searchPoiByAMapGeoPoint:point];
        // 范围移动时当前页面数重置
        searchPage = 1;

        NSLog(@"%lf,%lf",_mapView.centerCoordinate.latitude,_mapView.centerCoordinate.longitude);
        NSLog(@"%lf,%lf",_mapView.userLocation.coordinate.latitude,_mapView.userLocation.coordinate.longitude);
        // 设置定位图标
        if (fabs(_mapView.centerCoordinate.latitude-_mapView.userLocation.coordinate.latitude) < 0.0001f && fabs(_mapView.centerCoordinate.longitude - _mapView.userLocation.coordinate.longitude) < 0.0001f) {
            [_locationBtn setImage:_imageLocated forState:UIControlStateNormal];
        }
        else {
            [_locationBtn setImage:_imageNotLocate forState:UIControlStateNormal];
        }
    }
    _isMapViewRegionChangedFromTableView = NO;
}

#pragma mark - 当大头针被加入到地图中的时候就会调用这个方法
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"anntationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
            annotationView.image = [UIImage imageNamed:@"msg_location"];
            annotationView.centerOffset = CGPointMake(0, -18);
        }
        return annotationView;
    }
    return nil;
}

#pragma mark - annotationView已经添加到地图上
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        
        /*
        pre.showsAccuracyRing = NO;
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
         */
        
        [_mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
    }
}

#pragma mark - MapPoiTableViewDelegate
- (void)loadMorePOI
{
    searchPage++;
    AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
    [self searchPoiByAMapGeoPoint:point];
}

#pragma mark - 选择提示信息后重新定位将新位置切换到屏幕中心
- (void)setMapCenterWithPOI:(AMapPOI *)point isLocateImageShouldChange:(BOOL)isLocateImageShouldChange
{
    // 切换定位图标
    if (isLocateImageShouldChange) {
        [_locationBtn setImage:_imageNotLocate forState:UIControlStateNormal];
    }
    _isMapViewRegionChangedFromTableView = YES;
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(point.location.latitude, point.location.longitude);
    [_mapView setCenterCoordinate:location animated:YES];
}

- (void)setSendButtonEnabledAfterLoadFinished
{
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)setCurrentCity:(NSString *)city
{
    [_searchResultTableVC setSearchCity:city];
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    searchPage = 1;
    [_searchResultTableVC searchPoiBySearchString:searchController.searchBar.text];
}



#pragma mark - UISearchBarDelegate

#pragma mark - 开始编辑
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

#pragma mark - 取消
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    //黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

#pragma mark - SearchResultTableVCDelegate
- (void)setSelectedLocationWithLocation:(AMapPOI *)poi
{
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(poi.location.latitude,poi.location.longitude) animated:NO];
    _searchController.searchBar.text = @"";
}


#pragma mark - 初始化


#pragma mark - 界面
-(void)setNotifier{
    // 使用通知中心监听kReachabilityChangedNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification object:nil];
    // 获取访问指定站点的Reachability对象
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    // 让Reachability对象开启被监听状态
    [reach startNotifier];
}
-(void)setNav{
    self.name = @"区域";
    [self setNavLeftItem];
    [self setNavRightItem];
    self.definesPresentationContext = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)setNavLeftItem{
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBarItem, nil];
    
}

-(void)setNavRightItem{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sendLocation)];
    [rightBarItem setTintColor:[UIColor whiteColor]];
    [rightBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateNormal];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width = -5;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, rightBarItem, nil];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

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


- (void)initMapView
{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,45, SCREEN_WIDTH, SCREEN_HEIGHT - CELL_HEIGHT*CELL_COUNT-45)];
    _mapView.delegate = self;
    // 不显示罗盘
    _mapView.showsCompass = NO;
    // 不显示比例尺
    _mapView.showsScale = NO;
    // 地图缩放等级
    _mapView.zoomLevel = 16;
    // 开启定位
    _mapView.showsUserLocation = YES;
    [self.view addSubview:_mapView];
}



- (void)initCenterMarker
{
    UIImage *image = [UIImage imageNamed:@"centerMarker"];
    _centerMaker = [[UIImageView alloc] initWithImage:image];
//    _centerMaker.frame = CGRectMake(self.view.frame.size.width/2-image.size.width/2, _mapView.bounds.size.height/2-image.size.height, image.size.width, image.size.height);
//    _centerMaker.center = CGPointMake(self.view.frame.size.width / 2, (CGRectGetHeight(_mapView.bounds) -  _centerMaker.frame.size.height - TITLE_HEIGHT) * 0.5);
    _centerMaker.center = CGPointMake(self.view.frame.size.width / 2, (CGRectGetHeight(_mapView.bounds) + 45 -  _centerMaker.frame.size.height) * 0.5);
    [self.view addSubview:_centerMaker];
}

- (void)initTableView
{
    _tableView = [[MapPoiTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_mapView.frame)-TITLE_HEIGHT, SCREEN_WIDTH, CELL_HEIGHT*CELL_COUNT + TITLE_HEIGHT)];
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)initLocationButton
{
    _imageLocated = [UIImage imageNamed:@"gpsselected"];
    _imageNotLocate = [UIImage imageNamed:@"gpsnormal"];
    _locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(_mapView.bounds)-50, CGRectGetHeight(_mapView.bounds)-50, 40, 40)];
    _locationBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _locationBtn.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    _locationBtn.layer.cornerRadius = 3;
    [_locationBtn addTarget:self action:@selector(actionLocation) forControlEvents:UIControlEventTouchUpInside];
    [_locationBtn setImage:_imageNotLocate forState:UIControlStateNormal];
    [self.view addSubview:_locationBtn];
}

- (void)initSearch
{
    searchPage = 1;
    _searchAPI = [[AMapSearchAPI alloc] init];
    _searchAPI.delegate = _tableView;
    
    _searchResultTableVC = [[SearchResultTableVC alloc] init];
    _searchResultTableVC.delegate = self;
    
    int SearchBarStyle = 0;
    switch (SearchBarStyle) {
        case 0:  // 放在NavigationBar底部
            [self.view addSubview:self.searchController.searchBar];
            self.edgesForExtendedLayout = UIRectEdgeNone;
            break;
        case 1:  // 点击搜索按钮显示SearchBar
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
            self.navigationItem.rightBarButtonItem = nil;
            self.searchController.searchBar.delegate = self;
            break;
        case 2:  // 放在NavigationBar内部
            self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
            self.searchController.hidesNavigationBarDuringPresentation = NO;
            self.navigationItem.titleView = self.searchController.searchBar;
            self.definesPresentationContext = YES;
        default:
            break;
    }

    
}

/** 搜索框*/
- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:_searchResultTableVC];
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



#pragma mark - Action

#pragma mark - 放回按钮
-(void)backItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 右侧按钮
-(void)sendLocation{
    NSLog(@"选择的经度--->%f\n,选择的纬度--->%f,选择的名称--->%@,选择的地址名称--->%@",_tableView.selectedPoi.location.latitude,_tableView.selectedPoi.location.longitude,_tableView.selectedPoi.name,_tableView.selectedPoi.address);
}


- (void)actionLocation
{
    [_mapView setCenterCoordinate:_mapView.userLocation.coordinate animated:YES];
}

// 搜索中心点坐标周围的POI-AMapGeoPoint
- (void)searchPoiByAMapGeoPoint:(AMapGeoPoint *)location
{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location = location;
    // 搜索半径
    request.radius = 2000;
    // 搜索结果排序
    request.sortrule = 1;
    // 当前页数
    request.page = searchPage;
    [_searchAPI AMapPOIAroundSearch:request];
}

// 搜索逆向地理编码-AMapGeoPoint
- (void)searchReGeocodeWithAMapGeoPoint:(AMapGeoPoint *)location
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = location;
    // 返回扩展信息
    regeo.requireExtension = YES;
    [_searchAPI AMapReGoecodeSearch:regeo];
}

#pragma mark - 网络环境监听
- (void)reachabilityChanged:(NSNotification *)note{
    // 通过通知对象获取被监听的Reachability对象
    Reachability *curReach = [note object];
    // 获取Reachability对象的网络状态
    NetworkStatus status = [curReach currentReachabilityStatus];
    if (status == ReachableViaWWAN || status == ReachableViaWiFi){
        NSLog(@"Reachable");
        if (isFirstLocated) {
            AMapGeoPoint *point = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
            [self searchReGeocodeWithAMapGeoPoint:point];
            [self searchPoiByAMapGeoPoint:point];
            searchPage = 1;
        }
    }
    else if (status == NotReachable){
        NSLog(@"notReachable");
        [SVProgressHUD showErrorWithStatus:@"网络错误，请检查网络设置"];
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}


- (void)searchAction
{
    [self.navigationController.navigationBar addSubview:_searchController.searchBar];
    _searchController.searchBar.showsCancelButton = YES;
    _searchController.hidesNavigationBarDuringPresentation = NO;
    
}

@end
