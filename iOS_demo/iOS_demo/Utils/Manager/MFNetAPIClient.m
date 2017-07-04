//
//  MFNetAPIClient.m
//  iOS_demo
//
//  Created by wyao on 2017/7/4.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFNetAPIClient.h"

@implementation MFNetAPIClient

- (NSString *)analyticalHttpErrorDescription:(NSError *)error
{
    __weak NSDictionary *userInfo = error.userInfo;
    if (userInfo.count > 0) {
        return [self stringForValue:[userInfo objectForKey:@"NSLocalizedDescription"]];
    }
    return error.description;
}

- (NSString *)stringForValue:(id)obj
{
    if (obj == nil||
        obj == NULL||
        [obj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    else if ([obj isKindOfClass:[NSString class]]){
        return obj;
    }
    else if ([obj isKindOfClass:[NSNumber class]]){
        return [obj stringValue];
    }
    return @"";
}

static AFHTTPSessionManager *manager = nil;
static dispatch_once_t onceToken;


#pragma mark - 单例方法
+ (AFHTTPSessionManager*)sharedTools {
    
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        //设置返回数据为json
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.stringEncoding  = NSUTF8StringEncoding;
        manager.requestSerializer.timeoutInterval = 10;
        // 设置当前 instance 的可接受类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    });
    return manager;
}



- (void)afHTTPSessionManagerToServerInteractionWithInterface:(NSString *)interface parameter:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    
    //判断请求链接是否是.app结尾的数据
    if([interface rangeOfString:@".app"].location !=NSNotFound){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:parameters];
        
        NSString *ticket = [WSDUserDefault objectForKey:@"ticket"];
        if (![NSString iSBlankString:ticket]) {
            [dic setObject:ticket forKey:@"ticket"];
        }else{
            [dic setObject:@"" forKey:@"ticket"];
        }
        
        [self afHTTPSessionManagerToServerInteractionWithUrlString:[NSString stringWithFormat:@"%@%@",[WSDUserDefault objectForKey:@"currentAPI"],interface] parameter:dic success:success failure:failure];
    }else{
        [self afHTTPSessionManagerToServerInteractionWithUrlString:[NSString stringWithFormat:@"%@%@",[WSDUserDefault objectForKey:@"currentAPI"],interface] parameter:parameters success:success failure:failure];
    }
    
}


- (void)afHTTPSessionManagerToServerInteractionWithUrlString:(NSString *)urlString parameter:(NSDictionary *)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    AFHTTPSessionManager *manager = [MFNetAPIClient sharedTools];
    NSLog(@"请求地址----》%@",urlString);
    NSLog(@"请求参数----》%@",parameters);
    [manager POST:urlString parameters:parameters
         progress:^(NSProgress *uploadProgress){
             //NSLog(@"uploadProgress:%f",uploadProgress.fractionCompleted);
         }
          success:^(NSURLSessionDataTask *task, id responseObject){
              //NSLog(@"success:%@",responseObject);
              NSInteger flag = [responseObject[@"status"] integerValue];
              if (flag == 4005) {
                  //[[UserModel sharedUserModel] setIsLogin:NO];
              }
              success(responseObject);
          }
          failure:^(NSURLSessionDataTask *task, NSError *error){
              NSLog(@"failure:%@",error);
              failure(error);
          }];
    
}

@end
