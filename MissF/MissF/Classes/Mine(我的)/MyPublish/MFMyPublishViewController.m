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

@interface MFMyPublishViewController ()<YWSegmentTitleViewDelegate,YWScrollContentViewDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@property (assign, nonatomic) NSInteger curIndex;
@property (nonatomic, strong) YWSegmentTitleView *titleView;
@property (nonatomic, strong) UIScrollView *contentScrollView;

@end

@implementation MFMyPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.isAutoBack = NO;
    [self setNav];
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.contentScrollView];
    
    
    for (int i = 0; i < 2; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        [self addChildViewController:vc];
    }
    [self setUpOneChildController:0];

}

- (void)segmentTitleView:(YWSegmentTitleView *)segmentView selectedIndex:(NSInteger)selectedIndex lastSelectedIndex:(NSInteger)lastSelectedIndex{
    
    NSInteger i = selectedIndex;
    CGFloat x  = i * SCREEN_WIDTH;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    [self setUpOneChildController:i];
}

-(YWSegmentTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[YWSegmentTitleView alloc] init];
        _titleView.segmentTitles = [NSArray arrayWithObjects:@"待租出",@"已租出",nil];
        _titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);
        _titleView.AvgBtnCount = 2;
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
        
        CGRect rect  = CGRectMake(0, 35, SCREEN_WIDTH, SCREEN_HEIGHT - self.titleView.frame.size.height - 99);
        _contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator  = YES;
        _contentScrollView.delegate = self;
        _contentScrollView.contentSize = CGSizeMake(4 * SCREEN_WIDTH, 0);
    }
    return _contentScrollView;
}

-(void)setUpOneChildController:(NSInteger)index{
    
    CGFloat x  = index * SCREEN_WIDTH;
    UIViewController *vc  =  self.childViewControllers[index];
    if (vc.view.superview) {//判断是否是父视图
        return;
    }
    
    vc.view.frame = CGRectMake(x, 0, SCREEN_WIDTH, self.contentScrollView.frame.size.height);
    //将子ViewController 的 View 添加到  contentScrollView 上
    [self.contentScrollView addSubview:vc.view];
    
}

//- (void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    self.titleView.frame = CGRectMake(0, 0, self.view.frame.size.width, 35);
//}

#pragma mark - UIScrollView  delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(scrollView == self.contentScrollView){
        
        NSInteger i  = self.contentScrollView.contentOffset.x / SCREEN_WIDTH;
        [self setUpOneChildController:i];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == self.contentScrollView){
        
        CGFloat offsetX  = scrollView.contentOffset.x;
        NSInteger leftIndex  = offsetX / SCREEN_WIDTH;
        NSLog(@"我是谁:%ld",leftIndex);
        self.titleView.selectedIndex = leftIndex;
        
    }
}

-(void)setNav{
     self.rightStr_0 = @"编辑";
     self.navigationItem.titleView = self.segmentedControl;
}


-(UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl = ({
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"编辑", @"预览"]];
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

#pragma mark UISegmentedControl
- (void)segmentedControlSelected:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.curIndex = segmentedControl.selectedSegmentIndex;
}

#pragma mark index_view

- (void)setCurIndex:(NSInteger)curIndex{
    _curIndex = curIndex;
    if (_segmentedControl.selectedSegmentIndex != curIndex) {
        [_segmentedControl setSelectedSegmentIndex:_curIndex];
    }
    if (_curIndex == 0) {
//        [self loadEditView];
    }else{
//        [self loadPreview];
    }
}

-(void)right_0_action{
    [MBProgressHUD showSuccess:@"编辑信息" toView:self.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
