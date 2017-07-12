//
//  STL_CommonIdea.m
//  GolfIOS
//
//  Created by 李明星 on 2016/11/3.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "STL_CommonIdea.h"
#import "NSArray+Properties.h"

@implementation STL_CommonIdea

+ (void)alertWithTarget:(id)target Title:(NSString *)title message:(NSString *)message action_0:(NSString *)action_0 action_1:(NSString *)action_1 block_0:(NILBlock)block_0 block_1:(NILBlock)block_1{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0;
    if (action_0) {
        action0 = [UIAlertAction actionWithTitle:action_0 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (block_0) {
                block_0();
            }
        }];
        [alertVc addAction:action0];
    }
    
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:action_1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (block_1) {
            block_1();
        }
    }];
    if (Device_VERSION >= 8.3) {
        [action0 setValue:BLACKTEXTCOLOR forKey:@"_titleTextColor"];
        [action1 setValue:GLOBALCOLOR forKey:@"_titleTextColor"];
    }
    
//    [alertVc addAction:action0];
    [alertVc addAction:action1];
    [target presentViewController:alertVc animated:YES completion:nil];
}

+ (UINavigationController *)loginNavi{
//    WSDLoginViewController *loginVc = [[WSDLoginViewController alloc] init];
//    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:loginVc];
//    return navi;
    return nil;
}
@end
