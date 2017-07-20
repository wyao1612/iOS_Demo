//
//  MFHouseListCell.h
//  MissF
//
//  Created by wyao on 2017/7/7.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFHouseListModel.h"


typedef void(^ListCellBlock)(UIButton* sender);
typedef void(^ListCellSelectBlock)(BOOL isSelected);


@interface MFHouseListCell : UITableViewCell
/** 用于自定义选择按钮点击回调*/
@property (nonatomic, copy) ListCellSelectBlock ListCellSelectBlock;
/** 删除和重新发布的点击回调*/
@property (nonatomic, copy) ListCellBlock listCellBlock;
- (void)configureShopcartCellWithModel:(MFHouseListModel*)model
                       productSelected:(BOOL)productSelected
                              isExpand:(BOOL)isExpand;
@end
