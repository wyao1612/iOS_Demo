//
//  BaseNavigationViewController.m
//  PowerStation
//
//  Created by wyao on 2017/5/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()
@property (strong, nonatomic) UIView *navLineV;
@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define iOS10 ([[UIDevice currentDevice].systemVersion intValue]>=10?YES:NO)
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x1a1a1a]] forBarMetrics:UIBarMetricsDefault];
    
    //藏旧
    [self hideBorderInView:self.navigationBar];
    //添新
    if (!_navLineV) {
        _navLineV = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreen_Width, 1.0/ [UIScreen mainScreen].scale)];
        _navLineV.backgroundColor = [UIColor colorWithHex:0xD8DDE4];
        [self.navigationBar addSubview:_navLineV];
    }
}

+ (void)initialize {
    //在这里设置不同的nav的样式通过判断
    if (self == [BaseNavigationController class]) {
        UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[BaseNavigationController class], nil];
        [bar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHex:0x1a1a1a]] forBarMetrics:UIBarMetricsDefault];
        [bar setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:20],
                                      NSForegroundColorAttributeName : [UIColor greenColor]}];
    }
}

- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated{
    // 如果这个控制器不是第一个控制器,那么应该设置隐藏tabbar的属性
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
//        self.tabBarController.tabBar.hidden=YES;
    }else{
       self.tabBarController.tabBar.hidden=NO;
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)hideNavBottomLine{
    [self hideBorderInView:self.navigationBar];
    if (_navLineV) {
        _navLineV.hidden = YES;
    }
}

- (void)showNavBottomLine{
    _navLineV.hidden = NO;
}

- (void)hideBorderInView:(UIView *)view{
    if ([view isKindOfClass:[UIImageView class]]
        && view.frame.size.height <= 1) {
        view.hidden = YES;
    }
    for (UIView *subView in view.subviews) {
        [self hideBorderInView:subView];
    }
}

- (BOOL)shouldAutorotate{
    return [self.visibleViewController shouldAutorotate];
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (![self.visibleViewController isKindOfClass:[UIAlertController class]]) {//iOS9 UIWebRotatingAlertController
        return [self.visibleViewController supportedInterfaceOrientations];
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
