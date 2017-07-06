//
//  UIButton+Addtion.h
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addtion)

/**
 点击回调的block
 */
typedef void (^btnBlock)();

/**
 通过运行时设置关联对象实现用block监听button点击

 @param block 点击回调的block
 */
- (void)handelWithBlock:(btnBlock)block;

/**
 设置TSOU的所有蓝色款的按钮视图

 @param color 文字的颜色
 @param font 文字的大小
 @param borderColor 边框的颜色
 @param radius 圆角的半径（默认边框宽度为0.5）
 */
-(UIButton*)buttonWithTitle:(NSString*)title
                 TitleColor:(UIColor*)color
                  TitleFont:(UIFont*)font
                BorderColor:(UIColor*)borderColor
               CornerRadius:(CGFloat)radius;

@end
