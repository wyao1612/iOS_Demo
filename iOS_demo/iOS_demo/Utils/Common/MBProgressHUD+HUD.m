//
//  MBProgressHUD+HUD.m
//  LilyForParent
//
//  Created by sunhw on 16/5/10.
//  Copyright © 2016年 Lily. All rights reserved.
//

#import "MBProgressHUD+HUD.h"

@implementation MBProgressHUD (HUD)

+ (void)showText:(NSString *)text {
    [self showText:text toView:nil];
}

+ (void)showText:(NSString *)text toView:(UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:0.8];
}

+ (void)showText:(NSString *)text image:(NSString *)imageName toView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.label.text = text;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@",imageName]]];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:0.8];
}

+ (void)showSuccess:(NSString *)successText toView:(UIView *)view {
    [self showText:successText image:@"success" toView:view];
}

+ (void)showSuccess:(NSString *)successText {
    [self showSuccess:successText toView:nil];
}

+ (void)showError:(NSString *)errorText toView:(UIView *)view {
    [self showText:errorText image:@"error" toView:view];
}

+ (void)showError:(NSString *)errorText {
    [self showError:errorText toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

@end
