//
//  MFpublishViewController.m
//  MissF
//
//  Created by wyao on 2017/7/23.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFpublishViewController.h"
#import "MFplaceholderTextView.h"




@interface MFpublishViewController ()

@end

@implementation MFpublishViewController

#pragma mark - 照片默认图片点击事件
-(void)headerBackViewTapClick:(UITapGestureRecognizer*)tap{
    [self.onePhotoView goPhotoViewController];
}

#pragma mark - 相册选择代理方法
-(void)photoViewAllNetworkingPhotoDownloadComplete:(HXPhotoView *)photoView{
}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    
    NSLog(@"onePhotoView - %@",photos);
    if (photos.count>0) {
        self.headerImageView.hidden = YES;
        self.nameLabel.hidden = YES;
        self.onePhotoView.hidden = NO;
    }else{
        self.headerImageView.hidden = NO;
        self.nameLabel.hidden = NO;
        self.onePhotoView.hidden = YES;
    }
    // 2.图片位置信息
    if (iOS8Later) {
        for (HXPhotoModel *model in photos) {
            NSLog(@"---->坐标位置%@",model.asset.location);
        }
    }
    
    
     if (photos.count>0) {
      /*
       
     [SVProgressHUD showWithStatus:@"正在上传图片"];
     NSDictionary *parameter = @{@"file":@".png",
     @"type":@"roommate"};
    
     //上传图片
     [[MFNetAPIClient sharedInstance] uploadImageWithUrlString:kupload parameters:parameter ImageArray:photos  SuccessBlock:^(id responObject) {
     [SVProgressHUD showInfoWithStatus:responObject[@"message"]];
     } FailurBlock:^(NSInteger errCode, NSString *errorMsg) {
     [SVProgressHUD showInfoWithStatus:errorMsg];
     } UpLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
     
     }];
          
       */
     }

}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSLog(@"%@",NSStringFromCGRect(frame));
    self.headerBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height+60);
    [self.PublishTableView reloadData];
}

#pragma mark - 设置cell的显示
-(void)setCellwith:(MFRoommateTableViewCell *)cell title:(NSString*)title withValue:(NSString*)value andPlaceholderText:(NSString*)placeholderText{
    
    if ([NSString iSBlankString:value]) {
        [cell setTitleStr:title valueStr:placeholderText withValueColor:LIGHTTEXTCOLOR];
    }else{
        [cell setTitleStr:title valueStr:value withValueColor:BLACKTEXTCOLOR];
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
        
        //非编辑状态 不带箭头
        [_PublishTableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_TitleValueMore];
        [_PublishTableView registerClass:[MFRoommateTagsViewCell class] forCellReuseIdentifier:kCellIdentifier_TagsViewCell];
        [_PublishTableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_OnlyValue];
        [_PublishTableView registerClass:[MFRoommateTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_TextField];
        
        _PublishTableView.delegate = self;
        _PublishTableView.dataSource = self;
        _PublishTableView.tableHeaderView = self.headerBackView;
        _PublishTableView.tableFooterView = self.tableFooterView;
    }
    return _PublishTableView;
}



-(HXPhotoView *)onePhotoView{
    if (!_onePhotoView) {
        _onePhotoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(13, 14, SCREEN_WIDTH-26, 116) WithManager:self.manager];
        _onePhotoView.hidden= YES;//默认不显示
        _onePhotoView.delegate = self;
    }
    return _onePhotoView;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.openCamera = YES;
        _manager.outerCamera = YES;
        _manager.showFullScreenCamera = YES;
        _manager.photoMaxNum = 9;
        _manager.maxNum = 9;
    }
    return _manager;
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
        titleLabel.text = @"室友要求";
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


-(UIView *)headerBackView{
    if (!_headerBackView) {
        _headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
        _headerBackView.backgroundColor = WHITECOLOR;
        [_headerBackView addSubview:self.headerImageView];
        [_headerBackView addSubview:self.nameLabel];
        [_headerBackView addSubview:self.onePhotoView];
    }
    return _headerBackView;
}

-(UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-147)*0.5, (175-76)*0.5, 147, 76)];
        _headerImageView.userInteractionEnabled = YES;
        _headerImageView.image = IMAGE(@"icon_Release_house_nor");
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerBackViewTapClick:)];
        [_headerImageView addGestureRecognizer:tap];
        [_headerImageView setBackgroundColor:[UIColor whiteColor]];
        [_headerImageView setContentMode:UIViewContentModeRedraw];
        [_headerImageView setClipsToBounds:YES];
    }
    return _headerImageView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 280)*0.5, CGRectGetMaxY(self.headerImageView.frame)+20, 280, 15)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"听说长得好看的人租房费用都比较低哦~";
        _nameLabel.textColor = LIGHTTEXTCOLOR;
    }
    return _nameLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
