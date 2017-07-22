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
@property (nonatomic, strong) UITableView *PublishRoomateTableView;

@property (nonatomic, strong) YWPickerView* constellationPickerView;
@property (nonatomic, strong) MFPublishViewModel* publishViewModel;

@property (strong, nonatomic) HXPhotoView *onePhotoView;
@property (strong, nonatomic) HXPhotoManager *manager;
@end

@implementation MFPublishRoomateViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"室友";
    self.isAutoBack = NO;
    self.rightStr_1 = @"发送";
    [self.view addSubview:self.PublishRoomateTableView];
    [self getExifInfowithImage:nil];
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
    // 1.打印图片名字
    [self printAssetsName:photos];
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

#pragma mark - 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        //NSLog(@"图片名字:%@",fileName);
    }
}



- (void)getExifInfowithImage:(UIImage*)image{
    
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"6011500630885_pic_hd" withExtension:@"jpg"];
    CGImageSourceRef imageSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    
    CFDictionaryRef imageInfo = CGImageSourceCopyPropertiesAtIndex(imageSource, 0,NULL);
    NSDictionary *exifDic = (__bridge NSDictionary *)CFDictionaryGetValue(imageInfo, kCGImagePropertyExifDictionary) ;
     NSLog(@"照片信息--->%@\n",imageInfo);
    
    
    
    image = [UIImage imageNamed:@"6011500630885_pic_hd.jpg"];
    
//    NSData *imageData = UIImageJPEGRepresentation(image, 1);
//    
//    CGImageSourceRef imageSource1 = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
//    
//    NSDictionary *imageInfo1 = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(imageSource1, 0, NULL);
//    
//    NSMutableDictionary *metaDataDic = [imageInfo1 mutableCopy];
//    NSMutableDictionary *exifDic1 =[[metaDataDic objectForKey:(NSString*)kCGImagePropertyExifDictionary]mutableCopy];
//    NSMutableDictionary *GPSDic1 =[[metaDataDic objectForKey:(NSString*)kCGImagePropertyGPSDictionary]mutableCopy];
//    NSLog(@"exif信息--->%@\n,定位信息信息--->%@\n",exifDic1,GPSDic1);
    
    
    //将UIimage转换为NSData
    NSData *imageData1=UIImageJPEGRepresentation(image, 1.0);
    //将NSData转换为CFDataRef并新建CGImageSourceRef对象
    CGImageSourceRef imageRef=CGImageSourceCreateWithData((CFDataRef)imageData1, NULL);
    NSDictionary*imageProperty=(NSDictionary*)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageRef,0, NULL));
    NSDictionary*ExifDictionary=[imageProperty valueForKey:(NSString*)kCGImagePropertyExifDictionary];
      NSLog(@"exif信息--->%@\n\n",ExifDictionary);
    
}



- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSLog(@"%@",NSStringFromCGRect(frame));
    self.headerBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height+60);
    [self.PublishRoomateTableView reloadData];
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
        _PublishRoomateTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
