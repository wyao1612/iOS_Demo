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
/** 保存个人标签的二维数组*/
@property(strong,nonatomic)NSMutableArray *allTagsArray;
/** 保存兴趣标签数组*/
@property(strong,nonatomic)NSMutableArray *interestArray;
/** 保存习惯标签数组*/
@property(strong,nonatomic)NSMutableArray *habitArray;
/** 保存个性标签的数组*/
@property(strong,nonatomic)NSMutableArray *personalArray;
@end

@implementation MFTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.name = @"选择标签";
    
    self.interestArray = [NSMutableArray array];
    self.habitArray = [NSMutableArray array];
    self.personalArray = [NSMutableArray array];
    
    switch (self.MFTagsViewType) {
        case 0:
            [self setMyAllTagsWithArray:self.selectArray];
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
        [self setTagsViewWithBgView:self.roommateRequires withOrigin:CGPointMake(0, 0) withName:nameText andTagIdentifier:3 defaultSelectedArray:@[]];
        if (self.interest.frame.size.height > self.contentView.frame.size.height) {
            self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.roommateRequires.frame));
        }
    }else   if (_MFTagsViewType == 2) {
        [self setTagsViewWithBgView:self.paymentType withOrigin:CGPointMake(0, 0) withName:nameText andTagIdentifier:4 defaultSelectedArray:@[]];
        if (self.interest.frame.size.height > self.contentView.frame.size.height) {
            self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.paymentType.frame));
        }
    }
}

#pragma mark - 我的所有个性标签
-(void)setMyAllTagsWithArray:(NSArray *)selectArray{
    
    self.allTagsArray = [NSMutableArray arrayWithObjects:self.interestArray,self.habitArray,self.personalArray, nil];
    
    weak(self);
    [selectArray enumerateObjectsUsingBlock:^(NSArray *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0:
                weakSelf.interestArray = [NSMutableArray arrayWithArray:selectArray[0]];
                break;
            case 1:
                weakSelf.habitArray = [NSMutableArray arrayWithArray:selectArray[1]];
                break;
            case 2:
                weakSelf.personalArray = [NSMutableArray arrayWithArray:selectArray[2]];
                break;
            default:
                break;
        }
    }];
    

    
    self.contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_HEIGHT-50);
    [self setTagsViewWithBgView:self.interest withOrigin:CGPointMake(0, 0) withName:@"爱好" andTagIdentifier:0 defaultSelectedArray:self.interestArray];
    [self setTagsViewWithBgView:self.habitView withOrigin:CGPointMake(0,CGRectGetMaxY(self.interest.frame)+10) withName:@"习惯" andTagIdentifier:1 defaultSelectedArray:self.habitArray];
    [self setTagsViewWithBgView:self.personality withOrigin:CGPointMake(0,CGRectGetMaxY(self.habitView.frame)+10) withName:@"个性" andTagIdentifier:2 defaultSelectedArray:self.personalArray];
    [self.view addSubview:self.saveBtn];
    self.contentView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.personality.frame));
}

-(UIView*)setTagsViewWithBgView:(UIView*)bgView withOrigin:(CGPoint)origin withName:(NSString*)nameText andTagIdentifier:(NSInteger)IdentifierTag defaultSelectedArray:(NSArray*)selectArray{
    
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
            strArray =  [self getTagNameArrFromModelArray:model.tag.personality];
            break;
        case 3://室友要求
            strArray =  [self getTagNameArrFromModelArray:model.roommateRequires];
            break;
        case 4://家居设施
            strArray =  [self getTagNameArrFromModelArray:model.paymentType];
            break;
            
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
    tagList.selectArray = selectArray;
    weak(self);
    tagList.didselectItemBlock = ^(NSArray *arr, NSInteger ViewTag) {
        NSLog(@"------>视图%zd的选中的标签%@",ViewTag,arr);//存在循环引用
        if (arr.count>=3) {
            tipsLabe.hidden = NO;
        }else{
            tipsLabe.hidden = YES;
        }
        //判断是否是我的标签
        if (weakSelf.MFTagsViewType == 0 ) {
            if (arr.count>0 &&arr !=nil) {
               [weakSelf.allTagsArray replaceObjectAtIndex:ViewTag withObject:arr];
            }
        }else{
            weakSelf.allTagsArray = arr.copy;
        }
    };
    [tagList setTagWithTagArray:strArray];
    
    bgView.frame = CGRectMake(0, origin.y, SCREEN_WIDTH, tagList.size.height+60);
    
    return bgView;
}

#pragma mark - 回调
-(void)saveBtnClick:(UIButton*)sender{
    
    //解析数组去掉空元素
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.allTagsArray];
    
    [self.allTagsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray*)obj;
            if (array.count == 0) {
                [tempArray removeObject:array];
            }
        }
    }];
    
    if (self.selectBlock) {
        self.selectBlock(tempArray);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
