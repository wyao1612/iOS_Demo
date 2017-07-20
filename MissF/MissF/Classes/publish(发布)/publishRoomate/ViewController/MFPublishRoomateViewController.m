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
#import "MFTagsViewController.h"
#import "MainViewController.h"
#import "MFRoommateTableViewCell.h"
#import "MFRoommateTagsViewCell.h"
#import "MFPublishViewModel.h"
#import "MFMyProfessionViewController.h"


@interface MFPublishRoomateViewController ()
@property(strong,nonatomic) UIImageView* headerImageView;
@property(strong,nonatomic) UIImageView* avatarView;
@property(strong,nonatomic) UIView     * headerBackView;
@property(strong,nonatomic) UILabel    * nameLabel;
@property (nonatomic, strong) UITableView *PublishRoomateTableView;

@property (nonatomic, strong) YWPickerView* constellationPickerView;
@property (nonatomic, strong) MFPublishViewModel* publishViewModel;
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

-(MFPublishViewModel *)publishViewModel{
    if (!_publishViewModel) {
        _publishViewModel = [[MFPublishViewModel alloc] init];
    }
    return _publishViewModel;
}

#pragma mark - tableview deleagte & datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger num = section == 0? 5: 1;
    return num;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MFRoommateTableViewCell *cell;
    weak(self);
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleValueMore];
        switch (indexPath.row) {
            case 0:
            {
                [self setCellwith:cell title:@"欲搬区域" withValue:self.publishViewModel.address andPlaceholderText:@"请输入小区地址或名称"];
            }
                break;
            case 1:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_TextField];
                [cell configWithPlaceholder:@"租金预算" valueStr:@"请输入小区地址或名称"];
                return cell;
            }
                break;
            case 2:
            {
                [self setCellwith:cell title:@"欲搬时间" withValue:self.publishViewModel.datetime andPlaceholderText:@"请选择欲搬时间"];
            }
                break;
            case 3:
            {
                [self setCellwith:cell title:@"星座" withValue:self.publishViewModel.constellation andPlaceholderText:@"请选择星座"];
            }
                break;
            case 4:
            {
                [self setCellwith:cell title:@"职业" withValue:self.publishViewModel.profession andPlaceholderText:@"请选择职业"];
            }
                break;
            default:
                break;
        }
        return cell;
    }else  if (indexPath.section == 1){
        MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
        [cell setUIwithModelArray:@[@"运动",@"看书",@"电影",@"运动",@"看书",@"电影"] andTagsName:@"添加自己的个性标签更容易找到对的人哦~" withTagStyle:MF_TagsViewTypeEdit];
        //个性标签更多按钮回调跳转
        cell.CellMoreBlock = ^(UIButton *sender) {
            MFTagsViewController *vc = [[MFTagsViewController alloc] init];
            vc.MFTagsViewType = MF_TagsViewType_AllTags;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else  if (indexPath.section == 2){
        MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
        [cell setUIwithModelArray:@[@"运动",@"看书",@"电影",@"运动",@"看书",@"电影"] andTagsName:@"为了找到对的人，添加上对合租说室友的小要求吧~" withTagStyle:MF_TagsViewTypeEdit];
        //合租说室友要求更多按钮回调跳转
        cell.CellMoreBlock = ^(UIButton *sender) {
            MFTagsViewController *vc = [[MFTagsViewController alloc] init];
            vc.MFTagsViewType = MF_TagsViewType_roommateRequires;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else if (indexPath.section == 3){
        MFRoommateTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_OnlyValue];
        [cell setTitleStr:@"补充要求" valueStr:@"我是一名律师，就是这么厉害"];
        return cell;
    }
    return [UITableViewCell new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0: return 60.0f; break;
        case 1:
        case 2: {
            MFRoommateTagsViewCell *cell = [[MFRoommateTagsViewCell alloc] init];
            CGFloat height = [cell getCellHeightWtihBtnsWithModelArray:@[@"运动",@"看书",@"电影",@"运动",@"看书",@"电影"]];
            return height;
        }
            break;
        case 3: {
            CGFloat height = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
            return height;
        }
            break;
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    weak(self);
    if (indexPath.section == 0) {
        
        MFRoommateTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0://选择位置跳转到地图
            {
                MainViewController *vc = [[MainViewController alloc] init];
                vc.locationSelectBlock = ^(CGFloat latitude, CGFloat longitude, NSArray *addresArr) {
                  NSLog(@"选择的经度--->%f\n,选择的纬度--->%f,选择的地址名称--->%@",latitude,longitude,addresArr);
                    if (addresArr.count>0) {
                      NSString *address = [NSString stringWithFormat:@"%@ %@",addresArr[2],addresArr[3]];
                      weakSelf.publishViewModel.publishModel.address = address;
                    [cell setTitleStr:@"欲搬区域" valueStr:address withValueColor:BLACKTEXTCOLOR];
                    }
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
                    NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
                    weakSelf.publishViewModel.publishModel.datetime = date;
                    [cell setTitleStr:@"欲搬时间" valueStr:date withValueColor:BLACKTEXTCOLOR];
                }];
                datepicker.doneButtonColor = GLOBALCOLOR;
                [datepicker show];
            }
                break;
            case 3:
            {
                [self.constellationPickerView showCityView:^(NSString *distr) {
                    NSString *str = [NSString string];
                    str = [NSString stringWithFormat:@"%@",[NSString iSBlankString:distr]?@"请选择星座":distr];
                    weakSelf.publishViewModel.publishModel.constellation = str;
                    [cell setTitleStr:@"星座" valueStr:distr withValueColor:BLACKTEXTCOLOR];
                }];
            }
                break;
            case 4:
            {
                MFMyProfessionViewController *vc = [[MFMyProfessionViewController alloc] init];
                vc.cellSelectBlock = ^(NSString *text) {
                    NSString *str;
                    str = [NSString stringWithFormat:@"%@",[NSString iSBlankString:text]?@"请选择职业":text];
                    weakSelf.publishViewModel.publishModel.profession = str;
                    [cell setTitleStr:@"职业" valueStr:str withValueColor:BLACKTEXTCOLOR];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

-(YWPickerView *)constellationPickerView{
    if (!_constellationPickerView) {
        MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
        NSMutableArray *array = [NSMutableArray array];
        [model.constellation enumerateObjectsUsingBlock:^(MFSymbolicBaseModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:obj.cn];
        }];
        _constellationPickerView = [[YWPickerView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds PickerViewType:FTT_PickerViewShowTypeAlert DataSoucre:array];
    }
    return _constellationPickerView;
}

-(void)setCellwith:(MFRoommateTableViewCell *)cell title:(NSString*)title withValue:(NSString*)value andPlaceholderText:(NSString*)placeholderText{
    
    if ([NSString iSBlankString:value]) {
        [cell setTitleStr:title valueStr:placeholderText withValueColor:LIGHTTEXTCOLOR];
    }else{
        [cell setTitleStr:title valueStr:value withValueColor:BLACKTEXTCOLOR];
    }
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
        
        _PublishRoomateTableView.delegate = self;
        _PublishRoomateTableView.dataSource = self;
        _PublishRoomateTableView.tableHeaderView = self.headerBackView;
        _PublishRoomateTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    }
    return _PublishRoomateTableView;
}


#pragma mark - lazy method

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
