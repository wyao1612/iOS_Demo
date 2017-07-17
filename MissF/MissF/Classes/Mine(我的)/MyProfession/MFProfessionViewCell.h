//
//  MFProfessionViewCell.h
//  MissF
//
//  Created by wyao on 2017/7/17.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MFProfessionViewCell : BaseTableViewCell
@property(nonatomic,strong) MFProfessionModel *model;
@property(strong,nonatomic) UIButton *titleBtn;
@property(strong,nonatomic) UILabel  *contentLb;
@end
