//
//  MFMineViewController.m
//  iOS_demo
//
//  Created by wyao on 2017/7/3.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFMineViewController.h"
#import "MFMyPublishViewController.h"
#import "MFTagsViewController.h"
#import "MFMyProfessionViewController.h"
#import "MFPublishRoomateViewController.h"
#import "MFPublishHouseViewController.h"


@interface MFMineViewController ()

@end

@implementation MFMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    self.name = @"发现";
    self.isAutoBack = NO;
    self.showBack = NO;
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 30)];
    btn1.backgroundColor = OrangeCOLOR;
    btn1.tag = 101;
    [btn1 setTitle:@"我的发布-室友" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 350, 200, 30)];
    btn2.backgroundColor = OrangeCOLOR;
    btn2.tag = 102;
    [btn2 setTitle:@"标签列表" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 200, 30)];
    btn3.backgroundColor = OrangeCOLOR;
    btn3.tag = 103;
    [btn3 setTitle:@"发布房源" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(100, 450, 200, 30)];
    btn4.backgroundColor = OrangeCOLOR;
    btn4.tag = 104;
    [btn4 setTitle:@"发布室友" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    
}

-(void)btnClick:(UIButton*)sender{
    if (sender.tag == 101) {
        MFMyPublishViewController *vc = [[MFMyPublishViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else  if (sender.tag == 102) {
        MFTagsViewController *vc = [[MFTagsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else  if (sender.tag == 103) {
        MFPublishHouseViewController *vc = [[MFPublishHouseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else  if (sender.tag == 104) {
        MFPublishRoomateViewController *vc = [[MFPublishRoomateViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
