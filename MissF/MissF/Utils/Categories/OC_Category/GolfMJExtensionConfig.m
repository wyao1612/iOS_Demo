//
//  GolfMJExtensionConfig.m
//  GolfIOS
//
//  Created by 张永亮 on 2016/10/24.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import "GolfMJExtensionConfig.h"
#import <MJExtension/MJExtension.h>

@implementation GolfMJExtensionConfig

+ (void)load
{
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{@"errorCode":@"status",
                 @"errorMsg":@"showMessage",
                 @"ID":@"id",
                 @"desc":@"description"};
    }];
}

@end
