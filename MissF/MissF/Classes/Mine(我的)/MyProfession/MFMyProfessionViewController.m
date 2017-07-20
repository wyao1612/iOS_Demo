//
//  MFMyProfessionViewController.m
//  MissF
//
//  Created by wyao on 2017/7/17.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFMyProfessionViewController.h"
#import "MFProfessionViewCell.h"

@interface MFMyProfessionViewController ()

@end

@implementation MFMyProfessionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"职业选择";
    self.isAutoBack = NO;
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT);
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = GRAYCOLOR;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 0);
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    [self.tableView registerClass:[MFProfessionViewCell class] forCellReuseIdentifier:@"MFProfessionViewCell"];
    
    MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
    self.dataList = model.profession;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MFProfessionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MFProfessionViewCell"];
    cell.model = self.dataList[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MFProfessionViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MFProfessionModel *model = self.dataList[indexPath.row];
    cell.titleBtn.backgroundColor  = [UIColor getColor:model.color];
    weak(self);
    if (self.cellSelectBlock) {
        self.cellSelectBlock(model.name);
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
