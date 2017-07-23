//
//  MFPlaceholderTextView.h
//  MissF
//
//  Created by wyao on 2017/7/23.
//  Copyright © 2017年 wyao. All rights reserved.
//


#import <UIKit/UIKit.h>
/**
 *  带默认提示的textView
 */


@class MFplaceholderTextView;

@interface MFplaceholderTextView : UITextView<UITextViewDelegate>

@property (copy, nonatomic) NSString *placeholder;
@property (assign, nonatomic) NSInteger maxLength;//最大长度
@property (strong, nonatomic) UILabel *placeholderLabel;
@property (strong, nonatomic) UILabel *wordNumLabel;

//文字输入
@property (copy, nonatomic) void(^didChangeText)(MFplaceholderTextView *textView);
- (void)didChangeText:(void(^)(MFplaceholderTextView *textView))block;

@end
