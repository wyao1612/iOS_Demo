//
//  UILabel+Category.h
//  GolfIOS
//
//  Created by mac mini on 16/11/15.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Category)
/**
 *  设置label的属性
 */
+ (instancetype)labelWithText:(NSString*)text andTextColor:(UIColor*)textColor andFontSize:(CGFloat)fontSize;
/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
/**
 *  计算UILabel的高度
 */
-(CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width WithLineSpace:(float)space;

/**
 *给某段文字设置颜色和字体大小
 */
-(UILabel*)attribute:(NSString *)str changeString:(NSString*)changeString  color:(UIColor*)color  font:(UIFont*)font;
/**
 *给某段文字加下划线
 */
-(void)setUnderLineWithColor:(UIColor*)color;
/**
 *给某段文字加中划线
 */
-(void)setMidLineWithColor:(UIColor*)color;
/**
 *设置行间距
 */
-(void)setText:(NSString *)text withLineSpacing:(float)spacing;
@end
