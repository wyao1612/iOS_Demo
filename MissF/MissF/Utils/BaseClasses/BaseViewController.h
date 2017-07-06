//
//  BaseViewController.h
//  iOS_demo
//
//  Created by wyao on 2017/7/4.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController<UITableViewDelegate,
UITableViewDataSource
>

/** 背景画布*/
@property (nonatomic, strong) UIScrollView *contentView;
/** 页面标题*/
@property (nonatomic, copy) NSString *name;
/** 导航栏右边第一个按钮图片或者名字*/
@property (nonatomic, strong) UIImage *rightIm_0;
@property (nonatomic, copy) NSString *rightStr_0;
/** 导航栏右边第二个按钮图片或者名字*/
@property (nonatomic, strong) UIImage *rightIm_1;
@property (nonatomic, copy) NSString *rightStr_1;

/** 是否展示返回按钮,默认显示*/
@property (nonatomic, assign) BOOL showBack;
/** 是否开启默认画布Scrollview, 默认开启*/
@property (nonatomic, assign) BOOL isAutoBack;


/** 初始化数据*/
- (void)initData;
/** 左侧返回动作*/
- (void)leftBackAction;
/** 右边按钮第一个动作*/
- (void)right_0_action;
/** 右边按钮第二个动作*/
- (void)right_1_action;


/**
 用了自定义的手势返回，则系统的手势返回屏蔽
 不用自定义的手势返回，则系统的手势返回启用
 */
@property (nonatomic, assign) BOOL enablePanGesture;//是否支持自定义拖动pop手势，默认yes,支持手势
/** 背景画布*/
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, copy)   NSString *cellClassName;
@property(strong,nonatomic)   UIView   *HomeTitleView;
@property(strong,nonatomic)   NSString   *titleCHname;
@property(strong,nonatomic)   NSString   *titleEngname;
-(void)setTitleCHView:(NSString*)titleCHname andEngName:(NSString*)titleEngname;


- (void)netReachableOperation;
-(void)loadData;

//- (void)tabBarItemClicked;
//- (void)loginOutToLoginVC;
//+ (void)handleNotificationInfo:(NSDictionary *)userInfo applicationState:(UIApplicationState)applicationState;
//+ (UIViewController *)analyseVCFromLinkStr:(NSString *)linkStr;
//+ (void)presentLinkStr:(NSString *)linkStr;
//+ (UIViewController *)presentingVC;
//+ (void)presentVC:(UIViewController *)viewController;
//+ (void)goToVC:(UIViewController *)viewController;
@end
