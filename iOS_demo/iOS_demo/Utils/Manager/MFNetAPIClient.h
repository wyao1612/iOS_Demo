//
//  MFNetAPIClient.h
//  iOS_demo
//
//  Created by wyao on 2017/7/4.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFNetAPIClient : NSObject
/*********************************************************************
 函数名称 : analyticalHttpErrorDescription:
 函数描述 : 解析http 200之外的错误日志信息
 输入参数 :
 输出参数 :
 返回值 :
 作者   : wyao
 *********************************************************************/
- (NSString *)analyticalHttpErrorDescription:(NSError *)error;


/*********************************************************************
 函数名称 : afHTTPSessionManagerToServerInteractionWithInterface:
 函数描述 : AFHTTPSessionManager响应请求
 输入参数 :
 输出参数 :
 返回值 :
 作者   : wyao
 *********************************************************************/
- (void)afHTTPSessionManagerToServerInteractionWithInterface:(NSString *)interface parameter:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
