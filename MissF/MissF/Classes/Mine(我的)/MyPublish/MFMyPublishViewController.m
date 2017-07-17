//
//  MFMyPublishViewController.m
//  MissF
//
//  Created by wyao on 2017/7/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFMyPublishViewController.h"
#import "YWSegmentTitleView.h"
#import "YWScrollContentView.h"
#import "MFHousingListViewController.h"
#import "MFRoommateViewController.h"

@interface MFMyPublishViewController ()
<YWSegmentTitleViewDelegate,
YWScrollContentViewDelegate,
UIGestureRecognizerDelegate,
UIScrollViewDelegate>

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (assign, nonatomic) NSInteger curIndex;
@property (assign, nonatomic) NSInteger childViewIndex;
@property (copy, nonatomic)   NSString *firstSelectString;
@property (copy, nonatomic)   NSString *secondSelectString;
@property (nonatomic, strong) YWSegmentTitleView *titleView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation MFMyPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.isAutoBack = NO;
    [self setNav];
    //第一次进来显示第一个
    [self setCurIndex:0];
}

-(void)setNav{
    self.navigationItem.titleView = self.segmentedControl;
}



-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"待租出",@"已租出",nil];
    }
    return _titleArray;
}

-(YWSegmentTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[YWSegmentTitleView alloc] init];
        _titleView.segmentTitles = self.titleArray;
        _titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);
        _titleView.AvgBtnCount = self.titleArray.count;
        _titleView.itemMinMargin = 15.f;
        _titleView.delegate = self;
        _titleView.titleNormalColor = LIGHTTEXTCOLOR;
        _titleView.titleSelectedColor = SHENTEXTCOLOR;
        _titleView.titleFont = FONT(15);
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}

-(UIScrollView *)contentScrollView{
    
    if(!_contentScrollView){
        
        CGRect rect  = CGRectMake(0, 35, SCREEN_WIDTH, SCREEN_HEIGHT - self.titleView.frame.size.height - NaviBar_HEIGHT);
        _contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator  = NO;
        [_contentScrollView setShowsVerticalScrollIndicator:NO];
        _contentScrollView.delegate = self;
        _contentScrollView.bounces = NO;
        _contentScrollView.contentSize = CGSizeMake(2 * SCREEN_WIDTH, 0);
        //添加子控制器和视图
        for (int idx = 0; idx < self.titleArray.count; idx++) {
            MFHousingListViewController *vc = [[MFHousingListViewController alloc] init];
            vc.view.frame = CGRectMake(idx * SCREEN_WIDTH, 0, SCREEN_WIDTH, _contentScrollView.frame.size.height);
            [_contentScrollView addSubview:vc.view];
            [self addChildViewController:vc];
        }
    }
    return _contentScrollView;
}


-(UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = ({
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"房源", @"室友"]];
            segmentedControl.selectedSegmentIndex = 0;
            [segmentedControl setWidth:80 forSegmentAtIndex:0];
            [segmentedControl setWidth:80 forSegmentAtIndex:1];
            segmentedControl.tintColor = [UIColor whiteColor];
            [segmentedControl setTitleTextAttributes:@{
                                                       NSFontAttributeName: [UIFont systemFontOfSize:16],
                                                       NSForegroundColorAttributeName: [UIColor colorWithHex:0xffb2bd]
                                                       }
                                            forState:UIControlStateSelected];
            [segmentedControl setTitleTextAttributes:@{
                                                       NSFontAttributeName: [UIFont systemFontOfSize:16],
                                                       NSForegroundColorAttributeName: [UIColor whiteColor]
                                                       } forState:UIControlStateNormal];
            [segmentedControl addTarget:self action:@selector(segmentedControlSelected:) forControlEvents:UIControlEventValueChanged];
            segmentedControl;
        });
    }
    return _segmentedControl;
}

#pragma mark UISegmentedControl delegate
- (void)segmentedControlSelected:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.curIndex = segmentedControl.selectedSegmentIndex;
}

#pragma mark - 点击titleView按钮事件
- (void)setCurIndex:(NSInteger)curIndex{
    _curIndex = curIndex;
    if (_segmentedControl.selectedSegmentIndex != curIndex) {
        [_segmentedControl setSelectedSegmentIndex:_curIndex];
    }
    if (_curIndex == 0) {
        self.titleView.hidden = NO;
        self.contentScrollView.hidden = NO;
        [self.view addSubview:self.titleView];
        [self.view addSubview:self.contentScrollView];
        //房源默认显示
        self.rightStr_0 = @"选择";
        self.firstSelectString = @"选择";
        self.secondSelectString = @"选择";
    }else{
        //室友默认显示
        self.rightStr_0 = @"编辑";
        self.titleView.hidden = YES;
        self.contentScrollView.hidden = YES;
        MFRoommateViewController *vc = [[MFRoommateViewController alloc] init];
        vc.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT);
        [self.view addSubview:vc.view];
        [self addChildViewController:vc];
    }
}


#pragma mark - UIScrollView  delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _contentScrollView) {
        NSInteger currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
        self.titleView.selectedIndex = currentIndex;
        if (currentIndex == 0) {
            self.rightStr_0 = self.firstSelectString;
        }else if(currentIndex == 1){
            self.rightStr_0 = self.secondSelectString;
        }
        _childViewIndex = currentIndex;
    }
}

/** 待租出和已租出的按钮选择*/
- (void)segmentTitleView:(YWSegmentTitleView *)segmentView selectedIndex:(NSInteger)selectedIndex lastSelectedIndex:(NSInteger)lastSelectedIndex{
    
    if (selectedIndex == 0) {
        self.rightStr_0 = self.firstSelectString;
    }else if(selectedIndex == 1){
        self.rightStr_0 = self.secondSelectString;
    }
    _childViewIndex = selectedIndex;
    //NSLog(@"选择的下标---->%zd",selectedIndex);
    [self.contentScrollView setContentOffset:CGPointMake(selectedIndex*SCREEN_WIDTH, 0) animated:YES];
    
}

-(void)right_0_action{
    
    if (_curIndex == 0) {

        if (_childViewIndex == 0) {
            
            MFHousingListViewController *vc = self.childViewControllers[0];
            if ([self.firstSelectString isEqualToString:@"选择"]) {
                self.rightStr_0 = @"取消";
                self.firstSelectString = @"取消";
                vc.isExpandItem = YES;
                
            }else if ([self.firstSelectString isEqualToString:@"取消"]){
                self.rightStr_0 = @"选择";
                self.firstSelectString = @"选择";
                vc.isExpandItem = NO;
                [vc updateBottomViewWithCount:0];
            }
        }else  if (_childViewIndex == 1){
             MFHousingListViewController *vc = self.childViewControllers[1];
            if ([self.secondSelectString isEqualToString:@"选择"]) {
                self.rightStr_0 = @"取消";
                self.secondSelectString = @"取消";
                vc.isExpandItem = YES;
                
            }else if ([self.secondSelectString isEqualToString:@"取消"]){
                self.rightStr_0 = @"选择";
                self.secondSelectString = @"选择";
                vc.isExpandItem = NO;
                [vc updateBottomViewWithCount:0];
            }
        }
    }

  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
