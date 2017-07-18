//
//  FTT_PickerView.h
//  FTT_PickerView
//
//  Created by cmcc on 16/8/31.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
// 展示的风格
typedef NS_ENUM(NSInteger , FTT_PickerViewShowType) {
    FTT_PickerViewShowTypeSheet= 0,
    FTT_PickerViewShowTypeAlert,
};

typedef NS_ENUM(NSInteger , FTT_PickerViewType) {
    FTT_PickerViewTypeTime = 0,
    FTT_PickerViewTypeAddress ,
    FTT_PickerViewTypeOther ,
};

@interface YWPickerView : UIView

@property (nonatomic , copy) void(^select)(NSString *selectString);
@property (nonatomic , assign) FTT_PickerViewType type;
@property (nonatomic , assign) FTT_PickerViewShowType showType;
- (instancetype)initWithFrame:(CGRect)frame PickerViewType:(FTT_PickerViewShowType)showtype DataSoucre:(NSMutableArray *)array;
-(void)showCityView:(void(^)(NSString *selectString))selectStr;
@end
