//
//  MFLocationTableViewCell.m
//  MissF
//
//  Created by wyao on 2017/7/19.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFLocationTableViewCell.h"


@interface MFLocationTableViewCell ()
@property (nonatomic, strong)  UILabel *nameLb;
@property (nonatomic, strong)  UILabel *titleLb;
@end


@implementation MFLocationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.separatorInset=UIEdgeInsetsZero;
        self.layoutMargins=UIEdgeInsetsZero;
        self.backgroundColor = WHITECOLOR;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.titleLb];
    
    self.nameLb.sd_layout
    .topSpaceToView(self.contentView, 15)
    .leftSpaceToView(self.contentView, 25)
    .widthIs(SCREEN_WIDTH-50)
    .heightIs(16);
    
    self.titleLb.sd_layout
    .topSpaceToView(self.nameLb, 5)
    .leftSpaceToView(self.contentView, 25)
    .widthIs(SCREEN_WIDTH-50)
    .heightIs(16);
    
}

-(UILabel *)nameLb{
    if (!_nameLb) {
        _nameLb = [[UILabel alloc] init];
        _nameLb.font = [UIFont systemFontOfSize:15];
        _nameLb.textAlignment = NSTextAlignmentLeft;
        _nameLb.text = @"罗兰春天";
        _nameLb.textColor = BLACKTEXTCOLOR;
    }
    return _nameLb;
}


-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:15];
        _titleLb.textAlignment = NSTextAlignmentLeft;
        _titleLb.text = @"罗兰春天";
        _titleLb.textColor = LIGHTTEXTCOLOR;
    }
    return _titleLb;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
