//
//  MFpublishViewController.h
//  MissF
//
//  Created by wyao on 2017/7/23.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseViewController.h"
#import "MFRoommateTableViewCell.h"
#import "MFRoommateTagsViewCell.h"
#import "HXPhotoView.h"
#import "MFPublishViewModel.h"

typedef NS_ENUM(NSInteger , MFpublishHeaderViewType) {
    MFpublishHeaderViewTypeHouse = 0,
    MFpublishHeaderViewTypeRoomate ,
};


@interface MFpublishViewController : BaseViewController<HXPhotoViewDelegate>
@property(nonatomic,assign)  MFpublishHeaderViewType  headerViewStyle;
@property(strong,nonatomic) UIImageView* headerImageView;
@property(strong,nonatomic) UIImageView* avatarView;
@property(strong,nonatomic) UIView     * headerBackView;
@property(strong,nonatomic) UILabel    * nameLabel;
@property(strong,nonatomic) UIView     * tableFooterView;
@property(strong,nonatomic) UITableView *PublishTableView;
@property (strong, nonatomic) HXPhotoView *onePhotoView;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (nonatomic, strong) MFPublishViewModel* publishViewModel;
@property (strong, nonatomic) NSString *markString;
/** 头部相册选择器*/
-(void)setOnePhotoViewWith:(UIView*)photoView andPhotos:(NSArray<HXPhotoModel *> *)photos;
/** 设置cell的显示*/
-(void)setCellwith:(MFRoommateTableViewCell *)cell title:(NSString*)title withValue:(NSString*)value andPlaceholderText:(NSString*)placeholderText;
@end
