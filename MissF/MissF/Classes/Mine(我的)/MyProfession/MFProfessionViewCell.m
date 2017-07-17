//
//  MFProfessionViewCell.m
//  MissF
//
//  Created by wyao on 2017/7/17.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFProfessionViewCell.h"

@interface MFProfessionViewCell ()

@end

@implementation MFProfessionViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = WHITECOLOR;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.titleBtn];
    [self.contentView addSubview:self.contentLb];
    
    self.titleBtn.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.contentView, 18)
    .widthIs(36)
    .heightIs(18);
    
    self.contentLb.sd_layout
    .centerYEqualToView(self.contentView)
    .leftSpaceToView(self.titleBtn, 15)
    .widthIs(200)
    .heightIs(20);
    
}

-(void)setModel:(MFProfessionModel *)model{
    _model = model;
    [self.titleBtn setTitle:model.parent forState:UIControlStateNormal];
    self.titleBtn.backgroundColor = [UIColor getColor:model.color];
    self.titleBtn.layer.borderColor = [UIColor getColor:model.color].CGColor;
    self.contentLb.text = model.name;
}

-(UIButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn = [[UIButton alloc] init];
        _titleBtn.layer.cornerRadius = 5;
        _titleBtn.layer.borderWidth = 0.3;
        _titleBtn.clipsToBounds = YES;
        _titleBtn.titleLabel.font = FONT(15);
        _titleBtn.userInteractionEnabled = NO;
    }
    return _titleBtn;
}

-(UILabel *)contentLb{
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.textColor = BLACKTEXTCOLOR;
        _contentLb.font = FONT(15);
        _contentLb.textAlignment = NSTextAlignmentLeft;
    }
    return _contentLb;
}

@end
