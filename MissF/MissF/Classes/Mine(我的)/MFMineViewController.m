//
//  MFMineViewController.m
//  iOS_demo
//
//  Created by wyao on 2017/7/3.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFMineViewController.h"
#import "MFMyPublishViewController.h"


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
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
    btn1.backgroundColor = OrangeCOLOR;
    btn1.tag = 101;
    [btn1 setTitle:@"我的发布-室友" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
}

-(void)btnClick:(UIButton*)sender{
    if (sender.tag == 101) {
        MFMyPublishViewController *vc = [[MFMyPublishViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
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
