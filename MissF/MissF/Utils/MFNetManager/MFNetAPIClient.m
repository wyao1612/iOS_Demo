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
#import "UIImage+CompressImage.h"
#import "HXPhotoModel.h"

#define PATH_OF_NetWork   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
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
@property (nonatomic, strong) AFHTTPSessionManager *manager;
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

//static NSString *const  httpCache = @"MFNetworkCache";
static YTKKeyValueStore *_store;
static YWNetworkStatus  _status;
static BOOL    _isHasNetWork;

#pragma mark - 单例方法

+ (instancetype)sharedInstance{
    
    static MFNetAPIClient *_MFNetAPIClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _MFNetAPIClient = [[MFNetAPIClient alloc] init];
    });
    return _MFNetAPIClient;
}

- (id)init{
    self = [super init];
    if (self) {
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        _manager = [AFHTTPSessionManager manager];
        //设置返回数据为json
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.requestSerializer.stringEncoding  = NSUTF8StringEncoding;
        _manager.requestSerializer.timeoutInterval = 10;
        // 设置当前 instance 的可接受类型
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    }
    return self;
}

/**
 监测网络状态 (在程序入口，调用一次即可)
 */
-(void)startMonitoringNetworkStatus
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
- (BOOL)isNetReachable{
    return [self isWifiOn] || [self isWWanReachable];
}
//是否在无线状态下
- (BOOL)isWifiOn{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWiFi;
}
//是否在手机信号状态下
- (BOOL)isWWanReachable{
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusReachableViaWWAN;
}



/**
 设置 请求和响应类型和超时时间
 
 @param requestType  默认为请求类型为JSON格式
 @param responseType 默认响应格式为JSON格式
 @param timeOut      请求超时时间 默认为20秒
 */
-(void)setTimeOutWithTime:(NSTimeInterval)timeOut
              requestType:(YWRequestSerializer)requestType
             responseType:(YWResponseSerializer)responseType
{
    
    AFHTTPSessionManager *httpMethod = [MFNetAPIClient sharedInstance].manager;
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
- (void)setHttpBodyWithDic:(NSDictionary *)httpBody
{
    AFHTTPSessionManager *httpMethod = [MFNetAPIClient sharedInstance].manager;
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
-(BOOL)getCurrentNetWorkStatus
{
    return _isHasNetWork;
}

#pragma mark -  **************GET 请求API ******************
#pragma mark - GET请求
- (void)getWithUrl:(NSString *)url
                  refreshCache:(BOOL)refreshCache
                       success:(void(^)(id responseObject))success
                          fail:(void(^)(NSError *error))fail
{
     [self getWithUrl:url refreshCache:refreshCache params:nil success:success fail:fail];
}
#pragma mark - GET请求带params参数
- (void)getWithUrl:(NSString *)url
                  refreshCache:(BOOL)refreshCache
                        params:(NSDictionary *)params
                       success:(void(^)(id responseObject))success
                          fail:(void(^)(NSError *error))fail
{
     [self getWithUrl:url refreshCache:refreshCache params:params progress:nil success:success fail:fail];
}
#pragma mark - GET请求带进度回调
- (void)getWithUrl:(NSString *)url
                  refreshCache:(BOOL)refreshCache
                        params:(NSDictionary *)params
                      progress:(void(^)(int64_t bytesRead, int64_t totalBytesRead))progress
                       success:(void(^)(id responseObject))success
                          fail:(void(^)(NSError *error))fail
{
    
    if (!url) return;
    
    if ([[MFAppHelper sharedInstance] isReachable]) {//有网络操作
        [self requestWithHttpMethod:GET refreshCache:refreshCache url:url params:params progress:progress success:success fail:fail];
    } else {//无网络操作
        NSDictionary *dict = [_store getObjectById:url  fromTable:httpCache];
        if (dict) {
            success(dict);
        }else {
            [MBProgressHUD showError:@"网络请求错误，请检查网络设置"];
            NSLog(@"当前为无网络状态，本地也没有缓存数据");
        }
    }
}



#pragma mark - /*********************** POST 请求API **********************/

#pragma mark - POST请求带params参数
- (void)postWithUrl:(NSString *)url
                   refreshCache:(BOOL)refreshCache
                         params:(NSDictionary *)params
                        success:(void(^)(id responseObject))success
                           fail:(void(^)(NSError *error))fail
{
     [self postWithUrl:url refreshCache:refreshCache params:params progress:nil success:success fail:fail];
}
#pragma mark - POST请求带进度
- (void)postWithUrl:(NSString *)url
                   refreshCache:(BOOL)refreshCache
                         params:(NSDictionary *)params
                       progress:(void(^)(int64_t bytesRead, int64_t totalBytesRead))progress
                        success:(void(^)(id responseObject))success
                           fail:(void(^)(NSError *error))fail
{
  
    NSURLSessionDataTask *dataTask;
    NSNumber *requestId = [[MFNetAPIClient sharedInstance] generateRequestId];
    
    if ([self getCurrentNetWorkStatus]) {
        [self requestWithHttpMethod:POST refreshCache:refreshCache url:url params:params progress:progress success:success fail:fail];
    } else {
        NSDictionary *dict =  [_store getObjectById:url  fromTable:httpCache];
        if (dict) {
            success(dict);
        }else {
            [MBProgressHUD showError:@"网络请求错误，请检查网络设置"];
            NSLog(@"当前为无网络状态，本地也没有缓存数据");
            NSError *error =  [NSError errorWithDomain:NoNetworkDomain code:NoNetworkCode userInfo:nil];
            fail?fail(error):nil;
        }
    }
    
    [MFNetAPIClient sharedInstance].dataTaskdict[requestId] = dataTask;
    
}



#pragma mark - 不需要缓存的网络请求API
- (void)requestWithHttpMethod:(YWRequestType)httpMethod
                 refreshCache:(BOOL)refreshCache
                          url:(NSString *)url
                       params:(NSDictionary *)params
                     progress:(void(^)(int64_t bytesRead, int64_t totalBytesRead))progress
                      success:(void(^)(id responseObject))success
                         fail:(void(^)(NSError *error))fail
{
    
    //任务初始化
    NSURLSessionDataTask *dataTask = nil;
    NSNumber *requestId = [[MFNetAPIClient sharedInstance] generateRequestId];
    //缓存初始化
    _store = [[YTKKeyValueStore alloc] initDBWithName:httpCache];
    [_store createTableWithName:httpCache];
    //参数签名
    params =  [NSObject KeyWithParams:params];
    //拼接地址
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[MFUserDefault objectForKey:@"currentAPI"],url];
    
    if (httpMethod == GET) {
        
        dataTask =  [[MFNetAPIClient sharedInstance].manager   GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (refreshCache == YES) {
                [_store putObject:responseObject withId:urlString intoTable:httpCache];
            }
            
            
            NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedInstance].dataTaskdict[requestId];
            if (storedTask == nil) {
                success?success(nil):nil;
                return;// 如果这个operation是被cancel的，那就不用处理回调了。
            }
            
            [[MFNetAPIClient sharedInstance].dataTaskdict removeObjectForKey:requestId];
            success?success(responseObject):nil;
            NSLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",url,params,responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedInstance].dataTaskdict[requestId];
            if (storedTask == nil) return;
            [[MFNetAPIClient sharedInstance].dataTaskdict removeObjectForKey:requestId];
            
            fail?fail(error):nil;
            NSLog(@"error = %@",error.description);
        }];
    }else  if (httpMethod == POST){
        dataTask =  [[MFNetAPIClient sharedInstance].manager  POST:urlString parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            //NSLog(@"uploadProgress:%f",uploadProgress.fractionCompleted);
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (refreshCache == YES) {
                [_store putObject:responseObject withId:urlString intoTable:httpCache];
            }
            
            NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedInstance].dataTaskdict[requestId];
            if (storedTask == nil) {
                success?success(nil):nil;
                return;// 如果这个operation是被cancel的，那就不用处理回调了。
            }

            [[MFNetAPIClient sharedInstance].dataTaskdict removeObjectForKey:requestId];
            success?success(responseObject):nil;
            //NSLog(@"\nRequest success, URL: %@\n params:%@\n response:%@\n\n",url,params,responseObject);

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedInstance].dataTaskdict[requestId];
            if (storedTask == nil) return;
            [[MFNetAPIClient sharedInstance].dataTaskdict removeObjectForKey:requestId];
            
            fail?fail(error):nil;
            //NSLog(@"error = %@",error.description);
        }];
    }
    
    if (dataTask) {
       [MFNetAPIClient sharedInstance].dataTaskdict[requestId] = dataTask;
    }
    
}



- (NSURLSessionDataTask *)uploadImageWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                       ImageArray:(NSArray *)imageArray
                                     SuccessBlock:(OBJBlock)successBlock
                                      FailurBlock:(ERRORCODEBlock)failureBlock
                                   UpLoadProgress:(UploadProgress)progress
{
    if (urlString == nil)
    {
        return nil;
    }
    weak(self);

    //参数签名
    parameters =  [NSObject KeyWithParams:parameters];
    
    /*! 检查地址中是否有中文 */
//    NSString *URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
    //拼接地址
    urlString = [NSString stringWithFormat:@"%@%@",[MFUserDefault objectForKey:@"currentAPI"],urlString];
    
    NSLog(@"******************** 请求参数 ***************************");
    NSLog(@"请求头: %@\n请求方式: %@\n请求URL: %@\n请求param: %@\n\n",[MFNetAPIClient sharedInstance].manager.requestSerializer.HTTPRequestHeaders, @"POST",urlString, parameters);
    NSLog(@"******************************************************");
    
    
    NSURLSessionDataTask *sessionTask = nil;
    NSNumber *requestId = [[MFNetAPIClient sharedInstance] generateRequestId];
    sessionTask = [[MFNetAPIClient sharedInstance].manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        /*! 出于性能考虑,将上传图片进行压缩 */
        [imageArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            /*! image的压缩方法 */
            UIImage *resizedImage;
            /*! 此处是使用原生系统相册 */
            if([obj isKindOfClass:[ALAsset class]])
            {
                // 用ALAsset获取Asset URL  转化为image
                ALAssetRepresentation *assetRep = [obj defaultRepresentation];
                
                CGImageRef imgRef = [assetRep fullResolutionImage];
                resizedImage = [UIImage imageWithCGImage:imgRef
                                                   scale:1.0
                                             orientation:(UIImageOrientation)assetRep.orientation];
                // imageWithImage
                NSLog(@"1111-----size : %@",NSStringFromCGSize(resizedImage.size));
                
                resizedImage = [weakSelf imageWithImage:resizedImage scaledToSize:resizedImage.size];
                NSLog(@"2222-----size : %@",NSStringFromCGSize(resizedImage.size));
            }
            else if([obj isKindOfClass:[HXPhotoModel class]])
            {
                /*! 此处是使用其他第三方相册，可以自由定制压缩方法 */
                HXPhotoModel *model = (HXPhotoModel*)obj;
                resizedImage = model.thumbPhoto;
            }
            
            /*! 此处压缩方法是jpeg格式是原图大小的0.8倍，要调整大小的话，就在这里调整就行了还是原图等比压缩 */
            NSData *imgData = UIImageJPEGRepresentation(resizedImage, 1);
            
            /*! 图片添加标识名称*/
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString* filename = [NSString stringWithFormat:@"%@.png",str];
            
            NSDictionary *dic =   [self getExifInfoWithImageData:imgData];
            NSLog(@"图片exif信息-----》%@",dic);
            /*! 拼接data */
            if (imgData != nil)
            {   // 图片数据不为空才传递 fileName
                [formData appendPartWithFileData:imgData name:@"file[]" fileName:filename mimeType:@"image/png"];
            }
            
        }];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //NSLog(@"上传进度--%lld,总进度---%lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
        if (progress)
        {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"上传图片成功 = %@",responseObject);
        
        NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedInstance].dataTaskdict[requestId];
        if (storedTask == nil) {
            successBlock?successBlock(nil):nil;
            return;// 如果这个operation是被cancel的，那就不用处理回调了。
        }
        [[MFNetAPIClient sharedInstance].dataTaskdict removeObjectForKey:requestId];
        
        if (successBlock){
            successBlock(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSURLSessionDataTask *storedTask = [MFNetAPIClient sharedInstance].dataTaskdict[requestId];
        if (storedTask == nil) return;
        [[MFNetAPIClient sharedInstance].dataTaskdict removeObjectForKey:requestId];
        if (failureBlock){
            failureBlock(error.code,[NSString analyticalHttpErrorDescription:error]);
        }
    }];
    
    if (sessionTask)
    {
        [MFNetAPIClient sharedInstance].dataTaskdict[requestId] = sessionTask;
    }
    return sessionTask;
}

- (NSMutableDictionary *)getExifInfoWithImageData:(NSData *)imageData{
    CGImageSourceRef cImageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    NSDictionary *dict =  (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(cImageSource, 0, NULL));
    NSMutableDictionary *dictInfo = [NSMutableDictionary dictionaryWithDictionary:dict];
    return dictInfo;
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
- (NSString *)fileSizeWithDBPath
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
- (void)cleanNetWorkRefreshCache
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

- (NSString *)strUTF8Encoding:(NSString *)str
{
    /*! ios9适配的话 打开第一个 */
    //return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

/*! 对图片尺寸进行压缩 */
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    if (newSize.height > 375/newSize.width*newSize.height)
    {
        newSize.height = 375/newSize.width*newSize.height;
    }
    
    if (newSize.width > 375)
    {
        newSize.width = 375;
    }
    
    UIImage *newImage = [UIImage needCenterImage:image size:newSize scale:1.0];
    
    return newImage;
}


@end
