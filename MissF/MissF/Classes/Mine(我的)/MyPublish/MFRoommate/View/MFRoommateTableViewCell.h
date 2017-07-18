//
//  MFRoommateTableViewCell.h
//  MissF
//
//  Created by wyao on 2017/7/13.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kCellIdentifier_Input_OnlyText_TextField @"kCellIdentifier_Input_OnlyText_TextField"
#define kCellIdentifier_TitleValue      @"kCellIdentifier_TitleValue"
#define kCellIdentifier_TitleValueMore  @"kCellIdentifier_TitleValueMore"
#define kCellIdentifier_OnlyValue        @"kCellIdentifier_Onlytext"

@interface MFRoommateTableViewCell : UITableViewCell
@property (strong, nonatomic) UITextField *textField;
@property (nonatomic,copy) void(^textValueChangedBlock)(NSString *);
@property (nonatomic,copy) void(^editDidBeginBlock)(NSString *);
@property (nonatomic,copy) void(^editDidEndBlock)(NSString *);
@property (strong, nonatomic) UILabel *titleLabel, *valueLabel;
- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value;
- (void)setTitleStr:(NSString *)title valueStr:(NSString *)value withValueColor:(UIColor*)color;
- (void)configWithPlaceholder:(NSString *)phStr valueStr:(NSString *)valueStr;
@end
