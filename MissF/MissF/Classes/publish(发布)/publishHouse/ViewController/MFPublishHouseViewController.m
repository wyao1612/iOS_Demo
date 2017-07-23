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
@end

@implementation MFPublishHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"房源";
    self.isAutoBack = NO;
    self.rightStr_1 = @"发送";
    self.sectionNum = 3;
    [self.view addSubview:self.PublishTableView];
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
   
    
    MFRoommateTableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_TextField];
        [cell configWithPlaceholder:@"标题" valueStr:@"简单直接的标题会让房子更吸引"];
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
                [cell configWithPlaceholder:@"房间名" valueStr:@"请输入房间名"];
                return cell;
            }
                break;
            case 1:
            {
                [self setCellwith:cell title:@"房间类型" withValue:self.publishViewModel.datetime andPlaceholderText:@"请选择房间类型"];
                return cell;
            }
                break;
            case 2:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Input_OnlyText_TextField];
                [cell configWithPlaceholder:@"租金" valueStr:@"请输入欲租价格"];
                return cell;
            }
                break;
            case 3:
            {
                [self setCellwith:cell title:@"朝向" withValue:self.publishViewModel.constellation andPlaceholderText:@"请选择楼朝向"];
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
//    switch (indexPath.section) {
//        case 0:
//        case 1:return 60.0f; break;
//        case 2:return 60.0f; break;//需要计算得到高度
//            break;
//        default:
//            break;
//    }
//    if (indexPath.section == 0 || indexPath.section
//         == 1) {
//        return 60;
//    }
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
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115)];
        headerView.backgroundColor = BACKGROUNDCOLOR;
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
        return 115;
    }
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - action
-(void)addbtnClick{
    [SVProgressHUD showSuccessWithStatus:@"添加"];
    self.sectionNum +=1;
    [self.PublishTableView insertSections:[NSIndexSet indexSetWithIndex:self.sectionNum-1] withRowAnimation:UITableViewRowAnimationNone];
}



#pragma mark  - 懒加载
#pragma mark - lazy method

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
