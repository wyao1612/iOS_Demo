//
//  MF_NetAPIManager.m
//  iOS_demo
//
//  Created by wyao on 2017/7/4.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MF_NetAPIManager.h"
#import "MFLoginModel.h"
#import "userViewModel.h"


@implementation MF_NetAPIManager

static MF_NetAPIManager *shareBaseManager = nil;
/**不是使用alloc方法，而是调用[[super allocWithZone:NULL] init]
 已经重载allocWithZone基本的对象分配方法，所以要借用父类（NSObject）
 的功能来帮助出处理底层内存分配的杂物
 */
+(instancetype) sharedManager{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        shareBaseManager = [[super allocWithZone:NULL] init] ;
    }) ;
    return shareBaseManager ;
}

/** 当使用者不是用[BaseManager shareBaseManager]去初始化HomeManager的时候，
 必须重写allocWithZone和copyWithZone方法，保证HomeManager不会被再次初始化
 */
+(instancetype) allocWithZone:(struct _NSZone *)zone{
    return [MF_NetAPIManager sharedManager] ;
}

-(instancetype) copyWithZone:(struct _NSZone *)zone{
    return [MF_NetAPIManager sharedManager] ;
}
-(instancetype) mutablecopyWithZone:(NSZone *)zone
{
    return [MF_NetAPIManager sharedManager] ;
}


- (void)postRegCodeWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    [[MFNetAPIClient sharedInstance] postWithUrl:kPostLogin_Code refreshCache:NO params:parameters success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            responSuccess(responseObject[@"message"]);
        }else{
            responFailure([responseObject[@"code"] integerValue], responseObject[@"message"]);
        }
    } fail:^(NSError *error) {
       responFailure(0, [NSString analyticalHttpErrorDescription:error]);
    }];

}

- (void)postLoginWithParameters:(NSDictionary *)parameters success:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    
    [[MFNetAPIClient sharedInstance] postWithUrl:kPostLogin refreshCache:YES params:parameters success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            MFLoginModel *model = [MFLoginModel  mj_objectWithKeyValues:responseObject[@"data"]];
            //保存用户信息
            [userViewModel shareInstance].userModel = model.userInfo;
            //本地存储accessToken和refreshToken用于验证是否过期
            [NSString SaveUserToDiskWith:model.oauth.accessToken withAccount:ACCESSTOKEN];
            [NSString SaveUserToDiskWith:model.oauth.refreshToken withAccount:REFRESHTOKEN];
            responSuccess(responseObject[@"message"]);
        }else{
            responFailure([responseObject[@"code"] integerValue], responseObject[@"message"]);
        }
    } fail:^(NSError *error) {
        responFailure(0, [NSString analyticalHttpErrorDescription:error]);
    }];
}



@end
