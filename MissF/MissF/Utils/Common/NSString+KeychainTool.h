//
//  NSString+KeychainTool.h
//  MissF
//
//  Created by wyao on 2017/7/12.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KeychainTool)
/** 获取指定account 的密码*/
+ (NSString *)readUserFromDiskWithAccount:(NSString*)account;
/** 存储指定 serviceName 和 account 的密码*/
+ (void)SaveUserToDiskWith:(NSString*)keyChainToken withAccount:(NSString*)account;
@end
