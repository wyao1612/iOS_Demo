//
//  GBTagListView.h
//  MissF
//
//  Created by wyao on 2017/7/15.
//  Copyright © 2017年 wyao. All rights reserved.
//
#import <UIKit/UIKit.h>
/**
 *  使用说明
 *1、使用的时候直接创建GBtagListView控件，自定义控件的origin、width、高度随传入数组变量变化自适应
 *2、保留几个属性接口方便使用者自定义控件GBbackgroundColor、signalTagColor
 *3、设置控件属性要放在-(void)setTagWithTagArray:(NSArray*)arr;之前才会有效
 *4、设置过单一标签颜色后，多样色失效单一标签颜色优先级要高于多样色属性
 *5  支持设置上下左右的距离但是方法一定要放在-(void)setTagWithTagArray:(NSArray*)arr;之前，否则失效
 *6、祝大家使用愉快如果有bug请指正
 *
 */
@interface GBTagListView : UIView{
    CGRect previousFrame ;
    int totalHeight ;
    NSMutableArray*_tagArr;
    
}
/**
 * 整个view的背景色
 */
@property(nonatomic,strong)UIColor*GBbackgroundColor;
/**
 *  设置单一颜色
 */
@property(nonatomic)UIColor*signalTagColor;
/**
 *  回调统计选中tag
 */
@property(nonatomic,copy)void (^didselectItemBlock)(NSArray*arr,NSInteger ViewTag);

/**
 *  是否可点击
 */
@property(nonatomic) BOOL canTouch;
/**

 *  限制点击个数
 *  0->不限制
 *  不设置此属性默认不限制
 */
@property(nonatomic) NSInteger canTouchNum;

/** 单选模式,该属性的优先级要高于canTouchNum */

@property(nonatomic) BOOL isSingleSelect;
/**
 *  标签文本赋值
 */
-(void)setTagWithTagArray:(NSArray*)arr;
/**
  设置tag之间的距离

 @param Margin Margin
 @param BottomMargin BottomMargin
 */
-(void)setMarginBetweenTagLabel:(CGFloat)Margin AndBottomMargin:(CGFloat)BottomMargin;

/**
 * 选择的按钮
 */
@property(nonatomic,strong)NSArray *selectArray;

@end
