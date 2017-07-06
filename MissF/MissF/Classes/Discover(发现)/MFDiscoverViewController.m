//
//  MFDiscoverViewController.m
//  iOS_demo
//
//  Created by wyao on 2017/7/3.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFDiscoverViewController.h"

@interface MFDiscoverViewController ()

@end

@implementation MFDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    self.name = @"发现";
    self.isAutoBack = YES;
    self.showBack = NO;
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
