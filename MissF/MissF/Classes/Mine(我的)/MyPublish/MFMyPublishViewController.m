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
        MFHousingListViewController *vc = [[MFHousingListViewController alloc] init];
        [self addChildViewController:vc];
    }
    [self setUpOneChildController:0];

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
        
        CGRect rect  = CGRectMake(0, 35, SCREEN_WIDTH, SCREEN_HEIGHT - self.titleView.frame.size.height - NaviBar_HEIGHT);
        _contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.showsHorizontalScrollIndicator  = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.contentSize = CGSizeMake(2 * SCREEN_WIDTH, 0);
    }
    return _contentScrollView;
}

- (void)segmentTitleView:(YWSegmentTitleView *)segmentView selectedIndex:(NSInteger)selectedIndex lastSelectedIndex:(NSInteger)lastSelectedIndex{
    
    if (selectedIndex == 0) {
        self.rightStr_0 = self.firstSelectString;
    }else if(selectedIndex == 1){
        self.rightStr_0 = self.secondSelectString;
    }
    
    _childViewIndex = selectedIndex;
    CGFloat x  = selectedIndex * SCREEN_WIDTH;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    [self setUpOneChildController:selectedIndex];
}

-(void)setUpOneChildController:(NSInteger)index{
    
    CGFloat x  = index * SCREEN_WIDTH;
    MFHousingListViewController *vc  =  self.childViewControllers[index];
    if (vc.view.superview) {//判断是否是父视图
        return;
    }
    vc.view.frame = CGRectMake(x, 6.5, SCREEN_WIDTH, self.contentScrollView.frame.size.height);
    //将子ViewController的View添加到contentScrollView上
    [self.contentScrollView addSubview:vc.view];
    [self.contentScrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}



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
        NSLog(@"%f",offsetX);
        NSInteger leftIndex  = offsetX / SCREEN_WIDTH;
        self.titleView.selectedIndex = leftIndex;
    }
}

-(void)setNav{
     //默认显示
     self.rightStr_0 = @"选择";
     self.firstSelectString = @"选择";
     self.secondSelectString = @"选择";
     self.navigationItem.titleView = self.segmentedControl;
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


#pragma mark
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

    switch (_childViewIndex) {
        case 0:
        {
            if ([self.firstSelectString isEqualToString:@"选择"]) {
                self.rightStr_0 = @"取消";
                self.firstSelectString = @"取消";
                //进入编辑状态
                MFHousingListViewController *vc  =  self.childViewControllers[0];
                vc.isExpandItem = YES;
                
            }else if ([self.firstSelectString isEqualToString:@"取消"]){
                //取消编辑状态
                self.rightStr_0 = @"选择";
                self.firstSelectString = @"选择";
                MFHousingListViewController *vc  =  self.childViewControllers[0];
                vc.isExpandItem = NO;
                [vc updateBottomViewWithCount:0];
            }
        }
            break;
        case 1:
        {

            if ([self.secondSelectString isEqualToString:@"选择"]) {
                self.rightStr_0 = @"取消";
                self.secondSelectString = @"取消";
                //进入编辑状态
                MFHousingListViewController *vc  =  self.childViewControllers[1];
                vc.isExpandItem = YES;
                
            }else if ([self.secondSelectString isEqualToString:@"取消"]){
                //取消编辑状态
                self.rightStr_0 = @"选择";
                self.secondSelectString = @"选择";
                MFHousingListViewController *vc  =  self.childViewControllers[1];
                vc.isExpandItem = NO;
                [vc updateBottomViewWithCount:0];
            }
        }
            break;
            
        default:
            break;
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
