//
//  SSKeychain+userToken.h
//  iOS_demo
//
//  Created by wyao on 2017/7/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <SSKeychain/SSKeychain.h>

@interface KeychainUserTokenTool : NSObject
/** 获取指定 serviceName 和 account 的密码*/
- (NSString *)readUserFromDiskWith:(NSString*)keyChainToken fromAccount:(NSString*)account;
/** 存储指定 serviceName 和 account 的密码*/
- (void)SaveUserToDiskWith:(NSString*)keyChainToken withAccount:(NSString*)account;
@end
