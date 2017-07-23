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
#import "HXPhotoView.h"



@interface MFPublishRoomateViewController ()<HXPhotoViewDelegate>
@property(strong,nonatomic) UIImageView* headerImageView;
@property(strong,nonatomic) UIImageView* avatarView;
@property(strong,nonatomic) UIView     * headerBackView;
@property(strong,nonatomic) UILabel    * nameLabel;
@property(strong,nonatomic) UITableView *PublishRoomateTableView;
@property(strong,nonatomic) UIView *tableFooterView;

@property (nonatomic, strong) YWPickerView* constellationPickerView;
@property (nonatomic, strong) MFPublishViewModel* publishViewModel;

@property (strong, nonatomic) HXPhotoView *onePhotoView;
@property (strong, nonatomic) HXPhotoManager *manager;

/** 个性标签数组*/
@property (strong, nonatomic) NSMutableArray<NSString*> *allTagsSelectedArray;
/** 个性标签数组( 保存选择的二维数组用于下次跳转的赋值)*/
@property (strong, nonatomic) NSArray     *allTagsSelected2Array;
@property (assign, nonatomic) MFCellTagsViewType allTagsType;
/** 室友要求数组*/
@property (strong, nonatomic) NSMutableArray *roommateRequiresSelectedArray;
/** 室友要求默认选中的数组*/
@property (strong, nonatomic) NSArray *roommateRequiresArray;
@property (assign, nonatomic) MFCellTagsViewType roommateRequiresType;
@end

@implementation MFPublishRoomateViewController

-(NSMutableArray *)allTagsSelectedArray{
    if (!_allTagsSelectedArray) {
        MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
        _allTagsSelectedArray = [NSMutableArray arrayWithCapacity:3];
        if (model.tag.interest.count>0) {
            for (int  i = 0; i<3; i++) {
                [_allTagsSelectedArray addObject:model.tag.interest[i].name];
            }
        }
    }
    return _allTagsSelectedArray;
}

-(NSMutableArray *)roommateRequiresSelectedArray{
    if (!_roommateRequiresSelectedArray) {
        MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
        _roommateRequiresSelectedArray = [NSMutableArray arrayWithCapacity:3];
        if (model.roommateRequires.count>0) {
            for (int  i = 0; i<3; i++) {
                [_roommateRequiresSelectedArray addObject:model.roommateRequires[i].name];
            }
        }
    }
    return _roommateRequiresSelectedArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"室友";
    self.isAutoBack = NO;
    self.rightStr_1 = @"发送";
    [self.view addSubview:self.PublishRoomateTableView];
    self.allTagsType = MF_TagsViewTypeEdit;
    self.roommateRequiresType = MF_TagsViewTypeEdit;
    self.allTagsSelected2Array = [NSArray array];
    self.roommateRequiresArray = [NSArray array];
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
    return 3;
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
    }else  if (indexPath.section == 1){//个性标签的处理逻辑
        MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
        [cell setUIwithModelArray:self.allTagsSelectedArray andTagsName:@"添加自己的个性标签更容易找到对的人哦~" withTagStyle:self.allTagsType];
        //个性标签更多按钮回调跳转
        weak(self);
        cell.CellMoreBlock = ^(UIButton *sender) {
            MFTagsViewController *vc = [[MFTagsViewController alloc] init];
            vc.MFTagsViewType = MF_TagsViewType_AllTags;
            //默认选中的标签 第一次为nil
            vc.selectArray = self.allTagsSelected2Array;
            vc.selectBlock = ^(NSArray *selectArray) {
                NSLog(@"------>个性标签%@",selectArray);
                if (selectArray.count > 0 ) {
                    //解析数组
                    NSMutableArray *tempArray = [NSMutableArray array];
                    [selectArray enumerateObjectsUsingBlock:^(id  _Nonnull  obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass:[NSArray class]]) {
                            NSArray *array = (NSArray*)obj;
                            if (array.count>0) {
                                [obj enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                    [tempArray addObject:obj];
                                }];
                            }
                        }else if ([obj isKindOfClass:[NSString class]]){//容错，防止回调传入的数组为空显示字符串
                            if (![NSString iSBlankString:obj]) {
                                [tempArray addObject:obj];
                            }
                        }
                    }];
                    if (tempArray.count > 0) {
                        //保存选择的标签二维数组
                        weakSelf.allTagsSelected2Array = selectArray;
                        weakSelf.allTagsType = MF_TagsViewTypeNormal;
                        [weakSelf.allTagsSelectedArray removeAllObjects];
                        [weakSelf.allTagsSelectedArray addObjectsFromArray:tempArray];
                    }
                }else{
                    //保存选择的标签二维数组
                    weakSelf.allTagsSelected2Array = selectArray;
                    weakSelf.allTagsType = MF_TagsViewTypeEdit;
                    self.allTagsSelectedArray = nil;
                }
                
              [weakSelf.PublishRoomateTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else  if (indexPath.section == 2){//室友要求标签的逻辑
        MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
        [cell setUIwithModelArray:self.roommateRequiresSelectedArray andTagsName:@"添加上对合租说室友的小要求吧~" withTagStyle:self.roommateRequiresType];
        //合租说室友要求更多按钮回调跳转
        cell.CellMoreBlock = ^(UIButton *sender) {
            MFTagsViewController *vc = [[MFTagsViewController alloc] init];
            vc.MFTagsViewType = MF_TagsViewType_roommateRequires;
            //默认选中的标签 第一次为nil
            vc.selectArray = self.roommateRequiresArray;
            vc.selectBlock = ^(NSArray *selectArray) {
                NSLog(@"------>室友要求的标签%@",selectArray);
                if (selectArray.count >0) {
                    weakSelf.roommateRequiresArray = selectArray;
                    [weakSelf.roommateRequiresSelectedArray removeAllObjects];
                    weakSelf.roommateRequiresType = MF_TagsViewTypeNormal;
                    [weakSelf.roommateRequiresSelectedArray addObjectsFromArray:selectArray];
                }
                [weakSelf.PublishRoomateTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
    return [UITableViewCell new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0: return 60.0f; break;
        case 1:{
            MFRoommateTagsViewCell *cell = [[MFRoommateTagsViewCell alloc] init];
            CGFloat height = [cell getCellHeightWtihBtnsWithModelArray:self.allTagsSelectedArray];
            return height;
        }
            break;
        case 2: {
            MFRoommateTagsViewCell *cell = [[MFRoommateTagsViewCell alloc] init];
            CGFloat height = [cell getCellHeightWtihBtnsWithModelArray:self.roommateRequiresSelectedArray];
            return height;
        }
            break;
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
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

#pragma mark - 照片默认图片点击事件
-(void)headerBackViewTapClick:(UITapGestureRecognizer*)tap{
    [self.onePhotoView goPhotoViewController];
}

#pragma mark - 相册选择代理方法
-(void)photoViewAllNetworkingPhotoDownloadComplete:(HXPhotoView *)photoView{
}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    
    NSLog(@"onePhotoView - %@",photos);
    if (photos.count>0) {
        self.headerImageView.hidden = YES;
        self.nameLabel.hidden = YES;
        self.onePhotoView.hidden = NO;
    }else{
        self.headerImageView.hidden = NO;
        self.nameLabel.hidden = NO;
        self.onePhotoView.hidden = YES;
    }
    // 2.图片位置信息
    if (iOS8Later) {
        for (HXPhotoModel *model in photos) {
            NSLog(@"---->坐标位置%@",model.asset.location);
        }
    }
    
    /*
    if (photos.count>0) {
        
        [SVProgressHUD showWithStatus:@"正在上传图片"];
        NSDictionary *parameter = @{@"file":@".png",
                                    @"type":@"roommate"};
        
        //上传图片
        [[MFNetAPIClient sharedInstance] uploadImageWithUrlString:kupload parameters:parameter ImageArray:photos  SuccessBlock:^(id responObject) {
            [SVProgressHUD showInfoWithStatus:responObject[@"message"]];
        } FailurBlock:^(NSInteger errCode, NSString *errorMsg) {
            [SVProgressHUD showInfoWithStatus:errorMsg];
        } UpLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
            
        }];
    }
     */

    
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSLog(@"%@",NSStringFromCGRect(frame));
    self.headerBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height+60);
    [self.PublishRoomateTableView reloadData];
}

#pragma mark - 设置cell的显示
-(void)setCellwith:(MFRoommateTableViewCell *)cell title:(NSString*)title withValue:(NSString*)value andPlaceholderText:(NSString*)placeholderText{
    
    if ([NSString iSBlankString:value]) {
        [cell setTitleStr:title valueStr:placeholderText withValueColor:LIGHTTEXTCOLOR];
    }else{
        [cell setTitleStr:title valueStr:value withValueColor:BLACKTEXTCOLOR];
    }
}


#pragma mark  - 懒加载
#pragma mark - lazy method

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
        _PublishRoomateTableView.tableFooterView = self.tableFooterView;
    }
    return _PublishRoomateTableView;
}


-(HXPhotoView *)onePhotoView{
    if (!_onePhotoView) {
        _onePhotoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(13, 14, SCREEN_WIDTH-26, 116) WithManager:self.manager];
        _onePhotoView.hidden= YES;//默认不显示
        _onePhotoView.delegate = self;
    }
    return _onePhotoView;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.openCamera = YES;
        _manager.outerCamera = YES;
        _manager.showFullScreenCamera = YES;
        _manager.photoMaxNum = 9;
        _manager.maxNum = 9;
    }
    return _manager;
}

-(UIView *)tableFooterView{
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 180)];
        _tableFooterView.backgroundColor = WHITECOLOR;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = BACKGROUNDCOLOR;
        [_tableFooterView addSubview:lineView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 50)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = @"室友要求";
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_tableFooterView addSubview:titleLabel];
        
        MFplaceholderTextView *textView = [[MFplaceholderTextView alloc]init];
        textView.placeholderLabel.font = [UIFont systemFontOfSize:15];
        textView.placeholder = @"请输入您需要补充的要求...";
        textView.font = [UIFont systemFontOfSize:15];
        textView.frame = CGRectMake(10, 60, SCREEN_WIDTH-20,100);
        textView.maxLength = 200;
        textView.layer.cornerRadius = 5.f;
        textView.layer.borderColor = [[UIColor grayColor]colorWithAlphaComponent:0.3].CGColor;
        textView.layer.borderWidth = 0.5f;
        [_tableFooterView addSubview:textView];
        
        weak(self);
        [textView didChangeText:^(MFplaceholderTextView *textView) {
            NSLog(@"%@",textView.text);
             weakSelf.publishViewModel.publishModel.address = textView.text;
        }];
        
    }
    return _tableFooterView;
}


-(UIView *)headerBackView{
    if (!_headerBackView) {
        _headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
        _headerBackView.backgroundColor = WHITECOLOR;
        [_headerBackView addSubview:self.headerImageView];
        [_headerBackView addSubview:self.nameLabel];
        [_headerBackView addSubview:self.onePhotoView];
    }
    return _headerBackView;
}

-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-147)*0.5, (175-76)*0.5, 147, 76)];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.image = IMAGE(@"icon_Release_house_nor");
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerBackViewTapClick:)];
        [_headerImageView addGestureRecognizer:tap];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
