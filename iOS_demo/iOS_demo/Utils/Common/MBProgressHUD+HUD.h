//
//  MBProgressHUD+HUD.h
//  LilyForParent
//
//  Created by sunhw on 16/5/10.
//  Copyright © 2016年 Lily. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (HUD)

+ (void)showText:(NSString *)text;

+ (void)showSuccess:(NSString *)successText toView:(UIView *)view;
+ (void)showError:(NSString *)errorText toView:(UIView *)view;
+ (void)showSuccess:(NSString *)successText;
+ (void)showError:(NSString *)errorText;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
