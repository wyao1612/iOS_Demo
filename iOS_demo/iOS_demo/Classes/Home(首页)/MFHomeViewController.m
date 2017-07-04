//
//  MFHomeViewController.m
//  iOS_demo
//
//  Created by wyao on 2017/7/3.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFHomeViewController.h"

@interface MFHomeViewController ()

@end

@implementation MFHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WHITECOLOR;
    self.name = @"首页";

    [MFNetAPIClient getWithUrl:@"https://api.douban.com/v2/book/1220562" refreshCache:YES success:^(id responseObject) {
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
        NSLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
        [MBProgressHUD showError:@"缓存大小为"];
        NSLog(@"缓存大小为%@",  [MFNetAPIClient fileSizeWithDBPath]);
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"错误"];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
