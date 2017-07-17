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
    
}

-(void)btnClick:(UIButton*)sender{
    if (sender.tag == 101) {
        MFMyPublishViewController *vc = [[MFMyPublishViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        MFTagsViewController *vc = [[MFTagsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
