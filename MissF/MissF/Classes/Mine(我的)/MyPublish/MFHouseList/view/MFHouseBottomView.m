//
//  MFHouseBottomView.m
//  MissF
//
//  Created by wyao on 2017/7/8.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFHouseBottomView.h"

@interface MFHouseBottomView ()
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation MFHouseBottomView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor blackColor];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    [self addSubview:self.deleteButton];
    
    self.deleteButton.sd_layout
    .topSpaceToView(self, 0)
    .rightSpaceToView(self, 0)
    .bottomSpaceToView(self, 0)
    .widthIs(SCREEN_WIDTH);

}

- (void)configureShopcartBottomViewWithTotalPrice:(double)totalPrice totalCount:(NSInteger)totalCount isAllselected:(BOOL)isAllSelected {
    
    self.deleteButton.enabled = totalCount;
    if (self.deleteButton.isEnabled) {
        [self.deleteButton setBackgroundColor:[UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1]];
    } else {
        [self.deleteButton setBackgroundColor:[UIColor lightGrayColor]];
        [self.deleteButton setBackgroundColor:[UIColor lightGrayColor]];
    }
}



- (void)deleteButtonAction {
    if (self.shopcartBotttomViewDeleteBlock) {
        self.shopcartBotttomViewDeleteBlock();
    }
}

- (UIButton *)deleteButton {
    if (_deleteButton == nil){
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_deleteButton setBackgroundColor:GLOBALCOLOR];
        [_deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.enabled = YES;
        _deleteButton.hidden = NO;
    }
    return _deleteButton;
}

@end
