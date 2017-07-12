//
//  MFHousingResourcesTableViewController.h
//  MissF
//
//  Created by wyao on 2017/7/7.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MFHousingListViewController : BaseViewController
/** 房源列表 */
@property (nonatomic, strong) UITableView *houseTableView;
/** 是否选择状态 */
@property (nonatomic, assign) BOOL isExpandItem;
-(void)updateBottomViewWithCount:(NSInteger)count;
@end
