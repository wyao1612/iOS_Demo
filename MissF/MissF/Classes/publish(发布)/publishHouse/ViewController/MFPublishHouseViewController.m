//
//  MFPublishHouseViewController.m
//  MissF
//
//  Created by wyao on 2017/7/23.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFPublishHouseViewController.h"
#import "MFRoommateTableViewCell.h"
#import "HXPhotoView.h"


@interface MFPublishHouseViewController ()
@property(nonatomic,assign)NSInteger sectionNum;
/** 相册管理类*/
@property(nonatomic,strong)NSMutableArray<HXPhotoManager*> *managerArray;
/** 相册视图高度数组*/
@property(nonatomic,strong)NSMutableArray<NSNumber*> *footviewHeightArray;
/** 当前房间最大的房间数*/
@property (nonatomic,assign) NSInteger   houseType;
/** 记录添加的房间数*/
@property (nonatomic,assign) NSInteger   houseNum;
/** 记录选择照片以后的高度变化*/
@property (nonatomic,assign) CGFloat     footerViewHeight;
/** 保存按钮*/
@property(strong,nonatomic)UIButton *nextBtn;

@end

@implementation MFPublishHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"房源";
    self.isAutoBack = NO;
    self.rightStr_1 = @"发送";
    self.footerViewHeight = 170;
    self.sectionNum = 3;
    self.houseType = 2;
    self.headerViewStyle = MFpublishHeaderViewTypeHouse;
    self.houseNum = self.houseType;
    //初始化数组
    [self creatDataArray];
    [self.view addSubview:self.PublishTableView];
    [self.view addSubview:self.nextBtn];
    self.PublishTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT-50);
    self.PublishTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
}

-(NSMutableArray<HXPhotoManager *> *)managerArray{
    if (!_managerArray) {
        _managerArray = [NSMutableArray array];
    }
    return _managerArray;
}

-(NSMutableArray *)footviewHeightArray{
    if (!_footviewHeightArray) {
        _footviewHeightArray = [NSMutableArray array];
    }
    return _footviewHeightArray;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionNum;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 4;
    }else if (section > 2 || section == 2){
        return 4;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    weak(self);
    MFRoommateTableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_TextField];
        [cell configWithTitle:@"标题" valueStr:self.publishViewModel.houseModel.title placeholderStr:@"简单直接的标题会让房子更吸引" isPriceTf:NO];
        cell.editDidEndBlock = ^(NSString *text) {
            weakSelf.publishViewModel.houseModel.title = text;
        };
        return cell;
    }else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleValueMore];
        switch (indexPath.row) {
            case 0:
            {
                [self setCellwith:cell title:@"是否是房东" withValue:self.publishViewModel.address andPlaceholderText:@"是或者否需要自定义"];
            }
                break;
            case 1:
            {
                [self setCellwith:cell title:@"小区" withValue:self.publishViewModel.datetime andPlaceholderText:@"请输入小区地址或名称"];
                return cell;
            }
                break;
            case 2:
            {
                [self setCellwith:cell title:@"付款方式" withValue:self.publishViewModel.datetime andPlaceholderText:@"请选择付款方式"];
            }
                break;
            case 3:
            {
                [self setCellwith:cell title:@"楼层" withValue:self.publishViewModel.constellation andPlaceholderText:@"请选择楼层/总楼层"];
            }
                break;
            case 4:
            {
                [self setCellwith:cell title:@"户型" withValue:self.publishViewModel.profession andPlaceholderText:@"请选择户型"];
            }
                break;
            default:
                break;
        }
        return cell;
    }else if (indexPath.section == 2 || indexPath.section>2){
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleValueMore];
        switch (indexPath.row) {
            case 0:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_TextField];
                [cell configWithTitle:@"" valueStr:@""  placeholderStr:@"" isPriceTf:YES];
                [cell configWithTitle:@"房间名" valueStr:[self.publishViewModel getHouseNameFromIndex:indexPath.section-2] placeholderStr:@"请输入房间名" isPriceTf:NO];
                cell.editDidEndBlock = ^(NSString *text) {
                    weakSelf.publishViewModel.houseRoomModelArray[indexPath.section-2].name = text;
                };
                return cell;
            }
                break;
            case 1:
            {
                [self setCellwith:cell title:@"房间类型" withValue:[self.publishViewModel getHouseRoomTypeFromIndex:indexPath.section-2] andPlaceholderText:@"请选择房间类型"];
            }
                break;
            case 2:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_TextField];
                [cell configWithTitle:@"租金" valueStr:[self.publishViewModel getHousePriceFromIndex:indexPath.section-2]  placeholderStr:@"请输入欲租价格" isPriceTf:YES];
                cell.editDidEndBlock = ^(NSString *text) {
                    weakSelf.publishViewModel.houseRoomModelArray[indexPath.section-2].price = text;
                };
                return cell;
            }
                break;
            case 3:
            {
                [self setCellwith:cell title:@"朝向" withValue:[self.publishViewModel getHouseOrientateFromIndex:indexPath.section-2] andPlaceholderText:@"请选择楼朝向"];
            }
                break;
            default:
                break;
        }
        return cell;
    }
    
    return [UITableViewCell new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        headerView.backgroundColor = WHITECOLOR;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
        lineView.backgroundColor = BACKGROUNDCOLOR;
        [headerView addSubview:lineView];
        
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 70)*0.5, 20, 80, 16)];
        label.text = @"· 房间编辑 ·";
        label.font = FONT(15);
        label.textColor = BLACKTEXTCOLOR;
        label.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:label];
        
        UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50, 23, 35, 16)];
        [addBtn setTitle:@"添加" forState:UIControlStateNormal];
        [addBtn setTitleColor:BLACKTEXTCOLOR forState:UIControlStateNormal];
        addBtn.backgroundColor = WHITECOLOR;
        addBtn.titleLabel.font = FONT(15);
        [addBtn addTarget:self action:@selector(addbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:addBtn];
        return headerView;
    }else{
        return [UIView new];
    }
    return [UIView new];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    if (section > 2 || section == 2) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 170)];
        headerView.backgroundColor = WHITECOLOR;

        HXPhotoManager *manager = [self.managerArray objectAtIndex:section-2];
        
        HXPhotoView *photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(25, 15, SCREEN_WIDTH-50, 115) WithManager:manager];
        photoView.delegate = self;
        photoView.backgroundColor = WHITECOLOR;
        //记录那个房间上传了照片
        photoView.tag = section;
        [headerView addSubview:photoView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(photoView.frame)+12, 140, 16)];
        label.text = @"上传该房间的照片";
        label.font = FONT(15);
        label.textColor = LIGHTTEXTCOLOR;
        label.backgroundColor = [UIColor whiteColor];
        [headerView addSubview:label];
        
        return headerView;
    }
    return [UIView new];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 65;
    }else{
        return 5;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section > 2 || section == 2 ) {
        CGFloat height = self.footviewHeightArray[section - 2].floatValue;
        return height;
    }
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    weak(self);
    if (indexPath.section == 2 || indexPath.section > 2 ) {
        
        MFRoommateTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 1:
            {
                YWPickerView *orientatePickerView = [[YWPickerView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds PickerViewType:FTT_PickerViewShowTypeAlert DataSoucre:[NSMutableArray arrayWithArray:@[@"主卧",@"次卧",@"其他"]]];
                [orientatePickerView showCityView:^(NSString *distr) {
                    NSString *str = [NSString string];
                    str = [NSString stringWithFormat:@"%@",[NSString iSBlankString:distr]?@"请选择房屋类型":distr];
                    weakSelf.publishViewModel.houseRoomModelArray[indexPath.section-2].roomType = str;
                    [cell setTitleStr:@"房屋类型" valueStr:distr withValueColor:BLACKTEXTCOLOR];
                }];
            }
                break;
            case 3:
            {
                YWPickerView *orientatePickerView = [[YWPickerView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds PickerViewType:FTT_PickerViewShowTypeAlert DataSoucre:[NSMutableArray arrayWithArray:@[@"朝南",@"朝北",@"其他"]]];
                [orientatePickerView showCityView:^(NSString *distr) {
                    NSString *str = [NSString string];
                    str = [NSString stringWithFormat:@"%@",[NSString iSBlankString:distr]?@"请选择朝向":distr];
                weakSelf.publishViewModel.houseRoomModelArray[indexPath.section-2].orientate = str;
                [cell setTitleStr:@"朝向" valueStr:distr withValueColor:BLACKTEXTCOLOR];
                }];
            }
                break;
            default:
                break;
        }
    }
}


#pragma mark - action
-(void)addbtnClick{
    [SVProgressHUD showSuccessWithStatus:@"添加成功"];
    if (self.houseNum > self.houseType) {
        [SVProgressHUD showSuccessWithStatus:@"已经超过房间数不可添加"];
        return;
    }else{
        [self creatDataArray];
    }
    self.sectionNum +=1;//用于更新数据源
    self.houseNum +=1;//房间数记录
    [self.PublishTableView insertSections:[NSIndexSet indexSetWithIndex:self.sectionNum-1] withRowAnimation:UITableViewRowAnimationNone];
    
    // 滚动到制定位置
    //NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:self.sectionNum];
    //[self.tableView setContentOffset:CGPointMake(0.0, (self.lastSelectRow ) *44.0) animated:YES];
}

#pragma mark - 回调
-(void)nextBtnClick:(UIButton*)sender{
    [SVProgressHUD showSuccessWithStatus:@"下一步"];
    NSLog(@"%@",self.publishViewModel.houseRoomModelArray);
    NSLog(@"图片数组%@,地址数组%@",self.publishViewModel.allPhotoArray,self.publishViewModel.allUrlArray);
}


#pragma mark - 相册选择代理方法
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSLog(@"PhotoView - %@",photoView);
    NSLog(@"photos - %@",photos);
    //头部相册的选择判断
    [self setOnePhotoViewWith:photoView andPhotos:photos];
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    if (photoView == self.onePhotoView) {
        self.headerBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height+60);
        [self.PublishTableView reloadData];
    }else{
        CGFloat height = 0.0f;
        //[SVProgressHUD showSuccessWithStatus:@"更新约束"];
        if (frame.size.height > 170.0f) {
           height = frame.size.height + 55;
        }else{
           height = 170.0f;
        }
        [self.footviewHeightArray replaceObjectAtIndex:photoView.tag-2 withObject:@(height)];
        [self.PublishTableView reloadSections:[NSIndexSet indexSetWithIndex:photoView.tag] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - 默认存储数组初始化
/** 默认照片管理类有一个 高度缓存也是一个 相册数组也是只有一个*/
-(void)creatDataArray{
    
    HXPhotoManager *manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
    manager.openCamera = YES;
    manager.outerCamera = YES;
    manager.showFullScreenCamera = YES;
    manager.photoMaxNum = 9;
    manager.maxNum = 9;
    //添加管理类数组
    [self.managerArray addObject:manager];
    //高度缓存，默认是170的高度，在高度仿回的代理方法中调用
    [self.footviewHeightArray addObject:@(170.0f)];
    
    //VM存放房间的数组默认也是有一个模型
    houseRoomModel *model = [[houseRoomModel alloc] init];
    [self.publishViewModel.houseRoomModelArray addObject:model];
    
    //二维数组记录有多少个选择器（父类初始化一个头部，子类初始化调用添加一个，点击添加的时候再增加）
    [self.publishViewModel.allPhotoArray addObject:[NSMutableArray arrayWithCapacity:9]];
    
    //二维数组记录每个选择器上传成功后的照片
    [self.publishViewModel.allUrlArray addObject:[NSMutableArray arrayWithCapacity:9]];

}

#pragma mark  - 懒加载
#pragma mark - lazy method
-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-NaviBar_HEIGHT, SCREEN_WIDTH, 50)];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        _nextBtn.titleLabel.textColor = WHITECOLOR;
        _nextBtn.backgroundColor = GLOBALCOLOR;
        [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
