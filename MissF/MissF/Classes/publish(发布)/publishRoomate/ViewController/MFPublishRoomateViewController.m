//
//  MFPublishRoomateViewController.m
//  MissF
//
//  Created by wyao on 2017/7/17.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFPublishRoomateViewController.h"
#import "MFRoommateTableViewCell.h"
#import "MFRoommateTagsViewCell.h"
#import "MFPublishRoommateTableViewProxy.h"
#import "MFTagsViewController.h"
#import "MainViewController.h"

@interface MFPublishRoomateViewController ()
@property(strong,nonatomic) UIImageView* headerImageView;
@property(strong,nonatomic) UIImageView* avatarView;
@property(strong,nonatomic) UIView     * headerBackView;
@property(strong,nonatomic) UILabel    * nameLabel;
@property (nonatomic, strong) MFPublishRoommateTableViewProxy *publishRoommateTableViewProxy;
@property (nonatomic, strong) UITableView *PublishRoomateTableView;
@end

@implementation MFPublishRoomateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"室友";
    self.isAutoBack = NO;
    self.rightStr_1 = @"发送";
    [self.view addSubview:self.PublishRoomateTableView];
}
-(void)right_1_action{
    [SVProgressHUD showSuccessWithStatus:@"发送"];
}

- (UITableView *)PublishRoomateTableView {
    if (_PublishRoomateTableView == nil){
        _PublishRoomateTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _PublishRoomateTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT);
       _PublishRoomateTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
       _PublishRoomateTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
       _PublishRoomateTableView.separatorColor = GRAYCOLOR;
       _PublishRoomateTableView.backgroundColor = BACKGROUNDCOLOR;
        _PublishRoomateTableView.showsVerticalScrollIndicator = NO;
        
        //非编辑状态 不带箭头
        [_PublishRoomateTableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_TitleValueMore];
        [_PublishRoomateTableView registerClass:[MFRoommateTagsViewCell class] forCellReuseIdentifier:kCellIdentifier_TagsViewCell];
        [_PublishRoomateTableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_OnlyValue];
        [_PublishRoomateTableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_TextField];
        
        _PublishRoomateTableView.delegate = self.publishRoommateTableViewProxy;
        _PublishRoomateTableView.dataSource = self.publishRoommateTableViewProxy;
        _PublishRoomateTableView.tableHeaderView = self.headerBackView;
        _PublishRoomateTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    }
    return _PublishRoomateTableView;
}


#pragma mark - lazy method
- (MFPublishRoommateTableViewProxy *)publishRoommateTableViewProxy {
    if (_publishRoommateTableViewProxy== nil){
        weak(self);
        _publishRoommateTableViewProxy = [[MFPublishRoommateTableViewProxy alloc] init];
        _publishRoommateTableViewProxy.PublishRoommateProxySelectBlock = ^(UIButton *sender, NSIndexPath *indexPath) {
            
            if (indexPath.section == 0 && indexPath.row == 0) {//选择地图
                MainViewController *vc= [[MainViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                MFTagsViewController *vc = [[MFTagsViewController alloc] init];
                vc.selectBlock = ^(NSArray *selectArray) {
                    NSLog(@"%@",selectArray);
                };
                if (indexPath.section == 1) {//所有个性标签
                    vc.MFTagsViewType = MF_TagsViewType_AllTags;
                }
                else if (indexPath.section == 2){//对应属性标签
                    vc.MFTagsViewType = MF_TagsViewType_roommateRequires;
                }
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        };
    }
    return _publishRoommateTableViewProxy;
}

-(UIView *)headerBackView{
    if (!_headerBackView) {
        _headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
        _headerBackView.backgroundColor = WHITECOLOR;
        [_headerBackView addSubview:self.headerImageView];
        [_headerBackView addSubview:self.nameLabel];
    }
    return _headerBackView;
}

-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-147)*0.5, (175-76)*0.5, 147, 76)];
        _headerImageView.image = IMAGE(@"icon_Release_house_nor");
        [_headerImageView setBackgroundColor:[UIColor whiteColor]];
        [_headerImageView setContentMode:UIViewContentModeRedraw];
        [_headerImageView setClipsToBounds:YES];
    }
    return _headerImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 280)*0.5, CGRectGetMaxY(self.headerImageView.frame)+20, 280, 15)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"听说长得好看的人租房费用都比较低哦~";
        _nameLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _nameLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
