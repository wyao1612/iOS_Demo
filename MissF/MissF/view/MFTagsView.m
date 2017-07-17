//
//  MFTagsView.m
//  MissF
//
//  Created by wyao on 2017/7/14.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFTagsView.h"
#import "MFbutton.h"


#define SpacingX        15   //横向间距都是15
#define SpacingY        23   //纵向间距都是23
#define titleMargin     10   //按钮字体左右间距
#define leftMargin      25   //按钮距离起始边距
#define BtnHeight       22   //按钮高度
#define originY         45   //按钮高度

@implementation MFTagsView
    
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WHITECOLOR;
    }
    return self;
}
    
#pragma mark - 设置标签数据源
-(void)setHeaderDataArr:(NSMutableArray<MFCommonBaseModel *> *)headerDataArr{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _headerDataArr = headerDataArr;
    [self layoutBtnArrayWithtagsName:_tagsName];
}

-(void)layoutBtnArrayWithtagsName:(NSString*)tagsName{
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    tagsName = [NSString iSBlankString:tagsName] ? @"标签名称" :tagsName;
    titleLab.text = tagsName;
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:titleLab];
    
    CGFloat totalHeight = 0;
    
    CGFloat oneLineBtnWidtnLimit = SCREEN_WIDTH - 2*leftMargin;//每行btn占的最长长度，超出则换行
    CGFloat btnGap = SpacingX;//btn的x间距
    CGFloat btnGapY = SpacingY;
    NSInteger BtnlineNum = 0;
    CGFloat minBtnLength =  50;//每个btn的最小长度
    CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
    CGFloat Btnx = 0.0 ;//每个btn的起始位置
    Btnx += btnGap;
    
    for (int i = 0; i < _headerDataArr.count; i++) {
        MFCommonBaseModel *model = _headerDataArr[i];
        CGFloat btnWidth = [self WidthWithString:model.name fontSize:13 height:BtnHeight];
        btnWidth += 2 * titleMargin;//让文字两端留出间距
        
        if(btnWidth<minBtnLength)
            btnWidth = minBtnLength;
        
        if(btnWidth>maxBtnLength)
            btnWidth = maxBtnLength;
        
        if(Btnx + btnWidth > oneLineBtnWidtnLimit)
        {
            BtnlineNum ++;//长度超出换到下一行
            Btnx = btnGap;
        }
        
        
        MFbutton *btn = [[MFbutton alloc] init];
        
        CGFloat height = titleLab.frame.size.height+titleLab.frame.origin.x + (BtnlineNum*(BtnHeight+btnGapY));
        btn.frame = CGRectMake(Btnx, height,
                               btnWidth,BtnHeight);
        [btn setTitle:model.name forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.cornerRadius = 5;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [[UIColor grayColor] CGColor];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.accessibilityIdentifier = [NSString stringWithFormat:@"%d",i];
        //[btn addTarget:self action:@selector(standardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        Btnx =Btnx + btnWidth + btnGap;
        
        [self addSubview:btn];
    }
    
    totalHeight = 30 + (1+BtnlineNum)*(BtnHeight+btnGapY) + btnGapY;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, totalHeight);

    if (_headerDataArr.count == 0) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        
    }
}

-(CGFloat)getCellHeightWtihBtns:(NSArray*)arrry{
    
    CGFloat totalHeight = 0;
    
    CGFloat oneLineBtnWidtnLimit = SCREEN_WIDTH - 50;//每行btn占的最长长度，超出则换行
    CGFloat btnGap = SpacingX;//btn的x间距
    CGFloat btnGapY = SpacingY;
    NSInteger BtnlineNum = 0;
    CGFloat minBtnLength =  50;//每个btn的最小长度
    CGFloat maxBtnLength = oneLineBtnWidtnLimit - btnGap*2;//每个btn的最大长度
    CGFloat Btnx = 0.0 ;//每个btn的起始位置
    Btnx += btnGap;
    
    for (int i = 0; i < arrry.count; i++) {
        MFCommonBaseModel *model = arrry[i];
        CGFloat btnWidth = [self WidthWithString:model.name fontSize:13 height:BtnHeight];
        btnWidth += 2 * titleMargin;//让文字两端留出间距
        
        if(btnWidth<minBtnLength)
            btnWidth = minBtnLength;
        
        if(btnWidth>maxBtnLength)
            btnWidth = maxBtnLength;
        
        if(Btnx + btnWidth > oneLineBtnWidtnLimit)
        {
            BtnlineNum ++;//长度超出换到下一行
            Btnx = btnGap;
        }
        Btnx =Btnx + btnWidth + btnGap;
        
    }
    totalHeight = 30 + (1+BtnlineNum)*(BtnHeight+btnGapY) + btnGapY;
    
    return totalHeight;
    
}

#pragma mark - 根据字符串计算宽度
-(CGFloat)WidthWithString:(NSString*)string fontSize:(CGFloat)fontSize height:(CGFloat)height
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return  [string boundingRectWithSize:CGSizeMake(0, height) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size.width;
}


-(void)titBtnClike:(UIButton *)sender{
    
    [_headerDataArr removeObjectAtIndex:sender.tag - 1000];
    [self.delegate BtnActionDelegate:_headerDataArr];
    
}

@end
