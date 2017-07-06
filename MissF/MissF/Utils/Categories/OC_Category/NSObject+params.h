//
//  NSObject+url.h
//  iOS_demo
//
//  Created by wyao on 2017/7/5.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (params)
/** 将要给后台的参数 进行升序排列(字典的key)*/
+ (NSMutableDictionary *)KeyWithParams:(NSDictionary*)params;
@end
