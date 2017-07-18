//
//  MFHouseListCell.m
//  MissF
//
//  Created by wyao on 2017/7/7.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFHouseListCell.h"
#import "MFbutton.h"

@interface MFHouseListCell ()
@property (nonatomic, strong) UIButton      *houseSelectButton;
@property (nonatomic, strong) UIImageView   *HouseBgView;
@property (nonatomic, strong) UIImageView   *HouseAvtarView;
@property (nonatomic, strong) UILabel       *HouseNameLable;
@property (nonatomic, strong) UILabel       *HousePriceLable;
@property (nonatomic, strong) UILabel       *HouseCommentLable;
@property (nonatomic, strong) UIView        *HouseLineView;
@property (nonatomic, strong) UILabel       *HouseDateLable;
@property (nonatomic, strong) MFbutton      *HousePublishButton;
@property (nonatomic, strong) MFbutton      *HouseEditButton;

@end


@implementation MFHouseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupViewsWithStatus:NO];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.separatorInset=UIEdgeInsetsZero;
        self.layoutMargins=UIEdgeInsetsZero;
        self.backgroundColor = ClearColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        //定义选中的背景颜色
        [self setupViewsWithStatus:NO];
        
    }
    return self;
}

- (void)setupViewsWithStatus:(BOOL)isOpen{
    
    
    
    if (isOpen == YES) {
        
        [self.contentView addSubview:self.houseSelectButton];
        [self.contentView addSubview:self.HouseBgView];
        
        self.houseSelectButton.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, 15)
        .widthIs(22)
        .heightIs(22);
        
        self.HouseBgView.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.houseSelectButton, 15)
        .rightSpaceToView(self.contentView, 0)
        .autoHeightRatio(0);
        
    }else{
        
        [self.contentView addSubview:self.HouseBgView];
        
        self.HouseBgView.sd_layout
        .topSpaceToView(self.contentView, 0)
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView, 0)
        .autoHeightRatio(0);
    }
    
    [self.HouseBgView addSubview:self.HouseAvtarView];
    [self.HouseBgView addSubview:self.HouseNameLable];
    [self.HouseBgView addSubview:self.HousePriceLable];
    [self.HouseBgView addSubview:self.HouseCommentLable];
    [self.HouseBgView addSubview:self.HouseLineView];
    [self.HouseBgView addSubview:self.HouseDateLable];
    [self.HouseBgView addSubview:self.HousePublishButton];
    [self.HouseBgView addSubview:self.HouseEditButton];
    
    
    
    self.HouseAvtarView.sd_layout
    .topSpaceToView(self.HouseBgView, 12)
    .leftSpaceToView(self.HouseBgView, 15)
    .widthIs(86)
    .heightIs(86);
    
    self.HouseNameLable.sd_layout
    .topSpaceToView(self.HouseBgView, 13)
    .leftSpaceToView(self.HouseAvtarView, 18)
    .rightSpaceToView(self.HouseBgView, 20)
    .autoHeightRatio(0);
    [self.HouseNameLable setMaxNumberOfLinesToShow:2];
    
    self.HousePriceLable.sd_layout
    .topSpaceToView(self.HouseNameLable, 15)
    .leftSpaceToView(self.HouseAvtarView, 18)
    .widthIs(70)
    .heightIs(14);
    
    self.HouseCommentLable.sd_layout
    .topSpaceToView(self.HousePriceLable, 24)
    .leftSpaceToView(self.HouseAvtarView, 18)
    .rightSpaceToView(self.HouseBgView, 10)
    .heightIs(14);
    
    self.HouseLineView.sd_layout
    .topSpaceToView(self.HouseCommentLable, 20)
    .leftSpaceToView(self.HouseBgView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    self.HouseDateLable.sd_layout
    .topSpaceToView(self.HouseLineView, 13)
    .leftSpaceToView(self.HouseBgView, 15)
    .widthIs(80)
    .heightIs(14);
    
    self.HouseEditButton.sd_layout
    .topSpaceToView(self.HouseLineView, 10)
    .rightSpaceToView(self.HouseBgView, 20)
    .widthIs(20)
    .heightIs(18);
    
    self.HousePublishButton.sd_layout
    .topSpaceToView(self.HouseLineView, 10)
    .rightSpaceToView(self.HouseEditButton, 5)
    .widthIs(65)
    .heightIs(18);
    
    [self.HouseBgView setupAutoHeightWithBottomView:self.HousePublishButton bottomMargin:20];
    [self setupAutoHeightWithBottomView:self.HouseBgView bottomMargin:0];
}


- (void)configureShopcartCellWithModel:(MFHouseListModel*)model
                       productSelected:(BOOL)productSelected
                              isExpand:(BOOL)isExpand{
    //是否展开
    [self setupViewsWithStatus:isExpand];
}

- (void)houseSelectButtonAction {
    self.houseSelectButton.selected = !self.houseSelectButton.isSelected;
    if (self.ListCellSelectBlock) {
        self.ListCellSelectBlock(self.houseSelectButton.selected);
    }
}


- (UIImageView *)HouseBgView {
    if (_HouseBgView == nil){
        _HouseBgView = [[UIImageView alloc] init];
        _HouseBgView.userInteractionEnabled = YES;
        _HouseBgView.image = IMAGE(@"bg_my_released");
    }
    return _HouseBgView;
}

- (UIImageView *)HouseAvtarView {
    if (_HouseAvtarView == nil){
        _HouseAvtarView = [[UIImageView alloc] init];
        _HouseAvtarView.image = Placeholder_middle;
    }
    return _HouseAvtarView;
}


- (UILabel *)HouseNameLable {
    if (_HouseNameLable == nil){
        _HouseNameLable = [[UILabel alloc] init];
        _HouseNameLable.font = [UIFont systemFontOfSize:15];
        _HouseNameLable.textAlignment = NSTextAlignmentLeft;
        _HouseNameLable.text = @"房源展示标题信息房源展示标题信息房源展示标题信息";
        _HouseNameLable.textColor = BLACKTEXTCOLOR;
    }
    return _HouseNameLable;
}

- (UILabel *)HousePriceLable {
    if (_HousePriceLable == nil){
        _HousePriceLable = [[UILabel alloc] init];
        _HousePriceLable.font = [UIFont systemFontOfSize:13];
        _HousePriceLable.textAlignment = NSTextAlignmentLeft;
        _HousePriceLable.text = @"¥ 2300/月";
        _HousePriceLable.textColor = GLOBALCOLOR;
    }
    return _HousePriceLable;
}

- (UILabel *)HouseCommentLable {
    if (_HouseCommentLable == nil){
        _HouseCommentLable = [[UILabel alloc] init];
        _HouseCommentLable.font = [UIFont systemFontOfSize:13];
        _HouseCommentLable.textAlignment = NSTextAlignmentLeft;
        _HouseCommentLable.text = @"浏览 112 · 评论 8 · 分享 3";
        _HouseCommentLable.textColor = LIGHTTEXTCOLOR;
    }
    return _HouseCommentLable;
}

- (UIView *)HouseLineView {
    if (_HouseLineView == nil){
        _HouseLineView = [[UIView alloc] init];
        _HouseLineView.backgroundColor = LineColor;
    }
    return _HouseLineView;
}

- (UILabel *)HouseDateLable {
    if (_HouseDateLable == nil){
        _HouseDateLable = [[UILabel alloc] init];
        _HouseDateLable.font = [UIFont systemFontOfSize:13];
        _HouseDateLable.textAlignment = NSTextAlignmentLeft;
        _HouseDateLable.text = @"2017/06/03";
        _HouseDateLable.textColor = LIGHTTEXTCOLOR;
    }
    return _HouseDateLable;
}

- (MFbutton *)HouseEditButton
{
    if(_HouseEditButton == nil)
    {
        _HouseEditButton = [[MFbutton alloc] init];
        [_HouseEditButton setTitle:@"···" forState:UIControlStateNormal];
        _HouseEditButton.tag = 101;
        _HouseEditButton.userInteractionEnabled = YES;
        [_HouseEditButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _HouseEditButton;
}

- (MFbutton *)HousePublishButton
{
    if(_HousePublishButton == nil)
    {
        _HousePublishButton = [[MFbutton alloc] init];
        _HousePublishButton.tag = 102;
        _HousePublishButton.userInteractionEnabled = YES;
        [_HousePublishButton setTitle:@"重新发布" forState:UIControlStateNormal];
        [_HousePublishButton addTarget:self action:@selector(cellButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _HousePublishButton;
}

- (UIButton *)houseSelectButton
{
    if(_houseSelectButton == nil)
    {
        _houseSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_houseSelectButton setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
        [_houseSelectButton setImage:[UIImage imageNamed:@"btn_selected"] forState:UIControlStateSelected];
        [_houseSelectButton addTarget:self action:@selector(houseSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _houseSelectButton;
}



#pragma mark - 点击事件实现
- (void)cellButtonAction:(UIButton*)sender{
   if (self.listCellBlock) {
       self.listCellBlock(sender);
   }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    self.contentView.backgroundColor = [UIColor clearColor];
    
}

@end
