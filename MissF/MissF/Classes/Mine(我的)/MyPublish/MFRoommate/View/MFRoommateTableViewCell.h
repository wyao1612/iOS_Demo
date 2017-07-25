//
//  MFRoommateTableViewCell.h
//  MissF
//
//  Created by wyao on 2017/7/13.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFplaceholderTextView.h"

#define kCellIdentifier_Input_OnlyText_TextField @"kCellIdentifier_Input_OnlyText_TextField"
#define kCellIdentifier_TitleValue      @"kCellIdentifier_TitleValue"
#define kCellIdentifier_TitleValueMore  @"kCellIdentifier_TitleValueMore"
#define kCellIdentifier_OnlyValue        @"kCellIdentifier_Onlytext"
#define kCellIdentifier_textView        @"kCellIdentifier_textView"

@interface MFRoommateTableViewCell : UITableViewCell
@property (strong, nonatomic) UITextField *textField;
@property (nonatomic,copy) void(^textValueChangedBlock)(NSString *text);
@property (nonatomic,copy) void(^editDidBeginBlock)(NSString *text);
@property (nonatomic,copy) void(^editDidEndBlock)(NSString *text);
@property (strong, nonatomic) UILabel *titleLabel, *valueLabel;
- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value;
- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value withValueColor:(UIColor*)color;
- (void)configWithTitle:(NSString *)title valueStr:(NSString *)valueStr placeholderStr:(NSString *)placeholderStr  isPriceTf:(BOOL)isprice;
@property (strong, nonatomic) MFplaceholderTextView *textView;
@end
