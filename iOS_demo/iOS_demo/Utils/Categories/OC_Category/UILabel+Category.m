//
//  UILabel+Category.m
//  GolfIOS
//
//  Created by mac mini on 16/11/15.
//  Copyright © 2016年 zzz. All rights reserved.
//

#define UILABEL_LINE_SPACE 6
#define HEIGHT [ [ UIScreen mainScreen ] bounds ].size.height

#import "UILabel+Category.h"

@implementation UILabel (Category)

+ (instancetype)labelWithText:(NSString*)text andTextColor:(UIColor*)textColor andFontSize:(CGFloat)fontSize
{
    UILabel* label = [[self alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}

+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

//设置行间距
-(void)setText:(NSString *)text withLineSpacing:(float)spacing
{
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:spacing];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [text length])];
    [self setAttributedText:attributedString1];
    //[self sizeToFit];
}


//计算UILabel的高度(带有行间距的情况)
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width WithLineSpace:(float)space{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = space;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

//给某段文字设置颜色和字体大小
-(UILabel*)attribute:(NSString *)str changeString:(NSString*)changeString  color:(UIColor*)color  font:(UIFont*)font{

    //必须先赋值string再设置string的属性，否则无效
    self.text = str;
    //设置需要改变的字符串字体属性
    
    //创建一个可变属性的字符串
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
    
    //获取需要改变的字符串所在位置
    NSRange rangel = [str rangeOfString:changeString];
    
    
    //设置需要修改字符串的属性：颜色 大小等等
    [textColor addAttribute:NSForegroundColorAttributeName value:color range:rangel];
    [textColor addAttribute:NSFontAttributeName value:font range:rangel];
    
    [self setAttributedText:textColor];
    
    return self;
}

//给文字加下划线
-(void)setUnderLineWithColor:(UIColor*)color
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attri addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, self.text.length)];
    if (color)
    {
        [attri addAttribute:NSUnderlineColorAttributeName value:color range:NSMakeRange(0, self.text.length)];
    }
    
    [self setAttributedText:attri];
    
}

//添加中划线
-(void)setMidLineWithColor:(UIColor*)color
{
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:NSMakeRange(0, self.text.length)];
    if (color)
    {
        [attri addAttribute:NSStrikethroughColorAttributeName value:color range:NSMakeRange(0, self.text.length)];
    }
    
    [self setAttributedText:attri];
    
}

@end
