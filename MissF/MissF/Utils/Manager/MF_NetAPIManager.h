//
//  MF_NetAPIManager.h
//  iOS_demo
//
//  Created by wyao on 2017/7/4.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MF_NetAPIManager : NSObject
+ (instancetype)sharedManager;
#pragma mark - 登录
/** 获取短信验证码*/
- (void)postRegCodeWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
/** 登录*/
- (void)postLoginWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
@end
