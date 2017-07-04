//
//  UIButton+category.m
//  button
//
//  Created by wyao on 16/11/28.
//  Copyright © 2016年 wyao. All rights reserved.
//

#import "UIButton+category.h"
#import <objc/runtime.h>

static const void *IndieBandNameKey = &IndieBandNameKey;

@implementation UIButton (category)

//利用运行时给分类添加属性
-(void)setTargetBlock:(TargetBlock)TargetBlock{
    objc_setAssociatedObject(self, IndieBandNameKey, TargetBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(TargetBlock)TargetBlock{
    return objc_getAssociatedObject(self, IndieBandNameKey);
}


- (void)setTitleRespectToImageWithStyle:(WYCustomerButtonStyle)style Margin:(CGFloat)margin addTarget:(TargetBlock)target{
    
    //重置内边距
    [self setContentEdgeInsets:UIEdgeInsetsZero];
    [self setImageEdgeInsets:UIEdgeInsetsZero];
    [self setTitleEdgeInsets:UIEdgeInsetsZero];

    //给button设置完约束以后一定要调用layoutIfNeeded，不然布局显示就会有问题
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGSize titleSize = [self titleRectForContentRect:contentRect].size;
    CGSize imageSize = [self imageRectForContentRect:contentRect].size;
    
    float halfWidth = (titleSize.width + imageSize.width)/2;
    float halfHeight = (titleSize.height + imageSize.height)/2;
    
    float topInset = MIN(halfHeight, titleSize.height);
    float leftInset = (titleSize.width - imageSize.width)>0?(titleSize.width - imageSize.width)/2:0;
    float bottomInset = (titleSize.height - imageSize.height)>0?(titleSize.height - imageSize.height)/2:0;
    float rightInset = MIN(halfWidth, titleSize.width);
    
    UIEdgeInsets titleInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    UIEdgeInsets imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    

    switch (style) {
        case WYCustomerButtonStyleTop:{
            titleInsets = UIEdgeInsetsMake(-titleSize.height - margin, - halfWidth, imageSize.height + margin, halfWidth);
            [self setContentEdgeInsets:UIEdgeInsetsMake(topInset + margin, leftInset, -bottomInset, -rightInset)];
        }
            break;
        case WYCustomerButtonStyleBelow:{
            titleInsets = UIEdgeInsetsMake(imageSize.height + margin, - halfWidth, -titleSize.height - margin, halfWidth);
            [self setContentEdgeInsets:UIEdgeInsetsMake(-bottomInset, leftInset, topInset + margin, -rightInset)];
        }
            break;
        case WYCustomerButtonStyleLeft: {
            titleInsets = UIEdgeInsetsMake(0, -self.imageView.image.size.width, 0, self.imageView.image.size.width);
            imageInsets = UIEdgeInsetsMake(0, self.titleLabel.bounds.size.width + margin , 0, -self.titleLabel.bounds.size.width - margin);
        }
            break;
        case WYCustomerButtonStyleRight:{
            /*系统默认的方式，只需要设置边距即可*/
            titleInsets = UIEdgeInsetsMake(0, margin, 0, 0);
            imageInsets = UIEdgeInsetsMake(0, - margin , 0,  0);
//            [self setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, margin)];
        }
            break;
            
        default:
            break;
    }
    
    [self setTitleEdgeInsets:titleInsets];
    [self setImageEdgeInsets:imageInsets];
    
    if (target != nil) {
        //全局记录当前的block参数
        self.TargetBlock = target;
        //添加事件
        [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }

}

#pragma mark - 点击事件
- (void)buttonAction:(UIButton *)button
{
    if(self.TargetBlock) {
        self.TargetBlock(button);
    }
    
}


@end
