//
//  NSObject+url.m
//  iOS_demo
//
//  Created by wyao on 2017/7/5.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "NSObject+params.h"

@implementation NSObject (params)
// 将要给后台的参数 进行升序排列(字典的key)
+ (NSMutableDictionary *)KeyWithParams:(NSDictionary*)params{
    
    //创建
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:params];
    
    //添加AppKey
    [dictionary setObject:MFApp_key forKey:@"appKey"];
    
    //添加accessToken
    NSString *accessToken = [NSString readUserFromDiskWithAccount:ACCESSTOKEN];
    if (![NSString iSBlankString:accessToken]) {
       [dictionary setObject:accessToken forKey:@"accessToken"];
    }
    
    //获取当前时间
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970];
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    [dictionary setObject:curTime forKey:@"time"];
    
    
    NSMutableArray *tempArray = [NSMutableArray array];
    //1. 将请求参数格式化为“key=value”格式，即“k1=v1”、“k2=v2”、“k3=v3”;
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *temString = [NSString stringWithFormat:@"%@=%@",key,obj];
        [tempArray addObject:temString];
    }];
    //NSLog(@"升序前的数组----->tempArray=%@",tempArray);
    
    // 2. 将格式化好的参数键值对以字典序升序排列后，拼接在一起，即“k1=v1k2=v2k3=v3”;
    NSArray * keyArr = [tempArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        //NSLog(@"%@%@",obj1,obj2);
        return [obj1 compare:obj2];
    }];
    //NSLog(@"升序后的数组----->keyArr=%@",keyArr);
    NSString *appendString = [keyArr componentsJoinedByString:@""];
    NSLog(@"升序后的数组拼接的字符串----->%@",appendString);
    
    //3. 在拼接好的字符串末尾追加上应用通过OAuth2.0协议获取Access Token时所获取到的AppSecret参数值 再取MD5
    NSString * keyString = [NSString stringWithFormat:@"%@",MFApp_Secret];
    NSLog(@"拼接App_Secret得到的签名字符串----->%@",[appendString stringByAppendingString:keyString]);
    
    keyString = [[appendString stringByAppendingString:keyString] MD5Hash];
    NSLog(@"得到的签名字符串MD5值----->%@",keyString);
    
    //添加签名
    [dictionary setObject:keyString forKey:@"sign"];

    
    return dictionary;
}
@end
