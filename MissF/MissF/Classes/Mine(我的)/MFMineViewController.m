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
    [btn3 setTitle:@"职业选择" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    
}

-(void)btnClick:(UIButton*)sender{
    if (sender.tag == 101) {
        MFMyPublishViewController *vc = [[MFMyPublishViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else  if (sender.tag == 102) {
        MFTagsViewController *vc = [[MFTagsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else  if (sender.tag == 103) {
        MFMyProfessionViewController *vc = [[MFMyProfessionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
