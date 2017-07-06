//
//  MBProgressHUD+HUD.m
//  LilyForParent
//
//  Created by sunhw on 16/5/10.
//  Copyright © 2016年 Lily. All rights reserved.
//

#import "MBProgressHUD+HUD.h"
#define kHUDQueryViewTag 101

@implementation MBProgressHUD (HUD)

+ (void)showText:(NSString *)text {
    [self showText:text toView:nil];
}

+ (void)showText:(NSString *)text toView:(UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    if (text && text.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
        hud.label.text = text;
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1.0];
    }

}

+ (void)showText:(NSString *)text image:(NSString *)imageName toView:(UIView *)view {
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    if (text && text.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.bezelView.color = [UIColor blackColor];
        hud.contentColor = [UIColor whiteColor];
        hud.label.text = text;
        hud.detailsLabel.font = [UIFont boldSystemFontOfSize:15.0];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@",imageName]]];
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:0.8];
    }

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

+ (MBProgressHUD *)showHUDQueryStr:(NSString *)titleStr{
    titleStr = titleStr.length > 0? titleStr: @"正在获取数据...";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.tag = kHUDQueryViewTag;
    hud.label.text = titleStr;
    hud.label.font = [UIFont boldSystemFontOfSize:15.0];
    hud.margin = 10.f;
    return hud;
}
+ (NSUInteger)hideHUDQuery{
    __block NSUInteger count = 0;
    NSArray *huds = [MBProgressHUD allHUDsForView:kKeyWindow];
    [huds enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (obj.tag == kHUDQueryViewTag) {
            [obj removeFromSuperview];
            count++;
        }
    }];
    return count;
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
