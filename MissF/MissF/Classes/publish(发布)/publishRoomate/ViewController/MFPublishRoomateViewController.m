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
#import "MFRoommateTagsViewCell.h"
#import "MFMyProfessionViewController.h"


@interface MFPublishRoomateViewController ()
@property (nonatomic, strong) YWPickerView* constellationPickerView;
/** 个性标签数组( 保存选择的二维数组用于下次跳转的赋值)*/
@property (strong, nonatomic) NSArray     *allTagsSelected2Array;
@property (assign, nonatomic) MFCellTagsViewType allTagsType;
/** 室友要求默认选中的数组*/
@property (strong, nonatomic) NSArray *roommateRequiresArray;
@property (assign, nonatomic) MFCellTagsViewType roommateRequiresType;
@end

@implementation MFPublishRoomateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"室友";
    self.isAutoBack = NO;
    self.rightStr_1 = @"发送";
    self.headerViewStyle = MFpublishHeaderViewTypeRoomate;
    [self.view addSubview:self.PublishTableView];
    self.allTagsType = MF_TagsViewTypeEdit;
    self.roommateRequiresType = MF_TagsViewTypeEdit;
    self.allTagsSelected2Array = [NSArray array];
    self.roommateRequiresArray = [NSArray array];
}
-(void)right_1_action{
    [SVProgressHUD showSuccessWithStatus:@"发送"];
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
                weak(self);
                cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_TextField];
                [cell configWithTitle:@"租金预算" valueStr:self.publishViewModel.roomateModel.money placeholderStr:@"请输入租金预算金额" isPriceTf:NO];
                cell.editDidEndBlock = ^(NSString *text) {
                    weakSelf.publishViewModel.roomateModel.money = text;
                };
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
        [cell setUIwithModelArray:self.publishViewModel.allTagsSelectedArray andTagsName:@"添加自己的个性标签更容易找到对的人哦~" withTagStyle:self.allTagsType];
        //个性标签更多按钮回调跳转
        weak(self);
        cell.CellMoreBlock = ^(UIButton *sender) {
            MFTagsViewController *vc = [[MFTagsViewController alloc] init];
            vc.MFTagsViewType = MF_TagsViewType_AllTags;
            //默认选中的标签 第一次为nil
            vc.selectArray = weakSelf.allTagsSelected2Array;
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
                        [weakSelf.publishViewModel.allTagsSelectedArray removeAllObjects];
                        [weakSelf.publishViewModel.allTagsSelectedArray addObjectsFromArray:tempArray];
                    }else{
                        //保存选择的标签二维数组
                        weakSelf.allTagsSelected2Array = selectArray;
                        weakSelf.allTagsType = MF_TagsViewTypeEdit;
                        weakSelf.publishViewModel.allTagsSelectedArray = nil;
                    }
                }
                
              [weakSelf.PublishTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }else  if (indexPath.section == 2){//室友要求标签的逻辑
        weak(self);
        MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
        [cell setUIwithModelArray:self.publishViewModel.roommateRequiresSelectedArray andTagsName:@"添加上对合租说室友的小要求吧~" withTagStyle:self.roommateRequiresType];
        //合租说室友要求更多按钮回调跳转
        cell.CellMoreBlock = ^(UIButton *sender) {
            MFTagsViewController *vc = [[MFTagsViewController alloc] init];
            vc.MFTagsViewType = MF_TagsViewType_roommateRequires;
            //默认选中的标签 第一次为nil
            vc.selectArray = weakSelf.roommateRequiresArray;
            vc.selectBlock = ^(NSArray *selectArray) {
                NSLog(@"------>室友要求的标签%@",selectArray);
                if (selectArray.count >0) {
                    weakSelf.roommateRequiresArray = selectArray;
                    [weakSelf.publishViewModel.roommateRequiresSelectedArray removeAllObjects];
                    weakSelf.roommateRequiresType = MF_TagsViewTypeNormal;
                    [weakSelf.publishViewModel.roommateRequiresSelectedArray addObjectsFromArray:selectArray];
                }else{
                    //保存选择的标签一维数组
                    weakSelf.roommateRequiresArray = selectArray;
                    weakSelf.roommateRequiresType = MF_TagsViewTypeEdit;
                    weakSelf.publishViewModel.roommateRequiresSelectedArray = nil;
                }
                [weakSelf.PublishTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
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
            CGFloat height = [cell getCellHeightWtihBtnsWithModelArray:self.publishViewModel.allTagsSelectedArray];
            return height;
        }
            break;
        case 2: {
            MFRoommateTagsViewCell *cell = [[MFRoommateTagsViewCell alloc] init];
            CGFloat height = [cell getCellHeightWtihBtnsWithModelArray:self.publishViewModel.roommateRequiresSelectedArray];
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
                      weakSelf.publishViewModel.roomateModel.address = address;
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
                    weakSelf.publishViewModel.roomateModel.datetime = date;
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
                    weakSelf.publishViewModel.roomateModel.constellation = str;
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
                    weakSelf.publishViewModel.roomateModel.profession = str;
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

#pragma mark  - 懒加载
#pragma mark - lazy method
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
