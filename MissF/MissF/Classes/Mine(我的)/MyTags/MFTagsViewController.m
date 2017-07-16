//
//  MFTagsViewController.m
//  MissF
//
//  Created by wyao on 2017/7/15.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFTagsViewController.h"
#import "GBTagListView.h"

@interface MFTagsViewController (){
    
    NSArray*strArray;//保存标签数据的数组
    GBTagListView*_tempTag;
    
}

@end

@implementation MFTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAutoBack = NO;
    self.name = @"选择标签";
    
//    
//    strArray=@[@"运动",@"看书",@"电影",@"旅游",@"摄影",@"综艺",@"二次元",@"DIY",@"做饭",@"运动",@"看书",@"值得一交的朋友",@"github",@"code4app",@"值得一交的朋友",@"大好人",@"github",@"code4app"];
//    
//    GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 0)];
//    /**允许点击 */
//    tagList.canTouch=YES;
//    /**可以控制允许点击的标签数 */
//    tagList.canTouchNum=3;
//    /**控制是否是单选模式 */
//    tagList.isSingleSelect=NO;
////    [tagList setMarginBetweenTagLabel:10 AndBottomMargin:10];
//    tagList.signalTagColor=[UIColor whiteColor];
//    [tagList setTagWithTagArray:strArray];
//    __weak __typeof(self)weakSelf = self;
//    [tagList setDidselectItemBlock:^(NSArray *arr) {
//         NSLog(@"------>视图一选中的标签%@",arr);
//    }];
//    
//    [self.view addSubview:tagList];
//    
//    
//    GBTagListView *tagList1=[[GBTagListView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(tagList.frame)+10, SCREEN_WIDTH, 0)];
//    /**允许点击 */
//    tagList1.canTouch=YES;
//    /**可以控制允许点击的标签数 */
//    tagList1.canTouchNum=5;
//    /**控制是否是单选模式 */
//    tagList1.isSingleSelect=NO;
//    tagList1.signalTagColor=[UIColor whiteColor];
//    [tagList1 setTagWithTagArray:strArray];
//    [tagList1 setDidselectItemBlock:^(NSArray *arr) {
//         NSLog(@"------>视图二选中的标签%@",arr);
//    }];
//    
//    [self.view addSubview:tagList1];
    
    
    [self setTagsView];
}

-(void)setTagsView{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = WHITECOLOR;
    [self.view addSubview:bgView];
    
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    hView.backgroundColor = WHITECOLOR;
    [bgView addSubview:hView];
    
    
    strArray=@[@"运动",@"看书",@"电影",@"旅游",@"摄影",@"综艺",@"二次元",@"DIY",@"做饭",@"运动",@"看书",@"值得一交的朋友",@"github",@"code4app",@"值得一交的朋友",@"大好人",@"github",@"code4app"];
    
    GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 0)];
    /**允许点击 */
    tagList.canTouch=YES;
    /**可以控制允许点击的标签数 */
    tagList.canTouchNum=3;
    /**控制是否是单选模式 */
    tagList.isSingleSelect=NO;
    tagList.signalTagColor=[UIColor whiteColor];
    [tagList setTagWithTagArray:strArray];
    // __weak __typeof(self)weakSelf = self;
    [tagList setDidselectItemBlock:^(NSArray *arr) {
        NSLog(@"------>视图一选中的标签%@",arr);
    }];
    
    [bgView addSubview:tagList];
    
    [bgView setupAutoHeightWithBottomView:tagList bottomMargin:10];
    
}
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
