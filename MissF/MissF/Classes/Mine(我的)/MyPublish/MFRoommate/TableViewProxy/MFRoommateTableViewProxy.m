//
//  MFRoommatetableViewProxy.m
//  MissF
//
//  Created by wyao on 2017/7/13.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFRoommateTableViewProxy.h"
#import "MFRoommateTableViewCell.h"
#import "MFRoommateTagsViewCell.h"


@implementation MFRoommateTableViewProxy

#pragma mark - tableview deleagte & datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger num = section == 0? 3: 1;
    return num;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.section == 0) {
        
        MFRoommateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TitleValue];
        
        switch (indexPath.row) {
            case 0:
            {
                [cell setTitleStr:@"欲搬区域" valueStr:@"打铁关"];
            }
                break;
            case 1:
            {
                [cell setTitleStr:@"租金预算" valueStr:@"¥ 2000/月"];
            }
                break;
            case 2:
            {
                [cell setTitleStr:@"欲搬时间" valueStr:@"2017/06/30"];
            }
                break;
            default:
                break;
        }
        return cell;
    }else  if (indexPath.section == 1 || indexPath.section == 2){
       MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
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
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.RoommateProxyScrollBlock) {
        self.RoommateProxyScrollBlock(scrollView);
    }
}


@end
