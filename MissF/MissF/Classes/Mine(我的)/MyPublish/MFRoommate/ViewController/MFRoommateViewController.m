//
//  MFRoommateViewController.m
//  MissF
//
//  Created by wyao on 2017/7/13.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFRoommateViewController.h"
#import "MFRoommateTableViewProxy.h"
#import "MFRoommateViewModel.h"
#import "MFRoommateTableViewCell.h"
#import "MFRoommateTagsViewCell.h"

@interface MFRoommateViewController () <UIScrollViewDelegate>
@property(strong,nonatomic) UIImageView* headerImageView;
@property(strong,nonatomic) UIImageView* avatarView;
@property(strong,nonatomic) UILabel    * nameLabel;
@property(strong,nonatomic) UILabel    * commentLable;
@property(strong,nonatomic) UIView     * headerBackView;
/** 负责逻辑处理 */
@property (nonatomic, strong) MFRoommateViewModel *roommateViewModel;
/** tableView代理 */
@property (nonatomic, strong) MFRoommateTableViewProxy *roommateTableViewProxy;

@end

@implementation MFRoommateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAutoBack = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.roommateTableView];
}

//滚动tableview 完毕之后
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //图片高度
    CGFloat imageHeight = self.headerBackView.frame.size.height;
    //图片宽度
    CGFloat imageWidth = SCREEN_WIDTH;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    //NSLog(@"图片上下偏移量 imageOffsetY:%f ->",imageOffsetY);
    //上移
    if (imageOffsetY < 0) {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY) - 57;
        CGFloat f = (imageHeight + ABS(imageOffsetY) ) / imageHeight;
        
        self.headerImageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
    }
}


#pragma mark - lazy method


- (MFRoommateTableViewProxy *)roommateTableViewProxy {
    if (_roommateTableViewProxy== nil){
        _roommateTableViewProxy = [[MFRoommateTableViewProxy alloc] init];
        weak(self);
        _roommateTableViewProxy.RoommateProxyScrollBlock = ^(UIScrollView *scrollView) {
            [weakSelf scrollViewDidScroll:scrollView];
        } ;
    }
    return _roommateTableViewProxy;
}



- (UITableView *)roommateTableView {
    if (_roommateTableView == nil){
        _roommateTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _roommateTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT);
        _roommateTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _roommateTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _roommateTableView.separatorColor = GRAYCOLOR;
        [_roommateTableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_TitleValue];
        [_roommateTableView registerClass:[MFRoommateTagsViewCell class] forCellReuseIdentifier:kCellIdentifier_TagsViewCell];
        [_roommateTableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_OnlyValue];
        _roommateTableView.showsVerticalScrollIndicator = NO;
        _roommateTableView.backgroundColor = BACKGROUNDCOLOR;
        _roommateTableView.delegate = self.roommateTableViewProxy;
        _roommateTableView.dataSource = self.roommateTableViewProxy;
        _roommateTableView.mj_header = nil;
        _roommateTableView.mj_footer = nil;
        _roommateTableView.tableHeaderView = self.headerBackView;
        _roommateTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
        
    }
    return _roommateTableView;
}

-(UIView *)headerBackView{
    if (!_headerBackView) {
        _headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 350)];
        _headerBackView.backgroundColor = WHITECOLOR;

        [_headerBackView addSubview:self.headerImageView];
        [_headerBackView addSubview:self.avatarView];
        [_headerBackView addSubview:self.nameLabel];
        [_headerBackView addSubview:self.commentLable];
    }
    return _headerBackView;
}


-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 293)];
        _headerImageView.image = IMAGE(@"4311500026847.jpg");
        [_headerImageView setBackgroundColor:[UIColor whiteColor]];
        [_headerImageView setContentMode:UIViewContentModeRedraw];
        [_headerImageView setClipsToBounds:YES];
    }
    return _headerImageView;
}
- (UIImageView *)avatarView {
    if (_avatarView == nil){
        _avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(14, CGRectGetMaxY(self.headerImageView.frame)-30, 60, 60)];
        _avatarView.backgroundColor = [UIColor cyanColor];;
        _avatarView.layer.cornerRadius = 30;
        _avatarView.layer.masksToBounds = YES;
    }
    return _avatarView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarView.frame)+30, CGRectGetMaxY(self.headerImageView.frame)+10, SCREEN_WIDTH-120, 15)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"不请自来的蚊子";
        _nameLabel.textColor = BLACKTEXTCOLOR;
    }
    return _nameLabel;
}

- (UILabel *)commentLable {
    if (_commentLable == nil){
        _commentLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarView.frame)+30, CGRectGetMaxY(self.nameLabel.frame)+10, SCREEN_WIDTH-120, 15)];
        _commentLable.font = [UIFont systemFontOfSize:13];
        _commentLable.textAlignment = NSTextAlignmentLeft;
        _commentLable.text = @"天秤座 · 女 · 律师";
        _commentLable.textColor = BLACKTEXTCOLOR;
    }
    return _commentLable;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
