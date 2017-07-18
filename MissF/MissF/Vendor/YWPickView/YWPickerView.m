//
//  FTT_PickerView.m
//  FTT_PickerView
//
//  Created by cmcc on 16/8/31.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "YWPickerView.h"

#define KscreenWidth  [UIScreen mainScreen].bounds.size.width
#define KscreenHeight [UIScreen mainScreen].bounds.size.height

#define BtnW  60
#define toolH 35
#define BGH  200

@interface YWPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource> {
    UIView        *_BGView ;
    NSArray       *_Allarray;
    UIPickerView   *_PickerView;
    NSString   *_selectString;
}
/** 是否为第一次创建*/
@property (nonatomic, assign) BOOL firstCreate;
@property (nonatomic, copy  ) NSString       *selectedItem;         //Single Column of the selected item
@end

@implementation YWPickerView


static YWPickerView *shareInstance = nil;


- (instancetype)initWithFrame:(CGRect)frame PickerViewType:(FTT_PickerViewShowType)showtype DataSoucre:(NSMutableArray *)array {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.frame = frame;
        _Allarray = array;
        self.showType = showtype;
         [WSDNotificationCenter addObserver:self selector:@selector(firstSelect) name:@"firstNumSelect" object:nil];
        
    }
    return self;
}

- (void)firstSelect{
    if (!_firstCreate) {
        _firstCreate = YES;
        [_PickerView selectRow:0 inComponent:0 animated:NO];
        [self pickerView:_PickerView didSelectRow:0 inComponent:0];
    }else{
        [_PickerView selectRow:0 inComponent:0 animated:NO];
        [self pickerView:_PickerView didSelectRow:0 inComponent:0];
    }
}

- (void)dealloc{
    [WSDNotificationCenter removeObserver:self];
}

#pragma mark - UI
- (void)createUI:(FTT_PickerViewShowType )type {
    
    
    self.showType = type;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    _BGView = [[UIView alloc]init];
    _BGView.layer.cornerRadius = 5;
    _BGView.layer.masksToBounds = YES;
    if (FTT_PickerViewShowTypeSheet == type) {
        _BGView.frame = CGRectMake(10, 0, KscreenWidth-20, BGH);
        _BGView.center = self.center;
    }else {
        _BGView.frame = CGRectMake(10, KscreenHeight, KscreenWidth-20, BGH-10);
    }
    [self addSubview:_BGView];
    
    UIView *tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, KscreenWidth-20, toolH)];
    tool.backgroundColor = BACKGROUNDCOLOR;
    [_BGView addSubview:tool];
    NSArray *titileArray = @[@"取消",@"确定"];
    for (int i = 0; i < titileArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0 + (KscreenWidth - BtnW-20) * i, 0, BtnW, toolH);
        [btn setTitle:titileArray[i] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn setTitleColor:GLOBALCOLOR forState:UIControlStateNormal];
        btn.titleLabel.font = FONT(15);
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [_BGView addSubview:btn];
    }
    
    _PickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, toolH, KscreenWidth-20, _BGView.frame.size.height - toolH)];
    _PickerView.delegate = self;
    _PickerView.dataSource = self;
    _PickerView.backgroundColor = BACKGROUNDCOLOR;
    [_BGView addSubview:_PickerView];
    
    weak(self);
    [_Allarray enumerateObjectsUsingBlock:^(NSString *rowItem, NSUInteger rowIdx, BOOL *stop) {
        if ([weakSelf.selectedItem isEqualToString:rowItem]) {
            [_PickerView selectRow:rowIdx inComponent:0 animated:NO];
            *stop = YES;
        }
    }
     ];

}



#pragma mark ---- UIPickerVIewDelegate

// 有多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// 对应的每个cell的个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _Allarray.count;
}


// 每个cell显示的内容
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_Allarray objectAtIndex:row];
}

// 自定义每个pickerview的lable
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    UILabel *lb = [[UILabel alloc] init];
    lb.textColor = SHENTEXTCOLOR;
    lb.font = FONT(15);
    lb.text = _Allarray[row];
    lb.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:lb];
    lb.sd_layout
    .centerYEqualToView(contentView)
    .centerXEqualToView(contentView)
    .autoHeightRatio(0);
    [lb setSingleLineAutoResizeWithMaxWidth:200];
    
    
    return contentView;

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    UIView *contentView = [pickerView viewForRow:row forComponent:component];
    contentView.backgroundColor = WHITECOLOR;
    UILabel *lb = contentView.subviews.firstObject;
    lb.textColor = GLOBALCOLOR;
    
    NSInteger timeIndex = [pickerView selectedRowInComponent:0];
    _selectString = [NSString stringWithFormat:@"%@",_Allarray[timeIndex]];
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return  KscreenWidth;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 45;
}



#pragma mark -  按钮触发的事件
- (void)btn:(UIButton *)btn {
    __weak typeof (UIView *)blockview = _BGView;
    __weak typeof(self) weakself= self;
    __block int blockH= KscreenHeight;
    if (btn.tag == 101) {
        self.select(_selectString);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect bjf = blockview.frame;
        bjf.origin.y = blockH;
        blockview.frame = bjf;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        [weakself removeFromSuperview];
    }];
    
}


-(void)showCityView:(void (^)(NSString *))selectStr{
    
    [self createUI:self.showType];
    
    self.select = selectStr;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    __weak typeof(UIView*)blockview = _BGView;
    __block int blockH = KscreenHeight;
    __block int bgh = BGH;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect bjf = blockview.frame;
        if (self.showType == FTT_PickerViewShowTypeSheet) {
            blockview.center = self.center;
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        }else {
            bjf.origin.y = blockH- bgh;
            blockview.frame = bjf;
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(_BGView.frame, point)) {
        UIButton *btn = (UIButton *)[_BGView viewWithTag:100];
        [self btn:btn];
    }
}

@end
