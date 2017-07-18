//
//  MFPublishRoommateTableViewProxy.m
//  MissF
//
//  Created by wyao on 2017/7/17.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFPublishRoommateTableViewProxy.h"
#import "MFRoommateTableViewCell.h"
#import "MFRoommateTagsViewCell.h"
#import "DLPickerView.h"

@interface MFPublishRoommateTableViewProxy ()
@property (nonatomic, strong) YWPickerView* constellationPickerView;
@property (nonatomic, strong) YWPickerView* professionPickerView;
@end


@implementation MFPublishRoommateTableViewProxy
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
    if (indexPath.section == 0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleValueMore];
        
        switch (indexPath.row) {
            case 0:
            {
                [cell setTitleStr:@"欲搬区域" valueStr:@"请输入小区地址或名称" withValueColor:LIGHTTEXTCOLOR];
            }
                break;
            case 1:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_TextField];
                [cell configWithPlaceholder:@"租金预算" valueStr:@"请输入预算金额"];
                return cell;
            }
                break;
            case 2:
            {
                [cell setTitleStr:@"欲搬时间" valueStr:@"请选择欲搬时间" withValueColor:LIGHTTEXTCOLOR];
            }
                break;
            case 3:
            {
                [cell setTitleStr:@"星座" valueStr:@"请选择星座" withValueColor:LIGHTTEXTCOLOR];
            }
                break;
            case 4:
            {
                [cell setTitleStr:@"职业" valueStr:@"请选择职业" withValueColor:LIGHTTEXTCOLOR];
            }
                break;
            default:
                break;
        }
        return cell;
    }else  if (indexPath.section == 1){
        MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
        MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
        [cell setUIwithModelArray:model.tag.interest andTagsName:@"我的标签"];
        return cell;
    }else  if (indexPath.section == 2){
        MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
        MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
        [cell setUIwithModelArray:model.tag.interest andTagsName:@"室友要求"];
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
            MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
            CGFloat height = [cell getCellHeightWtihBtnsWithModelArray:model.tag.interest];
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
    
    if (indexPath.section == 0) {

        MFRoommateTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0:
            {
                [SVProgressHUD showSuccessWithStatus:@(indexPath.row).description];
            }
                break;
            case 2:
            {
                WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
                    NSString *date = [startDate stringWithFormat:@"yyyy/MM/dd"];
                    //NSLog(@"时间： %@",date);
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
                     [cell setTitleStr:@"星座" valueStr:distr withValueColor:BLACKTEXTCOLOR];
                }];
            }
                break;
            case 4:
            {
                [self.professionPickerView showCityView:^(NSString *distr) {
                    NSString *str = [NSString string];
                    str = [NSString stringWithFormat:@"%@",[NSString iSBlankString:distr]?@"请选择职业":distr];
                    [cell setTitleStr:@"职业" valueStr:distr withValueColor:BLACKTEXTCOLOR];
                }];
//                DLPickerView *pickerView = [[DLPickerView alloc] initWithDataSource:@[@"Man",@"Woman"] withSelectedItem:cell.valueLabel.text withSelectedBlock:^(id selectedItem) {
//                     [cell setTitleStr:@"职业" valueStr:selectedItem withValueColor:BLACKTEXTCOLOR];
//                }];
                
//                [pickerView show];
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
-(YWPickerView *)professionPickerView{
    if (!_professionPickerView) {
        MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
        NSMutableArray *array = [NSMutableArray array];
        [model.profession enumerateObjectsUsingBlock:^(MFProfessionModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:obj.parent];
        }];
        _professionPickerView = [[YWPickerView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds PickerViewType:FTT_PickerViewShowTypeAlert DataSoucre:array];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"firstNumSelect" object:nil];
    }
    return _professionPickerView;
}


@end
