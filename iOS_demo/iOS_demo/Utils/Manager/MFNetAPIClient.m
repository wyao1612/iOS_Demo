//
//  MFNetAPIClient.m
//  iOS_demo
//
//  Created by wyao on 2017/7/4.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "MFNetAPIClient.h"
#import "YTKKeyValueStore.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MFAppHelper.h"

#define PATH_OF_NetWork    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define NoNetworkCode -1001
#define NoNetworkDomain @"网络出走了~"

typedef NS_ENUM(NSUInteger, YWNetworkStatus) {
    YWNetworkStatusUnknown,  //未知的网络
    YWNetworkStatusNotNetWork, //没有网络
    YWNetworkStatusReachableViaWWAN,//手机蜂窝数据网络
    YWNetworkStatusReachableViaWiFi //WIFI 网络
};

@interface MFNetAPIClient()
@property (nonatomic, strong) NSMutableDictionary *dataTaskdict;
@property (nonatomic, strong) NSNumber *recordedRequestId;
@end


@implementation MFNetAPIClient

- (NSNumber *)generateRequestId
{
    if (_recordedRequestId == nil) {
        _recordedRequestId = @(1);
    } else {
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            _recordedRequestId = @(1);
        } else {
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
        }
    }
    return _recordedRequestId;
}

- (NSMutableDictionary *)dataTaskdict{
    
    if (_dataTaskdict == nil) {
        _dataTaskdict = [NSMutableDictionary dictionary];
    }
    return _dataTaskdict;
}

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


static NSString *const  httpCache = @"MFNetworkCache";
static YTKKeyValueStore *_store;
static YWNetworkStatus  _status;
static BOOL    _isHasNetWork;

static MFNetAPIClient *manager = nil;
static dispatch_once_t onceToken;

#pragma mark - 单例方法
+ (MFNetAPIClient*)sharedTools {
    
    dispatch_once(&onceToken, ^{
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        manager = [MFNetAPIClient manager];
        //设置返回数据为json
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer.stringEncoding  = NSUTF8StringEncoding;
        manager.requestSerializer.timeoutInterval = 10.f;
        // 设置当前 instance 的可接受类型
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    });
    return manager;
}

/**
 监测网络状态 (在程序入口，调用一次即可)
 */
+(void)startMonitoringNetworkStatus
{
    _isHasNetWork = YES;

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                _isHasNetWork = NO;
                _status = YWNetworkStatusUnknown;
                //未知网络
                [MBProgressHUD showError:@"网络连接失败，请检查网络"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                _isHasNetWork = NO;
                _status = YWNetworkStatusNotNetWork;
                //无法联网
                [MBProgressHUD showError:@"网络连接失败，请检查网络"];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                _isHasNetWork = YES;
                _status = YWNetworkStatusReachableViaWWAN;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                _isHasNetWork = YES;
                _status = YWNetworkStatusReachableViaWiFi;
                NSLog(@"无线信号");
                break;
        }
        //暂时不适用AFN的请求
       //[[NSNotificationCenter defaultCenter] postNotificationName:kRAFNChangedNotification object:nil];
    }];
    [manager startMonitoring];
}


//判断是否联网
+ (BOOL)isNetReachable{
    return [self isWifiOn] || [self isWWanReachable];
}
//是否在无线状态下
+ (BOOL)isWifiOn{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}
//是否在手机信号状态下
+ (BOOL)isWWanReachable{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN;
}



/**
 设置 请求和响应类型和超时时间
 
 @param requestType  默认为请求类型为JSON格式
 @param responseType 默认响应格式为JSON格式
 @param timeOut      请求超时时间 默认为20秒
 */
+(void)setTimeOutWithTime:(NSTimeInterval)timeOut
              requestType:(YWRequestSerializer)requestType
             responseType:(YWResponseSerializer)responseType
{
    
    MFNetAPIClient *httpMethod  = [MFNetAPIClient sharedTools];
    httpMethod.requestSerializer.timeoutInterval = timeOut;
    switch (requestType) {
        case YWRequestSerializerJSON:
            httpMethod.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case YWRequestSerializerPlainText:
            httpMethod.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        default:
            break;
    }
    switch (responseType) {
        case YWResponseSerializerJSON:
            httpMethod.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        case YWResponseSerializerHTTP:
            httpMethod.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case YWResponseSerializerXML:
            httpMethod.responseSerializer = [AFXMLParserResponseSerializer serializer];
        default:
            break;
    }
}
/**
 设置 请求头
 
 @param httpBody 根据服务器要求 配置相应的请求体
 */
+ (void)setHttpBodyWithDic:(NSDictionary *)httpBody
{
    MFNetAPIClient *httpMethod = [MFNetAPIClient sharedTools];
    for (NSString *key in httpBody.allKeys) {
        if (httpBody[key] != nil) {
            [httpMethod.requestSerializer setValue:httpBody[key] forHTTPHeaderField:key];
        }
    }
}


/**
 获取当前的网络状态
 @return YES 有网  NO 没有联网
 */
+(BOOL)getCurrentNetWorkStatus
{
    return _isHasNetWork;
}

#pragma mark -  /**************GET 请求API ******************/
#pragma mark - GET请求
+ (MFNetAPIClient *)getWithUrl:(NSString *)url
                  refreshCache:(BOOL)refreshCache
                       success:(void(^)(id responseObject))success
                          fail:(void(^)(NSError *error))fail
{
    return [self getWithUrl:url refreshCache:refreshCache params:nil success:success fail:fail];
}
#pragma mark - GET请求带params参数
+ (MFNetAPIClient *)getWithUrl:(NSString *)url
                  refreshCache:(BOOL)refreshCache
                        params:(NSDictionary *)params
                       success:(void(^)(id responseObject))success
                          fail:(void(^)(NSError *error))fail
{
    return [self getWithUrl:url refreshCache:refreshCache params:params progress:nil success:success fail:fail];
}
#pragma mark - GET请求带进度回调
+ (MFNetAPIClient *)getWithUrl:(NSString *)url
                  refreshCache:(BOOL)refreshCache
                        params:(NSDictionary *)params
                      progress:(void(^)(int64_t bytesRead, int64_t totalBytesRead))progress
                       success:(void(^)(id responseObject))success
                          fail:(void(^)(NSError *error))fail
{
    
    if (!url) return nil;
    
    _store = [[YTKKeyValueStore alloc] initDBWithName:httpCache];
    [_store createTableWithName:httpCache];
    MFNetAPIClient *request = nil;
    
    NSURLSessionDataTask *dataTask;
    NSNumber *requestId = [MFNetAPIClient sharedTools].recordedRequestId;
    
    if ([[MFAppHelper sharedInstance] isReachable]) {//有网络操作
        if (!refreshCache) {
            [self requestNotCacheWithHttpMethod:0 url:url params:params progress:progress success:success fail:fail];
        }else {
            NSDictionary *dict = [_store getObjectById:url  fromTable:httpCache];
            if (dict) {
                success(dict);
            }else {
             dataTask = [[MFNetAPIClient sharedTools] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //缓存返回的数据
                    [_store putObject:responseObject withId:url intoTable:httpCache];
                    NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedTools].dataTaskdict[requestId];
                    if (storedTask == nil) {
                        success?success(nil):nil;
                        return;// 如果这个operation是被cancel的，那就不用处理回调了。
                    }
                    //保存此次操作
                    [[MFNetAPIClient sharedTools].dataTaskdict removeObjectForKey:requestId];
                    //返回数据
                    success?success(responseObject):nil;
                    NSLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",url,params,responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedTools].dataTaskdict[requestId];
                    if (storedTask == nil) return;
                    [[MFNetAPIClient sharedTools].dataTaskdict removeObjectForKey:requestId];
                    
                    fail?fail(error):nil;
                    NSLog(@"error = %@",error.description);
                }];
            }
        }
    } else {//无网络操作
        NSDictionary *dict = [_store getObjectById:url  fromTable:httpCache];
        if (dict) {
            success(dict);
        }else {
            [MBProgressHUD showError:@"网络请求错误，请检查网络设置"];
            NSLog(@"当前为无网络状态，本地也没有缓存数据");
        }
    }
    return request;
}



#pragma mark - /*********************** POST 请求API **********************/

#pragma mark - POST请求带params参数
+ (MFNetAPIClient *)postWithUrl:(NSString *)url
                        refreshCache:(BOOL)refreshCache
                              params:(NSDictionary *)params
                             success:(void(^)(id responseObject))success
                                fail:(void(^)(NSError *error))fail
{
    return [self postWithUrl:url refreshCache:refreshCache params:params progress:nil success:success fail:fail];
}
#pragma mark - POST请求带进度
+ (MFNetAPIClient *)postWithUrl:(NSString *)url
                        refreshCache:(BOOL)refreshCache
                              params:(NSDictionary *)params
                            progress:(void(^)(int64_t bytesRead, int64_t totalBytesRead))progress
                             success:(void(^)(id responseObject))success
                                fail:(void(^)(NSError *error))fail
{
    MFNetAPIClient *request = nil;
    
    NSURLSessionDataTask *dataTask;
    NSNumber *requestId = [MFNetAPIClient sharedTools].recordedRequestId;
    
    if ([MFNetAPIClient getCurrentNetWorkStatus]) {
        if (!refreshCache) {
            [self requestNotCacheWithHttpMethod:1 url:url params:params progress:progress success:success fail:fail];
        }else {
            NSDictionary *dict =   [_store getObjectById:url  fromTable:httpCache];
            if (dict) {
                success(dict);
            }else {
              dataTask = [[MFNetAPIClient sharedTools] POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                    progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //缓存返回的数据
                    [_store putObject:responseObject withId:url intoTable:httpCache];
                    NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedTools].dataTaskdict[requestId];
                    if (storedTask == nil) {
                        success?success(nil):nil;
                        return;// 如果这个operation是被cancel的，那就不用处理回调了。
                    }
                    //保存此次操作
                    [[MFNetAPIClient sharedTools].dataTaskdict removeObjectForKey:requestId];
                    //返回数据
                    success?success(responseObject):nil;
                    NSLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",url,params,responseObject);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedTools].dataTaskdict[requestId];
                    if (storedTask == nil) return;
                    [[MFNetAPIClient sharedTools].dataTaskdict removeObjectForKey:requestId];
                    
                    fail?fail(error):nil;
                    NSLog(@"error = %@",error.description);
                }];
            }
        }
    } else {
        NSDictionary *dict =  [_store getObjectById:url  fromTable:httpCache];
        if (dict) {
            success(dict);
        }else {
            [MBProgressHUD showError:@"网络请求错误，请检查网络设置"];
            NSLog(@"当前为无网络状态，本地也没有缓存数据");
            NSError *error =  [NSError errorWithDomain:NoNetworkDomain code:NoNetworkCode userInfo:nil];
            fail?fail(error):nil;
            return nil;
        }
    }
    
    [MFNetAPIClient sharedTools].dataTaskdict[requestId] = dataTask;
    
    return request;
}



#pragma mark - 不需要缓存的网络请求API
+ (void)requestNotCacheWithHttpMethod:(NSInteger)httpMethod
                                  url:(NSString *)url
                               params:(NSDictionary *)params
                             progress:(void(^)(int64_t bytesRead, int64_t totalBytesRead))progress
                              success:(void(^)(id responseObject))success
                                 fail:(void(^)(NSError *error))fail
{
    NSURLSessionDataTask *dataTask;
    NSNumber *requestId = [MFNetAPIClient sharedTools].recordedRequestId;
    
    if (httpMethod == 0) {
       dataTask =  [[MFNetAPIClient sharedTools]   GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
            //缓存返回的数据
            [_store putObject:responseObject withId:url intoTable:httpCache];
            NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedTools].dataTaskdict[requestId];
            if (storedTask == nil) {
                success?success(nil):nil;
                return;// 如果这个operation是被cancel的，那就不用处理回调了。
            }
            //保存此次操作
            [[MFNetAPIClient sharedTools].dataTaskdict removeObjectForKey:requestId];
            //返回数据
            success?success(responseObject):nil;
            NSLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",url,params,responseObject);

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedTools].dataTaskdict[requestId];
            if (storedTask == nil) return;
            [[MFNetAPIClient sharedTools].dataTaskdict removeObjectForKey:requestId];
            
            fail?fail(error):nil;
            NSLog(@"error = %@",error.description);
        }];
    }else {
       dataTask =  [[MFNetAPIClient sharedTools]  POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          
            //缓存返回的数据
            [_store putObject:responseObject withId:url intoTable:httpCache];
            NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedTools].dataTaskdict[requestId];
            if (storedTask == nil) {
                success?success(nil):nil;
                return;// 如果这个operation是被cancel的，那就不用处理回调了。
            }
            //保存此次操作
            [[MFNetAPIClient sharedTools].dataTaskdict removeObjectForKey:requestId];
            //返回数据
            success?success(responseObject):nil;
            NSLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",url,params,responseObject);

            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedTools].dataTaskdict[requestId];
            if (storedTask == nil) return;
            [[MFNetAPIClient sharedTools].dataTaskdict removeObjectForKey:requestId];
            
            fail?fail(error):nil;
            NSLog(@"error = %@",error.description);
        }];
    }
}

#pragma mark - 取消对应Id的网络方法
- (void)cancelRequestWithRequestID:(NSNumber *)requestID{
    
    if (requestID == nil) return;
    NSURLSessionDataTask *task = self.dataTaskdict[requestID];
    [task cancel];
    [self.dataTaskdict removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList{
    
    for (NSNumber *requestId in requestIDList) {
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark ----- private method
- (void)removeCompletedRequest:(NSNumber *)requestID{
    
    NSURLSessionDataTask *task = self.dataTaskdict[requestID];
    [task cancel];
    [self.dataTaskdict removeObjectForKey:requestID];
}


/**
 获取网络缓存 文件大小
 @return size  单位M
 */
+ (NSString *)fileSizeWithDBPath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[PATH_OF_NetWork stringByAppendingPathComponent:httpCache]]){
        unsigned  long long  fileSize =  [[manager attributesOfItemAtPath:[PATH_OF_NetWork stringByAppendingPathComponent:httpCache] error:nil] fileSize];
        NSString *size = [NSString stringWithFormat:@"%.2fM",fileSize/1024.0/1024.0];
        return  size;
    }else {
        return @"0M";
    }
    return 0;
}

/**
 清除所有网络缓存
 */
+ (void)cleanNetWorkRefreshCache
{
    NSError *error;
    BOOL isSuccess =  [[NSFileManager defaultManager]removeItemAtPath:[PATH_OF_NetWork stringByAppendingPathComponent:httpCache] error:&error];
    if (isSuccess) {
        NSLog(@"clean cache file is success");
    }else {
        if ([PATH_OF_NetWork stringByAppendingPathComponent:httpCache]) {
            NSLog(@"error:%@",error.description);
        }else {
            NSLog(@"error: cache file is not exist");
        }
        
    }
}


@end
