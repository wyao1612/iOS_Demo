//
//  MFRoommateTagsViewCell.h
//  MissF
//
//  Created by wyao on 2017/7/13.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kCellIdentifier_TagsViewCell    @"MFRoommateTagsViewCell"

@interface MFRoommateTagsViewCell : UITableViewCell
-(CGFloat)getCellHeightWtihBtnsWithModelArray:(NSArray*)modelArray;

@end
