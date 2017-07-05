//
//  MFHomeViewController.m
//  iOS_demo
//
//  Created by wyao on 2017/7/3.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFHomeViewController.h"
#import "MFLoginViewController.h"


@interface MFHomeViewController ()

@end

@implementation MFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    self.name = @"首页";

    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 50, 20)];
    btn.backgroundColor = OrangeCOLOR;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)btnClick{
    MFLoginViewController *vc = [[MFLoginViewController alloc] init];
    vc.showDismissButton = YES;
    UINavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
