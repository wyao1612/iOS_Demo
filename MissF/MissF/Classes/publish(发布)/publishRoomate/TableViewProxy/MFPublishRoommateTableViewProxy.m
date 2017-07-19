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
#import "MFPublishViewModel.h"

@interface MFPublishRoommateTableViewProxy ()
@property (nonatomic, strong) YWPickerView* constellationPickerView;
@property (nonatomic, strong) YWPickerView* professionPickerView;
@property (nonatomic, strong) MFPublishViewModel* publishViewModel;
@end


@implementation MFPublishRoommateTableViewProxy

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
        //更多按钮回调跳转
        cell.CellMoreBlock = ^(UIButton *sender) {
            if (weakSelf.PublishRoommateProxySelectBlock) {
                weakSelf.PublishRoommateProxySelectBlock(sender, indexPath);
            }
        };
        return cell;
    }else  if (indexPath.section == 2){
        MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
        [cell setUIwithModelArray:@[@"运动",@"看书",@"电影",@"运动",@"看书",@"电影"] andTagsName:@"为了找到对的人，添加上对合租说室友的小要求吧~" withTagStyle:MF_TagsViewTypeEdit];
        //更多按钮回调跳转
        cell.CellMoreBlock = ^(UIButton *sender) {
            if (weakSelf.PublishRoommateProxySelectBlock) {
                weakSelf.PublishRoommateProxySelectBlock(sender, indexPath);
            }
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
    
    if (indexPath.section == 0) {

        MFRoommateTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0://选择位置跳转到地图
            {
                if (self.PublishRoommateProxySelectBlock) {
                    self.PublishRoommateProxySelectBlock(nil, indexPath);
                }
            }
                break;
            case 2:
            {
                WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *startDate) {
                    NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd"];
                    self.publishViewModel.publishModel.datetime = date;
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
                    self.publishViewModel.publishModel.constellation = str;
                     [cell setTitleStr:@"星座" valueStr:distr withValueColor:BLACKTEXTCOLOR];
                }];
            }
                break;
            case 4:
            {
                [self.professionPickerView showCityView:^(NSString *distr) {
                    NSString *str = [NSString string];
                    str = [NSString stringWithFormat:@"%@",[NSString iSBlankString:distr]?@"请选择职业":distr];
                    self.publishViewModel.publishModel.profession = str;
                    [cell setTitleStr:@"职业" valueStr:str withValueColor:BLACKTEXTCOLOR];
                }];
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

-(void)setCellwith:(MFRoommateTableViewCell *)cell title:(NSString*)title withValue:(NSString*)value andPlaceholderText:(NSString*)placeholderText{
    
    if ([NSString iSBlankString:value]) {
        [cell setTitleStr:title valueStr:placeholderText withValueColor:LIGHTTEXTCOLOR];
    }else{
        [cell setTitleStr:title valueStr:value withValueColor:BLACKTEXTCOLOR];
    }
}


@end
