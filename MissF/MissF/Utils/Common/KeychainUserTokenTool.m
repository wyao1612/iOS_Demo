//
//  SSKeychain+token.m
//  iOS_demo
//
//  Created by wyao on 2017/7/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "KeychainUserTokenTool.h"


@implementation KeychainUserTokenTool

#pragma mark - Priviate Methods
NSString *const KEYCHAIN_SERVICE  = @"com.MissF.live";


- (NSString *)readUserFromDiskWith:(NSString*)keyChainToken fromAccount:(NSString*)account{
   NSString *keyToken =  [SSKeychain passwordForService:KEYCHAIN_SERVICE account:account];
    return keyToken;
}


- (void)SaveUserToDiskWith:(NSString*)keyChainToken withAccount:(NSString*)account{
    
    //查看本地是否存储指定serviceName和account的密码
    if (![SSKeychain passwordForService:KEYCHAIN_SERVICE account:account]) {
        //如果没设置密码则设定密码并存储
        [SSKeychain setPassword:keyChainToken forService:KEYCHAIN_SERVICE account:account];
    }else{//本地钥匙串有密码
        //先判断是否一样,一样就不保存，不一样就删除之前存储本次
          NSString *curentKey = [SSKeychain passwordForService:KEYCHAIN_SERVICE account:account];
        if ([curentKey isEqualToString:keyChainToken]) {
            return;
        }else{
             [SSKeychain deletePasswordForService:KEYCHAIN_SERVICE account:account];
             [SSKeychain setPassword:keyChainToken forService:KEYCHAIN_SERVICE account:account];
        }
    }
}

@end
