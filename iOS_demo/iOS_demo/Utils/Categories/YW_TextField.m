//
//  YW_TextField.m
//  WSD
//
//  Created by wyao on 2017/2/5.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "YW_TextField.h"

@implementation YW_TextField

-(void)setTextFiledLeftImageName:(NSString*)image{
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    //设置边框的颜色
    self.layer.borderWidth = 1.0f;
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    UIColor *borderColor  = _borderColor == nil ?[UIColor colorWithHex:0xe8e8e8] :_borderColor;
    self.layer.borderColor = [borderColor CGColor];
    // 设置光标的颜色
    self.tintColor = [UIColor redColor];
    // 设置占位文字的颜色为红色(注意下面的'self'代表你要修改占位文字的UITextField控件)
    [self setValue:LIGHTTEXTCOLOR forKeyPath:@"_placeholderLabel.textColor"];
}

//重写左边图标的X值
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 10;
    return iconRect;
}

//  重写占位符的x值
- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    placeholderRect.origin.x += 1;
    return placeholderRect;
}

//  重写文字输入时的X值
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x += 10;
    return editingRect;
}

//  重写文字显示时的X值
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect textRect = [super editingRectForBounds:bounds];
    textRect.origin.x += 10;
    return textRect;
}

@end
