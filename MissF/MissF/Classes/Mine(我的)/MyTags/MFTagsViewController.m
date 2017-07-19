//
//  MFTagsViewController.m
//  MissF
//
//  Created by wyao on 2017/7/15.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFTagsViewController.h"
#import "GBTagListView.h"

@interface MFTagsViewController (){
    
    NSArray*strArray;//保存标签数据的数组
    GBTagListView*_tempTag;
    
}
/** 习惯*/
@property(strong,nonatomic)UIView *habitView;
/** 爱好*/
@property(strong,nonatomic)UIView *interest;
/** 个性*/
@property(strong,nonatomic)UIView *personality;
/** 室友要求*/
@property(strong,nonatomic)UIView *roommateRequires;
/** 家具设置*/
@property(strong,nonatomic)UIView *paymentType;
/** 保存按钮*/
@property(strong,nonatomic)UIButton *saveBtn;
/** 保存个性标签的二维数组*/
@property(strong,nonatomic)NSMutableArray *allTagsArray;
@end

@implementation MFTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.name = @"选择标签";
    
    switch (self.MFTagsViewType) {
        case 0:
            [self setMyAllTags];
            break;
        case 1:
            [self setOnlyTagsWithName:@"室友要求"];
            break;
        case 2:
            [self setOnlyTagsWithName:@"公共设施"];
            break;
            
        default:
            break;
    }
}

#pragma mark - 我的所有个性标签
-(void)setOnlyTagsWithName:(NSString*)nameText{
    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT-50);
    self.contentView.backgroundColor = WHITECOLOR;
    [self.view addSubview:self.saveBtn];
    
    
    if (_MFTagsViewType == 1) {
        [self setTagsViewWithBgView:self.roommateRequires withOrigin:CGPointMake(0, 0) withName:nameText andTagIdentifier:3];
        if (self.interest.frame.size.height > self.contentView.frame.size.height) {
            self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.roommateRequires.frame));
        }
    }else   if (_MFTagsViewType == 2) {
        [self setTagsViewWithBgView:self.paymentType withOrigin:CGPointMake(0, 0) withName:nameText andTagIdentifier:4];
        if (self.interest.frame.size.height > self.contentView.frame.size.height) {
            self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.paymentType.frame));
        }
    }
}

#pragma mark - 我的所有个性标签
-(void)setMyAllTags{
    
    self.allTagsArray = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    
    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT-50);
    [self setTagsViewWithBgView:self.interest withOrigin:CGPointMake(0, 0) withName:@"爱好" andTagIdentifier:0];
    [self setTagsViewWithBgView:self.habitView withOrigin:CGPointMake(0,CGRectGetMaxY(self.interest.frame)+10) withName:@"习惯" andTagIdentifier:1];
    [self setTagsViewWithBgView:self.personality withOrigin:CGPointMake(0,CGRectGetMaxY(self.habitView.frame)+10) withName:@"个性" andTagIdentifier:2];
    [self.view addSubview:self.saveBtn];
    self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.personality.frame));
}

-(UIView*)setTagsViewWithBgView:(UIView*)bgView withOrigin:(CGPoint)origin withName:(NSString*)nameText andTagIdentifier:(NSInteger)IdentifierTag{
    
    bgView.frame = CGRectMake(0, origin.y, SCREEN_WIDTH, 0);
    bgView.userInteractionEnabled = YES;
    bgView.tag = IdentifierTag;
    [self.contentView addSubview:bgView];
    
    
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    hView.backgroundColor = WHITECOLOR;
    [bgView addSubview:hView];
    
    
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(12, 15, 2, 14)];
    iconView.backgroundColor = GLOBALCOLOR;
    [hView addSubview:iconView];
    
    UILabel *nameLabe = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 100, 15)];
    nameLabe.text = nameText;
    nameLabe.font = FONT(15);
    nameLabe.textAlignment = NSTextAlignmentLeft;
    nameLabe.textColor = BLACKTEXTCOLOR;
    nameLabe.backgroundColor = WHITECOLOR;
    [hView addSubview:nameLabe];
    
    
    UILabel *tipsLabe = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxY(nameLabe.frame)+57, 15, 160, 15)];
    tipsLabe.text = @"最多选择三个标签哦~";
    tipsLabe.font = FONT(15);
    tipsLabe.textAlignment = NSTextAlignmentLeft;
    tipsLabe.textColor = GLOBALCOLOR;
    tipsLabe.backgroundColor = WHITECOLOR;
    tipsLabe.hidden = YES;
    [hView addSubview:tipsLabe];
    
    
    MFCommonModel *model = [[commonViewModel shareInstance] getCommonModelFromCache];
    
    switch (IdentifierTag) {
        case 0:
            strArray = [self getTagNameArrFromModelArray:model.tag.interest];
            break;
        case 1:
            strArray = [self getTagNameArrFromModelArray:model.tag.habit];
            break;
        case 2:
            strArray =  [self getTagNameArrFromModelArray:model.tag.personality];            break;
        case 3://室友要求
            strArray =  [self getTagNameArrFromModelArray:model.roommateRequires];            break;
        case 4://家居设施
            strArray =  [self getTagNameArrFromModelArray:model.paymentType];            break;
            
        default:
            break;
    }
    
    GBTagListView *tagList=[[GBTagListView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 0)];
    tagList.tag = IdentifierTag;
    /**允许点击 */
    tagList.canTouch=YES;
    /**可以控制允许点击的标签数 */
    tagList.canTouchNum=3;
    /**控制是否是单选模式 */
    tagList.isSingleSelect=NO;
    tagList.signalTagColor=[UIColor whiteColor];
    [bgView addSubview:tagList];
    
    [tagList setTagWithTagArray:strArray];
 
    weak(self);
    [tagList setDidselectItemBlock:^(NSArray *arr,NSInteger viewTag) {
        //NSLog(@"------>视图%zd的选中的标签%@",viewTag,arr);//存在循环引用
        if (arr.count>=3) {
            tipsLabe.hidden = NO;
        }else{
            tipsLabe.hidden = YES;
        }
        //判断是否是我的标签
        if (weakSelf.MFTagsViewType == 0 ) {
            [weakSelf.allTagsArray replaceObjectAtIndex:viewTag withObject:arr];
        }else{
            weakSelf.allTagsArray = arr.copy;
        }
    }];
    
    bgView.frame = CGRectMake(0, origin.y, SCREEN_WIDTH, tagList.size.height+60);
    
    return bgView;
}

#pragma mark - 回调
-(void)saveBtnClick:(UIButton*)sender{
    if (self.selectBlock) {
        self.selectBlock(self.allTagsArray);
    }
    weak(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    });
}

#pragma mark - private
-(NSArray*)getTagNameArrFromModelArray:(NSArray*)modelArr{
    NSMutableArray *tempArray = [NSMutableArray array];
    [modelArr enumerateObjectsUsingBlock:^(MFCommonBaseModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempArray addObject:obj.name];
    }];
    return tempArray.copy;
}

-(UIView *)habitView{
    if (!_habitView) {
        _habitView = [[UIView alloc] init];
        _habitView.backgroundColor = WHITECOLOR;
    }
    return _habitView;
}

-(UIView *)interest{
    if (!_interest) {
        _interest = [[UIView alloc] init];
        _interest.backgroundColor = WHITECOLOR;
    }
    return _interest;
}

-(UIView *)personality{
    if (!_personality) {
        _personality = [[UIView alloc] init];
        _personality.backgroundColor = WHITECOLOR;
    }
    return _personality;
}

-(UIView *)roommateRequires{
    if (!_roommateRequires) {
        _roommateRequires = [[UIView alloc] init];
        _roommateRequires.backgroundColor = WHITECOLOR;
    }
    return _roommateRequires;
}
-(UIView *)paymentType{
    if (!_paymentType) {
        _paymentType = [[UIView alloc] init];
        _paymentType.backgroundColor = WHITECOLOR;
    }
    return _paymentType;
}

-(UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-50-NaviBar_HEIGHT, SCREEN_WIDTH, 50)];
        [_saveBtn setTitle:@"保存标签" forState:UIControlStateNormal];
        _saveBtn.titleLabel.textColor = WHITECOLOR;
        _saveBtn.backgroundColor = GLOBALCOLOR;
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
