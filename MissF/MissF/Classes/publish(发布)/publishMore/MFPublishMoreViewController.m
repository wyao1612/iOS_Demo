//
//  MFPublishMoreViewController.m
//  MissF
//
//  Created by wyao on 2017/7/25.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFPublishMoreViewController.h"
#import "MFTagsViewController.h"
#import "MFRoommateTagsViewCell.h"
#import "MFPublishViewModel.h"

@interface MFPublishMoreViewController ()
@property(strong,nonatomic) UILabel             * nameLabel;
@property(strong,nonatomic) UIView              * tableFooterView;
@property(strong,nonatomic) UITableView         *PublishTableView;
@property(strong,nonatomic) NSString            *markString;
@property(strong,nonatomic) MFPublishViewModel  *publishViewModel;
@property(assign,nonatomic) MFCellTagsViewType  facilitiesType;
@property(assign,nonatomic) MFCellTagsViewType  roommateRequiresType;
/** 室友要求默认选中的数组*/
@property (strong, nonatomic) NSArray *roommateRequiresArray;
/** 公共设施默认选中的数组*/
@property (strong, nonatomic) NSArray *facilitiesArray;
/** 保存按钮*/
@property(strong,nonatomic)UIButton *nextBtn;
@end

@implementation MFPublishMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"完善编辑";
    [self.view addSubview:self.PublishTableView];
    [self.view addSubview:self.nextBtn];
    self.PublishTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT-50);
    self.facilitiesType = MF_TagsViewTypeEdit;
    self.roommateRequiresType = MF_TagsViewTypeEdit;
    self.roommateRequiresArray = [NSArray array];
    self.facilitiesArray = [NSArray array];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    weak(self);
    MFRoommateTagsViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_TagsViewCell];
    if (indexPath.section == 0){//公共设施
        [cell setUIwithModelArray:self.publishViewModel.facilitiesSelectedArray andTagsName:@"添加标签丰富公共设施信息，更加快速找到室友" withTagStyle:self.facilitiesType];
        //合租说室友要求更多按钮回调跳转
        cell.CellMoreBlock = ^(UIButton *sender) {
            MFTagsViewController *vc = [[MFTagsViewController alloc] init];
            vc.MFTagsViewType = MF_TagsViewType_paymentType;
            //默认选中的标签 第一次为nil
            vc.selectArray = weakSelf.facilitiesArray;
            vc.selectBlock = ^(NSArray *selectArray) {
                NSLog(@"------>公共设施的标签%@",selectArray);
                if (selectArray.count >0) {
                    weakSelf.facilitiesArray = selectArray;
                    [weakSelf.publishViewModel.facilitiesSelectedArray removeAllObjects];
                    weakSelf.facilitiesType = MF_TagsViewTypeNormal;
                    [weakSelf.publishViewModel.facilitiesSelectedArray addObjectsFromArray:selectArray];
                }else{
                    //保存选择的标签一维数组
                    weakSelf.facilitiesArray = selectArray;
                    weakSelf.facilitiesType = MF_TagsViewTypeEdit;
                    weakSelf.publishViewModel.facilitiesSelectedArray = nil;
                }
                [weakSelf.PublishTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
        
    }else  if (indexPath.section == 1){//室友要求标签的逻辑
        
        [cell setUIwithModelArray:self.publishViewModel.roommateRequiresSelectedArray andTagsName:@"为了找到对的人，添加上对合租说室友的小要求吧~" withTagStyle:self.roommateRequiresType];
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
        case 0:{
            MFRoommateTagsViewCell *cell = [[MFRoommateTagsViewCell alloc] init];
            CGFloat height = [cell getCellHeightWtihBtnsWithModelArray:self.publishViewModel.facilitiesSelectedArray];
            return height;
        }
            break;
        case 1: {
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




-(MFPublishViewModel *)publishViewModel{
    if (!_publishViewModel) {
        _publishViewModel = [[MFPublishViewModel alloc] init];
    }
    return _publishViewModel;
}


- (UITableView *)PublishTableView {
    if (_PublishTableView == nil){
        _PublishTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _PublishTableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT);
        _PublishTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _PublishTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _PublishTableView.separatorColor = GRAYCOLOR;
        _PublishTableView.backgroundColor = BACKGROUNDCOLOR;
        _PublishTableView.showsVerticalScrollIndicator = NO;

        [_PublishTableView registerClass:[MFRoommateTagsViewCell class] forCellReuseIdentifier:kCellIdentifier_TagsViewCell];
        
        _PublishTableView.delegate = self;
        _PublishTableView.dataSource = self;
        _PublishTableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _PublishTableView.tableFooterView = self.tableFooterView;
    }
    return _PublishTableView;
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
        titleLabel.text = @"补充说明";
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
            weakSelf.markString = textView.text;
        }];
        
    }
    return _tableFooterView;
}


-(void)publishClick:(UIButton*)sender{
    [SVProgressHUD showSuccessWithStatus:@"发布要求"];
}

#pragma mark  - 懒加载
#pragma mark - lazy method
-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-NaviBar_HEIGHT, SCREEN_WIDTH, 50)];
        [_nextBtn setTitle:@"发布" forState:UIControlStateNormal];
        _nextBtn.titleLabel.textColor = WHITECOLOR;
        _nextBtn.backgroundColor = GLOBALCOLOR;
        [_nextBtn addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
