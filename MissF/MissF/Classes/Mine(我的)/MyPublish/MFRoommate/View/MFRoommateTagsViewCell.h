//
//  MFRoommateTagsViewCell.h
//  MissF
//
//  Created by wyao on 2017/7/13.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCellIdentifier_TagsViewCell    @"MFRoommateTagsViewCell"

typedef NS_ENUM(NSInteger , MFCellTagsViewType) {
    MF_TagsViewTypeNormal = 0,
    MF_TagsViewTypeEdit ,
};
typedef void(^CellMoreBlock)(UIButton* sender);


@interface MFRoommateTagsViewCell : UITableViewCell
/** 用于自定义选择按钮点击回调*/
@property (nonatomic, copy) CellMoreBlock CellMoreBlock;
-(CGFloat)getCellHeightWtihBtnsWithModelArray:(NSArray*)modelArray;
-(void)setUIwithModelArray:(NSArray*)modelArray andTagsName:(NSString*)tagsName withTagStyle:(MFCellTagsViewType)tagViewStyle;
@end
