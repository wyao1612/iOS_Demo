//
//  UIButton+Addtion.m
//  GolfIOS
//
//  Created by mac mini on 16/11/17.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "UIButton+Addtion.h"
#import <objc/runtime.h>
static const char btnKey;

@implementation UIButton (Addtion)
- (void)handelWithBlock:(btnBlock)block
{
    if (block)
    {
        //设置关联对象
        objc_setAssociatedObject(self, &btnKey, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [self addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 设置按钮带边框
-(UIButton*)buttonWithTitle:(NSString*)title
                 TitleColor:(UIColor*)color
                 TitleFont:(UIFont*)font
                 BorderColor:(UIColor*)borderColor
               CornerRadius:(CGFloat)radius{

    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    self.titleLabel.font = font;
    self.layer.borderColor = borderColor.CGColor;
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:0.5];
    return self;
}

#pragma mark - 点击事件
- (void)btnAction
{
    //获取关联对象
    btnBlock block = objc_getAssociatedObject(self, &btnKey);
    block();
}

@end

