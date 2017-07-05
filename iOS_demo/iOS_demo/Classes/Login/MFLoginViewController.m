//
//  MFLoginViewController.m
//  iOS_demo
//
//  Created by wyao on 2017/7/4.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFLoginViewController.h"

@interface MFLoginViewController ()
<TTTAttributedLabelDelegate>
@property (strong, nonatomic) UIButton              *dismissButton;
@property (strong, nonatomic) UIImageView           *bgImageView;
@property (strong, nonatomic) UIImageView           *iconImageView;
@property (strong, nonatomic) UIImageView           *iconIntroImageView;
@property (strong, nonatomic) YW_TextField          *phoneField;
@property (strong, nonatomic) UIView                *phoneLine_View;
@property (strong, nonatomic) YW_TextField          *passwordField;
@property (strong, nonatomic) UIView                *passwordLine_View;
@property (strong, nonatomic) UITTTAttributedLabel  *lineLabel;
@property (strong, nonatomic) JKCountDownButton     *sendTestBtn;
@property (strong, nonatomic) UILabel               *tipsLabel;
@property (strong, nonatomic) UIImageView           *loginImageView;
@end

@implementation MFLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isAutoBack = NO;
    self.view.backgroundColor = BACKGROUNDCOLOR;
    [self.view addSubview:self.bgImageView];
    [self showdismissButton:self.showDismissButton];
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.iconIntroImageView];
    [self.view addSubview:self.lineLabel];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.passwordField];
    [self.view addSubview:self.phoneLine_View];
    [self.view addSubview:self.passwordLine_View];
    [self.view addSubview:self.sendTestBtn];
    [self.view addSubview:self.tipsLabel];
    [self.view addSubview:self.loginImageView];
    
    self.iconImageView.sd_layout
    .topSpaceToView(self.view,85)
    .centerXEqualToView(self.view)
    .widthIs(95)
    .heightIs(35);
    
    self.iconIntroImageView.sd_layout
    .topSpaceToView(self.iconImageView,17)
    .centerXEqualToView(self.view)
    .widthIs(218)
    .heightIs(30);
    
    self.phoneField.sd_layout
    .topSpaceToView(self.iconIntroImageView, 75)
    .centerXEqualToView(self.view)
    .widthIs(250)
    .heightIs(60);
    
    self.passwordField.sd_layout
    .topSpaceToView(self.phoneField, 0)
    .leftEqualToView(self.phoneField)
    .widthIs(173.5)
    .heightIs(60);
    
    self.phoneLine_View.sd_layout
    .topSpaceToView(self.phoneField, 0)
    .centerXEqualToView(self.phoneField)
    .widthIs(250)
    .heightIs(0.5);
    
    self.passwordLine_View.sd_layout
    .topSpaceToView(self.passwordField, 0)
    .centerXEqualToView(self.passwordField)
    .widthIs(173.5)
    .heightIs(0.5);
    
    self.sendTestBtn.sd_layout
    .centerYEqualToView(self.passwordField)
    .leftSpaceToView(self.passwordField, 8)
    .widthIs(78)
    .heightIs(42);
    
    self.tipsLabel.sd_layout
    .topSpaceToView(self.passwordLine_View, 18)
    .centerXEqualToView(self.view)
    .widthIs(190)
    .heightIs(13);
    
    self.loginImageView.sd_layout
    .topSpaceToView(self.tipsLabel, 50)
    .centerXEqualToView(self.view)
    .widthIs(270)
    .heightIs(60);
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)showdismissButton:(BOOL)willShow{
    self.dismissButton.hidden = !willShow;
    if (!self.dismissButton && willShow) {
        self.dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
        [self.dismissButton setImage:[UIImage imageNamed:@"login_cancel"] forState:UIControlStateNormal];
        [self.dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.dismissButton];
    }
}

- (YW_TextField *)phoneField{
    if (!_phoneField) {
        _phoneField = [[YW_TextField alloc] init];
        _phoneField.placeholder = @"请输入您的手机号";
        _phoneField.textColor = WHITECOLOR;
        _phoneField.font = FONT(15);
        _phoneField.borderColor = ClearColor;
        _phoneField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneField setValue:WHITECOLOR forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _phoneField;
}

- (YW_TextField *)passwordField{
    if (!_passwordField) {
        _passwordField = [[YW_TextField alloc] init];
        _passwordField.placeholder = @"输入验证码";
        _passwordField.textColor = WHITECOLOR;
        _passwordField.font = FONT(15);
        _passwordField.borderColor = ClearColor;
        _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
        [_passwordField setValue:WHITECOLOR forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _passwordField;
}
-(UITTTAttributedLabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UITTTAttributedLabel alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT-35, SCREEN_WIDTH-40, 20)];
        _lineLabel.textAlignment = NSTextAlignmentCenter;
        _lineLabel.font = [UIFont systemFontOfSize:13];
        _lineLabel.textColor = WHITECOLOR;
        _lineLabel.numberOfLines = 0;
        _lineLabel.linkAttributes = kLinkAttributes;
        _lineLabel.activeLinkAttributes = kLinkAttributesActive;
        _lineLabel.delegate = self;
        
        NSString *tipStr = @"登录即同意《注册及用户协议》";
        _lineLabel.text = tipStr;
        [_lineLabel addLinkToTransitInformation:@{@"actionStr" : @"gotoServiceTermsVC"} withRange:[tipStr rangeOfString:@"《注册及用户协议》"]];
    }
    return _lineLabel;
}

-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgImageView.image = IMAGE(@"login_bg");
    }
    return _bgImageView;
}
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = IMAGE(@"login_logo");
    }
    return _iconImageView;
}
-(UIImageView *)iconIntroImageView{
    if (!_iconIntroImageView) {
        _iconIntroImageView = [[UIImageView alloc] init];
        _iconIntroImageView.image = IMAGE(@"login_slogan");
    }
    return _iconIntroImageView;
}
-(UIView *)phoneLine_View{
    if (!_phoneLine_View) {
        _phoneLine_View = [[UIView alloc] init];
        _phoneLine_View.backgroundColor = WHITECOLOR;
    }
    return _phoneLine_View;
}
-(UIView *)passwordLine_View{
    if (!_passwordLine_View) {
        _passwordLine_View = [[UIView alloc] init];
        _passwordLine_View.backgroundColor = WHITECOLOR;
    }
    return _passwordLine_View;
}

- (JKCountDownButton *)sendTestBtn{
    if (!_sendTestBtn) {
        _sendTestBtn = [[JKCountDownButton alloc] init];
        _sendTestBtn.backgroundColor = ClearColor;
        [_sendTestBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_sendTestBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        _sendTestBtn.titleLabel.font = FONT(15);
        [_sendTestBtn addTarget:self action:@selector(loginSendTestWordAction) forControlEvents:UIControlEventTouchUpInside];
        [_sendTestBtn didChange:^NSString *(JKCountDownButton *countDownButton, int second) {
            NSString *text = [NSString stringWithFormat:@"%d秒",second];
            return text;
        }];
        
        [_sendTestBtn didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"重新发送";
        }];
    }
    return _sendTestBtn;
}

-(UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] init];
        _tipsLabel.text = @"未注册账号收取验证码即可登录";
        _tipsLabel.textColor = WHITECOLOR;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.font = [UIFont systemFontOfSize:13.0f];
    }
    return _tipsLabel;
}

-(UIImageView *)loginImageView{
    if (!_loginImageView) {
        _loginImageView = [[UIImageView alloc] init];
        _loginImageView.tag = 101;
        _loginImageView.userInteractionEnabled = YES;
        _loginImageView.image = [UIImage imageNamed:@"login_btn"];
        _loginImageView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginAction:)];
        [_loginImageView addGestureRecognizer:tap];
    }
    return _loginImageView;
}

- (void)dismissButtonClicked{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 发送验证码*/
- (void)loginSendTestWordAction{
    if (!_phoneField.text.length || ![_phoneField.text validateMobile]) {
        [MBProgressHUD showError:@"请输入正确手机号码"];
        return;
    }

    NSDictionary *params = @{@"mobile": _phoneField.text,
                            @"type": [NSString stringWithFormat:@"%@", @"100001"]};
    weak(self);
    [MFNetAPIClient requestNotCacheWithHttpMethod:1 url:@"https://api.douban.com/v2/book/1220562" params:params progress:nil success:^(id responseObject) {
        
    } fail:^(NSError *error) {
        
    }];
}

/** 点击登录按钮*/
- (void)loginAction:(UITapGestureRecognizer*)sender{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
