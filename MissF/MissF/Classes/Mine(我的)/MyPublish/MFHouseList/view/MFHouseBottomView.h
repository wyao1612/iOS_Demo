//
//  MFHouseBottomView.h
//  MissF
//
//  Created by wyao on 2017/7/8.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShopcartBotttomViewDeleteBlock)(void);


@interface MFHouseBottomView : UIView
@property (nonatomic, copy) ShopcartBotttomViewDeleteBlock shopcartBotttomViewDeleteBlock;

- (void)configureShopcartBottomViewWithTotalPrice:(double)totalPrice
                                       totalCount:(NSInteger)totalCount
                                    isAllselected:(BOOL)isAllSelected;

@end
