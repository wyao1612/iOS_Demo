//
//  MFHouseTableViewProxy.m
//  MissF
//
//  Created by wyao on 2017/7/12.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFHouseTableViewProxy.h"
#import "MFHouseListCell.h"
#import "MFHouseViewModel.h"

@implementation MFHouseTableViewProxy


#pragma mark - Table view data source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MFHouseListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MFHouseListCell"];
    weak(self);
    if (self.dataArray.count > indexPath.row) {
        MFHouseListModel *listModel = self.dataArray[indexPath.row];
        if (weakSelf.isExpend) {
            [cell configureShopcartCellWithModel:listModel productSelected:false isExpand:YES];
        }else{
            [cell configureShopcartCellWithModel:listModel productSelected:false isExpand:NO];
        }
    }
    

    //重新发布和删除的回调
    cell.listCellBlock = ^(UIButton *sender) {
        if (sender.tag == 101) {//删除
            if (weakSelf.HouseProxyDeleteBlock) {
                weakSelf.HouseProxyDeleteBlock(indexPath);
            }
            
        }else if(sender.tag == 102){//重新发布
            if (weakSelf.HouseProxyPublishBlock) {
                weakSelf.HouseProxyPublishBlock(sender,indexPath);
            }
        }
    };
    
    //自定义选中按钮的回调
    cell.ListCellSelectBlock = ^(BOOL isSelected) {
        if (weakSelf.HouseProxySelectBlock) {
            weakSelf.HouseProxySelectBlock(isSelected, indexPath);
        }
    };
    
    
    cell.selectedBackgroundView = [[UIView alloc]init];
    return cell;
}

/*
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
 */



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //选中cell
    MFHouseListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //系统选中按钮的回调
    __weak __typeof(self) weakSelf = self;
    cell.ListCellSelectBlock = ^(BOOL isSelected) {
        if (weakSelf.HouseProxySelectBlock) {
            weakSelf.HouseProxySelectBlock(isSelected, indexPath);
        }
    };
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MFHouseListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //系统选中按钮的回调
    __weak __typeof(self) weakSelf = self;
    cell.ListCellSelectBlock = ^(BOOL isSelected) {
        if (weakSelf.HouseProxySelectBlock) {
            weakSelf.HouseProxySelectBlock(isSelected, indexPath);
        }
    };
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    return height;
}

#pragma mark UITableViewDelegate
/*
 
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
 */


/** 左滑删除*/
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //删除的回调
        if (self.HouseProxyDeleteBlock) {
            self.HouseProxyDeleteBlock(indexPath);
        }
    }];
    return @[deleteAction];
}

@end
