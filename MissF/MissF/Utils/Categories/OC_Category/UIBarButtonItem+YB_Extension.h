//
//  UIBarButtonItem+YB_Extension.h
//  GolfIOS
//
//  Created by yangbin on 16/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YB_Extension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
+ (instancetype)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage targer:(id)target action:(SEL)action;

@end
