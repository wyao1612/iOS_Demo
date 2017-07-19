//
//  MFTagsViewController.h
//  MissF
//
//  Created by wyao on 2017/7/15.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger , MFTagsViewType) {
    MF_TagsViewType_AllTags = 0,
    MF_TagsViewType_roommateRequires = 1 ,
    MF_TagsViewType_paymentType = 2 ,
};


typedef void(^MFTagsViewSelectBlock)(NSArray *selectArray);
@interface MFTagsViewController : BaseViewController
@property(copy,nonatomic)MFTagsViewSelectBlock selectBlock;
/** 区别是全部个性属性还是单独对应属性的标签*/
@property(assign,nonatomic)MFTagsViewType MFTagsViewType;
/**
 单个属性标签列表
 @param nameText 标签属性名称
 */
-(void)setOnlyTagsWithName:(NSString*)nameText;

@end
