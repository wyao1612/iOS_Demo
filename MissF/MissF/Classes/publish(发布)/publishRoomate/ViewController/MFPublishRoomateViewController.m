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

@interface MFPublishRoomateViewController ()
@property(strong,nonatomic) UIImageView* headerImageView;
@property(strong,nonatomic) UIImageView* avatarView;
@property(strong,nonatomic) UIView     * headerBackView;
@property(strong,nonatomic) UILabel    * nameLabel;
@property (nonatomic, strong) MFPublishRoommateTableViewProxy *publishRoommateTableViewProxy;
@end

@implementation MFPublishRoomateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"室友";
    self.isAutoBack = NO;
    self.rightStr_1 = @"发送";
     [self setTableViewUI];
}
-(void)right_1_action{
    [SVProgressHUD showSuccessWithStatus:@"发送"];
}

-(void)setTableViewUI{
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableView.separatorColor = GRAYCOLOR;
    self.tableView.backgroundColor = BACKGROUNDCOLOR;
            
    //非编辑状态 不带箭头
    [self.tableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_TitleValueMore];
    [self.tableView registerClass:[MFRoommateTagsViewCell class] forCellReuseIdentifier:kCellIdentifier_TagsViewCell];
    [self.tableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_OnlyValue];
     [self.tableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_TextField];
    
    self.tableView.delegate = self.publishRoommateTableViewProxy;
    self.tableView.dataSource = self.publishRoommateTableViewProxy;
    self.tableView.tableHeaderView = self.headerBackView;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
}

#pragma mark - lazy method
- (MFPublishRoommateTableViewProxy *)publishRoommateTableViewProxy {
    if (_publishRoommateTableViewProxy== nil){
        _publishRoommateTableViewProxy = [[MFPublishRoommateTableViewProxy alloc] init];
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
