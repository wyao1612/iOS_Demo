//
//  MFNetAPIClient.h
//  iOS_demo
//
//  Created by wyao on 2017/7/5.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *该类默认只要导入头文件就会自动检测网络状态，且会在没有网络和未知网络的时候，自动从本地数据库中读取缓存。
 *数据库网络缓存是基于猿题库公司对FMDB进行封装的轻量级 key-value 存储框架
 *详情请见 https://github.com/yuantiku/YTKKeyValueStore
 *对该类如有疑问可以拉个issues
 */



@interface MFNetAPIClient : NSObject


typedef NS_ENUM(NSUInteger, YWRequestSerializer) {
    YWRequestSerializerJSON,     // 设置请求数据为JSON格式
    YWRequestSerializerPlainText    // 设置请求数据为普通 text/html
};

typedef NS_ENUM(NSUInteger, YWResponseSerializer) {
    YWResponseSerializerJSON,    // 设置响应数据为JSON格式
    YWResponseSerializerHTTP,    // 设置响应数据为二进制格式
    YWResponseSerializerXML      // 设置响应数据为XML格式
};




/*********************************************************************
 函数名称 : analyticalHttpErrorDescription:
 函数描述 : 解析http 200之外的错误日志信息
 输入参数 :
 输出参数 :
 返回值 :
 作者   : wyao
 *********************************************************************/
- (NSString *)analyticalHttpErrorDescription:(NSError *)error;



#pragma mark - 网络监测
+ (void)startMonitoringNetworkStatus;
+ (BOOL)isNetReachable;
+ (BOOL)isWifiOn;

#pragma mark - 程序入口设置网络请求头API  一般调用一次即可
/**
 设置 请求和响应类型和超时时间
 
 @param requestType  默认为请求类型为JSON格式
 @param responseType 默认响应格式为JSON格式
 @param timeOut      请求超时时间 默认为20秒
 */
+(void)setTimeOutWithTime:(NSTimeInterval)timeOut
              requestType:(YWRequestSerializer)requestType
             responseType:(YWResponseSerializer)responseType;

/**
 设置 请求头
 
 @param httpBody 根据服务器要求 配置相应的请求体
 */
+ (void)setHttpBodyWithDic:(NSDictionary *)httpBody;

#pragma mark - 网络工具 API
/**
 获取当前的网络状态
 
 @return YES 有网  NO 没有联网
 */
+(BOOL)getCurrentNetWorkStatus;

/**
 获取网络缓存 文件大小
 
 @return size  单位M 默认保留两位小数 如: 0.12M
 */
+ (NSString *)fileSizeWithDBPath;
/**
 清除所有网络缓存
 */
+ (void)cleanNetWorkRefreshCache;

#pragma mark -  GET 请求API

/**
 GET 请求  不用传参 API
 
 @param url          请求的url
 @param refreshCache 是否对该页面进行缓存
 @param success      请求成功回调
 @param fail         请求失败回调
 
 @return self
 */
+ (MFNetAPIClient *)getWithUrl:(NSString *)url
                  refreshCache:(BOOL)refreshCache
                       success:(void(^)(id responseObject))success
                          fail:(void(^)(NSError *error))fail;

/**
 GET 请求 传参数的API
 
 @param url          请求的url
 @param refreshCache 是否对该页面进行缓存
 @param params       请求数据向服务器传的参数
 @param success      请求成功回调
 @param fail         请求失败回调
 
 @return self
 */
+ (MFNetAPIClient *)getWithUrl:(NSString *)url
                  refreshCache:(BOOL)refreshCache
                        params:(NSDictionary *)params
                       success:(void(^)(id responseObject))success
                          fail:(void(^)(NSError *error))fail;

/**
 GET 请求 带有进度回调的 API
 
 @param url               请求的url
 @param refreshCache 是否对该页面进行缓存
 @param params       请求数据向服务器传的参数
 @param progress     请求进度回调
 @param success      请求成功回调
 @param fail         请求失败回调
 
 @return self
 */
+ (MFNetAPIClient *)getWithUrl:(NSString *)url
                  refreshCache:(BOOL)refreshCache
                        params:(NSDictionary *)params
                      progress:(void(^)(int64_t bytesRead, int64_t totalBytesRead))progress
                       success:(void(^)(id responseObject))success
                          fail:(void(^)(NSError *error))fail;


#pragma mark -  POST 请求API


/**
 POST 请求API
 
 @param url          请求的url
 @param refreshCache 是否对该页面进行缓存
 @param params       请求数据向服务器传的参数
 @param success      请求成功回调
 @param fail         请求失败回调
 
 @return self
 */
+ (MFNetAPIClient *)postWithUrl:(NSString *)url
                   refreshCache:(BOOL)refreshCache
                         params:(NSDictionary *)params
                        success:(void(^)(id responseObject))success
                           fail:(void(^)(NSError *error))fail;


/**
 POST 请求 带有进度回调的 API
 
 @param url               请求的url
 @param refreshCache 是否对该页面进行缓存
 @param params       请求数据向服务器传的参数
 @param progress     请求进度回调
 @param success      请求成功回调
 @param fail         请求失败回调
 
 @return self
 */
+ (MFNetAPIClient *)postWithUrl:(NSString *)url
                   refreshCache:(BOOL)refreshCache
                         params:(NSDictionary *)params
                       progress:(void(^)(int64_t bytesRead, int64_t totalBytesRead))progress
                        success:(void(^)(id responseObject))success
                           fail:(void(^)(NSError *error))fail;


/**
 不需要缓存的网络请求API
 
 @param httpMethod 网络方式
 @param url        url地址
 @param params     参数
 @param progress   进度
 @param success    请求成功回调
 @param fail       请求失败回调
 */
+ (void)requestNotCacheWithHttpMethod:(NSInteger)httpMethod
                                  url:(NSString *)url
                               params:(NSDictionary *)params
                             progress:(void(^)(int64_t bytesRead, int64_t totalBytesRead))progress
                              success:(void(^)(id responseObject))success
                                 fail:(void(^)(NSError *error))fail;

/**
 *  取消指定标记的网络请求
 *
 *  @param requestID 指定标记id
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

/**
 *  取消指定标记组的网络请求
 *
 *  @param requestIDList 指定标记组
 */
- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
@end
