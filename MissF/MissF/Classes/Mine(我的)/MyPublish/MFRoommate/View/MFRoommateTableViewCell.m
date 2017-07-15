//
//  MFRoommateTableViewCell.m
//  MissF
//
//  Created by wyao on 2017/7/13.
//  Copyright © 2017年 wyao. All rights reserved.
//


#import "MFRoommateTableViewCell.h"

@interface MFRoommateTableViewCell ()
@property (strong, nonatomic) UIButton *clearBtn, *passwordBtn;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UILabel *titleLabel, *valueLabel;
@property (strong, nonatomic) NSString *title, *value;
@property (strong, nonatomic) NSString *phStr, *valueStr;
@property (strong, nonatomic) NSString *currentReuseIdentifier;
@end

@implementation MFRoommateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = WHITECOLOR;
        
        //标题 + 输入框
        if ([reuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_TextField]){
            if (!_titleLabel) {
                _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMFRoommateCellPaddingLeftWidth, 22, 90, 16)];
                _titleLabel.backgroundColor = [UIColor clearColor];
                _titleLabel.font = [UIFont systemFontOfSize:15];
                _titleLabel.textColor = [UIColor blackColor];
                _titleLabel.textAlignment = NSTextAlignmentLeft;
                [self.contentView addSubview:_titleLabel];
            }
            if (!_textField) {
                _textField = [UITextField new];
                [_textField setFont:[UIFont systemFontOfSize:15]];
                [_textField addTarget:self action:@selector(editDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
                [_textField addTarget:self action:@selector(textValueChanged:) forControlEvents:UIControlEventEditingChanged];
                [_textField addTarget:self action:@selector(editDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
                [self.contentView addSubview:_textField];
                _textField.sd_layout
                .centerYEqualToView(self.contentView)
                .leftSpaceToView(_textField, 0)
                .rightSpaceToView(self.contentView, 30)
                .heightIs(16);
            }
        
        }// 标题 + 内容 + 箭头
        else if ([reuseIdentifier isEqualToString:kCellIdentifier_TitleValueMore]){
            
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            if (!_titleLabel) {
                _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMFRoommateCellPaddingLeftWidth, 22, 90, 16)];
                _titleLabel.backgroundColor = [UIColor clearColor];
                _titleLabel.font = [UIFont systemFontOfSize:15];
                _titleLabel.textColor = [UIColor blackColor];
                _titleLabel.textAlignment = NSTextAlignmentLeft;
                [self.contentView addSubview:_titleLabel];
            }
            if (!_valueLabel) {
                _valueLabel = [[UILabel alloc] init];
                _valueLabel.backgroundColor = [UIColor clearColor];
                _valueLabel.font = [UIFont systemFontOfSize:15];
                _valueLabel.textColor = BLACKTEXTCOLOR;
                _valueLabel.textAlignment = NSTextAlignmentLeft;
                _valueLabel.adjustsFontSizeToFitWidth = YES;
                _valueLabel.minimumScaleFactor = 0.6;
                [self.contentView addSubview:_valueLabel];
                _valueLabel.sd_layout
                .centerYEqualToView(self.contentView)
                .leftSpaceToView(_titleLabel, 0)
                .rightSpaceToView(self.contentView, 30)
                .heightIs(16);
            }
            
        }// 标题 + 内容
        else if ([reuseIdentifier isEqualToString:kCellIdentifier_TitleValue]){

            if (!_titleLabel) {
                _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMFRoommateCellPaddingLeftWidth, 22, 90, 16)];
                _titleLabel.backgroundColor = [UIColor clearColor];
                _titleLabel.font = [UIFont systemFontOfSize:15];
                _titleLabel.textColor = [UIColor blackColor];
                _titleLabel.textAlignment = NSTextAlignmentLeft;
                [self.contentView addSubview:_titleLabel];
            }
            if (!_valueLabel) {
                _valueLabel = [[UILabel alloc] init];
                _valueLabel.backgroundColor = [UIColor clearColor];
                _valueLabel.font = [UIFont systemFontOfSize:15];
                _valueLabel.textColor = BLACKTEXTCOLOR;
                _valueLabel.textAlignment = NSTextAlignmentLeft;
                _valueLabel.adjustsFontSizeToFitWidth = YES;
                _valueLabel.minimumScaleFactor = 0.6;
                [self.contentView addSubview:_valueLabel];
                _valueLabel.sd_layout
                .centerYEqualToView(self.contentView)
                .leftSpaceToView(_titleLabel, 0)
                .rightSpaceToView(self.contentView, 30)
                .heightIs(16);
            }
            
        }else if ([reuseIdentifier isEqualToString:kCellIdentifier_OnlyValue]){
            
            if (!_titleLabel) {
                _titleLabel = [[UILabel alloc] init];
                _titleLabel.backgroundColor = [UIColor clearColor];
                _titleLabel.font = [UIFont systemFontOfSize:15];
                _titleLabel.textColor = [UIColor blackColor];
                _titleLabel.textAlignment = NSTextAlignmentCenter;
                [self.contentView addSubview:_titleLabel];
                
                _titleLabel.sd_layout
                .centerXEqualToView(self.contentView)
                .topSpaceToView(self.contentView, 0)
                .widthIs(SCREEN_WIDTH)
                .heightIs(45);
                
            }
            
            if (!_valueLabel) {
                _valueLabel = [[UILabel alloc] init];
                _valueLabel.backgroundColor = [UIColor clearColor];
                _valueLabel.font = [UIFont systemFontOfSize:15];
                _valueLabel.textColor = BLACKTEXTCOLOR;
                _valueLabel.textAlignment = NSTextAlignmentLeft;
                _valueLabel.adjustsFontSizeToFitWidth = YES;
                _valueLabel.minimumScaleFactor = 0.6;
                [self.contentView addSubview:_valueLabel];
                
                _valueLabel.sd_layout
                .topSpaceToView(_titleLabel, 0)
                .leftSpaceToView(self.contentView, 30)
                .rightSpaceToView(self.contentView, 30)
                .autoHeightRatio(0);
            }
            
            [self setupAutoHeightWithBottomView:_valueLabel bottomMargin:60];
        }
        
        _currentReuseIdentifier = reuseIdentifier;
        
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    if ([_currentReuseIdentifier isEqualToString:kCellIdentifier_Input_OnlyText_TextField]) {
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:_phStr? _phStr: @"" attributes:@{NSForegroundColorAttributeName: BLACKTEXTCOLOR}];
        _textField.text = _valueStr;
    }

}

- (void)configWithPlaceholder:(NSString *)phStr valueStr:(NSString *)valueStr{
    self.phStr = phStr;
    self.valueStr = valueStr;
}

#pragma mark - 只有标题和内容
- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value{
    _titleLabel.text = title;
    _valueLabel.text = value;
}


#pragma mark TextField
- (void)editDidBegin:(id)sender {

    if (self.editDidBeginBlock) {
        self.editDidBeginBlock(self.textField.text);
    }
}

- (void)editDidEnd:(id)sender {
    self.clearBtn.hidden = YES;
    
    if (self.editDidEndBlock) {
        self.editDidEndBlock(self.textField.text);
    }
}

- (void)textValueChanged:(id)sender {
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(self.textField.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
