//
//  YWSegmentTitleView.m
//  YWScrollContentView
//
//  Created by wyao on 2017/5/26.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "YWSegmentTitleView.h"

@interface YWSegmentTitleView()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray<UIButton *> *itemButtons;
@property (nonatomic, weak) UIView *indicatorView;
@end

@implementation YWSegmentTitleView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self initData];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initData];
    }
    return self;
}

- (void)initData{
    self.titleNormalColor = [UIColor blackColor];
    self.titleSelectedColor = [UIColor redColor];
    self.selectedIndex = 0;
    self.titleFont = [UIFont systemFontOfSize:14.f];
    self.indicatorColor = [UIColor redColor];
    self.indicatorHeight = 2.f;
    self.indicatorExtraW = 5.f;
    self.indicatorBottomMargin = 0;
    self.itemMinMargin = 25.f;
    self.AvgBtnCount = 0;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    if (self.itemButtons.count == 0) {
        return;
    }
    
    CGFloat totalBtnW = 0;
    CGFloat itemMarginW = 0;
    CGFloat btnW = 0;
    CGFloat lastX = 0;
    if (self.AvgBtnCount > 0) {//均分选项
        btnW = self.bounds.size.width/self.AvgBtnCount;
    }else{  //不均分选项
        for (UIButton *btn in self.itemButtons) {
            [btn sizeToFit];
            totalBtnW += btn.frame.size.width;
        }
        
         itemMarginW = (self.scrollView.frame.size.width - totalBtnW) / (self.itemButtons.count + 1);
        if (itemMarginW < self.itemMinMargin) {
            itemMarginW = self.itemMinMargin;
        }
        
        lastX = itemMarginW;
    }

    for (UIButton *btn in self.itemButtons) {
        [btn sizeToFit];
        btn.frame = CGRectMake(lastX, 0, btnW==0?btn.frame.size.width:btnW, self.scrollView.frame.size.height);
        lastX += btn.frame.size.width + itemMarginW;
    }
    
    self.scrollView.contentSize = CGSizeMake(lastX, self.scrollView.frame.size.height);
    [self setSelectedIndicatorFrame:NO];
}

- (void)setSelectedIndicatorFrame:(BOOL)animated{
    __weak typeof (self) weakSelf = self;
    UIButton *selectedBtn = self.itemButtons[self.selectedIndex];
    CGFloat currentBtnTitleW = [self sizeWithText:selectedBtn.titleLabel.text font:self.titleFont maxW:self.size.width].width;
    CGFloat SelectedIndicatorOriginX= 0;
    CGFloat SelectedIndicatorW= 0;
    if (self.AvgBtnCount>0) {
        SelectedIndicatorOriginX = selectedBtn.frame.origin.x +(selectedBtn.frame.size.width-currentBtnTitleW)*0.5;
        SelectedIndicatorW = currentBtnTitleW;
    }else{
        SelectedIndicatorOriginX = selectedBtn.frame.origin.x - weakSelf.indicatorExtraW;
        SelectedIndicatorW = selectedBtn.frame.size.width + 2 * weakSelf.indicatorExtraW;
    }
  
    [UIView animateWithDuration:(animated? 0.2 : 0) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        weakSelf.indicatorView.frame = CGRectMake(SelectedIndicatorOriginX, weakSelf.scrollView.frame.size.height - weakSelf.indicatorHeight - weakSelf.indicatorBottomMargin, SelectedIndicatorW,weakSelf.indicatorHeight);
    } completion:^(BOOL finished) {
        [weakSelf scrollRectToVisibleCenterAnimated:animated];
    }];
}

- (void)scrollRectToVisibleCenterAnimated:(BOOL)animated {
    UIButton *selectedBtn = self.itemButtons[self.selectedIndex];
    CGRect centeredRect = CGRectMake(selectedBtn.center.x - self.scrollView.frame.size.width / 2, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView scrollRectToVisible:centeredRect animated:animated];
}

#pragma mark - getter

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        scrollView.scrollsToTop = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIView *)indicatorView{
    if (!_indicatorView) {
        UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.scrollView addSubview:indicatorView];
        indicatorView.backgroundColor = [UIColor lightGrayColor];
        _indicatorView = indicatorView;
    }
    return _indicatorView;
}

- (NSMutableArray<UIButton *> *)itemButtons{
    if (!_itemButtons) {
        _itemButtons = [[NSMutableArray alloc] init];
    }
    return _itemButtons;
}


#pragma mark - setter

- (void)setSegmentTitles:(NSArray<NSString *> *)segmentTitles{
    [self.itemButtons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemButtons = nil;
    for (NSString *title in segmentTitles) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.selectedIndex == self.itemButtons.count) {
            btn.selected = YES;
        }
        btn.tag = 888 + self.itemButtons.count;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = self.titleFont;
        [self.scrollView addSubview:btn];
        [self.itemButtons addObject:btn];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if (_selectedIndex == selectedIndex || selectedIndex < 0 || selectedIndex > self.itemButtons.count - 1 || self.itemButtons.count <= 0) {
        return;
    }
    UIButton *btn = [self.scrollView viewWithTag:_selectedIndex + 888];
    btn.selected = NO;
    _selectedIndex = selectedIndex;
    UIButton *selectedBtn = [self.scrollView viewWithTag:_selectedIndex + 888];
    selectedBtn.selected = YES;
    [self setSelectedIndicatorFrame:YES];
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor{
    _titleNormalColor = titleNormalColor;
    for (UIButton *btn in self.itemButtons) {
        [btn setTitleColor:titleNormalColor forState:UIControlStateNormal];
    }
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor{
    _titleSelectedColor = titleSelectedColor;
    for (UIButton *btn in self.itemButtons) {
        [btn setTitleColor:titleSelectedColor forState:UIControlStateSelected];
    }
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    for (UIButton *btn in self.itemButtons) {
        btn.titleLabel.font = titleFont;
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor = indicatorColor;
    self.indicatorView.backgroundColor = indicatorColor;
}

- (void)setIndicatorHeight:(CGFloat)indicatorHeight{
    _indicatorHeight = indicatorHeight;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setIndicatorExtraW:(NSInteger)indicatorExtraW{
    _indicatorExtraW = indicatorExtraW;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setItemMinMargin:(NSInteger)itemMinMargin{
    _itemMinMargin = itemMinMargin;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setIndicatorBottomMargin:(NSInteger)indicatorBottomMargin{
    _indicatorBottomMargin = indicatorBottomMargin;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - EventResponse
- (void)btnClick:(UIButton *)btn{
    NSInteger btnIndex = btn.tag - 888;
    if (btnIndex == self.selectedIndex) {
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentTitleView:selectedIndex:lastSelectedIndex:)]) {
        [self.delegate segmentTitleView:self selectedIndex:btnIndex lastSelectedIndex:self.selectedIndex];
    }
    self.selectedIndex = btnIndex;
}

#pragma mark - 私有方法获取文字宽度
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
