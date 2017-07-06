//
//  UIButton+category.h
//  button
//
//  Created by wyao on 16/11/28.
//  Copyright © 2016年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 设置标题的样式
 */
typedef NS_ENUM(NSUInteger, WYCustomerButtonStyle){
    
    //标题的位置
    WYCustomerButtonStyleTop = 1, // 标题的位置在上;
    WYCustomerButtonStyleBelow, // 标题的位置在下;
    WYCustomerButtonStyleLeft, // 标题的位置在左;
    WYCustomerButtonStyleRight, // 标题的位置在右;
    
};

/**
 点击按钮的block类型

 @param sender 按键
 */
typedef void (^TargetBlock)(UIButton *sender);

@interface UIButton (category)

/**
 点击事件的回调block
 */
@property (nonatomic,copy)  TargetBlock TargetBlock;

/**
 设置自定义的Button的样式

 @param style  样式类型
 @param margin 间距
 @param target 点击事件Block
 */
- (void)setTitleRespectToImageWithStyle:(WYCustomerButtonStyle)style Margin:(CGFloat)margin addTarget:(TargetBlock)target;

@end
