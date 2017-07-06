//
//  YWScrollContentView.h
//  YWScrollContentView
//
//  Created by wyao on 2017/5/26.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YWScrollContentView;

@protocol YWScrollContentViewDelegate <NSObject>

@optional

- (void)contentViewDidScroll:(YWScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress;

- (void)contentViewDidEndDecelerating:(YWScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end

@interface YWScrollContentView : UIView

/**
 加载滚动视图的界面
 
 @param colCount 多少个视图
 */
- (void)reloadViewWithColCount:(NSInteger)colCount;

@property (nonatomic, weak) id<YWScrollContentViewDelegate> delegate;

/**
 设置当前滚动到第几个页面，默认为第0页
 */
@property (nonatomic, assign) NSInteger currentIndex;

@end
