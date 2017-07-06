//
//  userViewModel.m
//  MissF
//
//  Created by wyao on 2017/7/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "userViewModel.h"
#import <YTKKeyValueStore/YTKKeyValueStore.h>


@implementation userViewModel



static YTKKeyValueStore *_store;
static userViewModel *shareBaseManager = nil;
static dispatch_once_t onceToken ;


+(instancetype) shareInstance{
    dispatch_once(&onceToken, ^{
        shareBaseManager = [[super allocWithZone:NULL] init];
    }) ;
    return shareBaseManager ;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _store = [[YTKKeyValueStore alloc] initDBWithName:MFLocalCache];
        [_store createTableWithName:MFLocalCache];
    }
    return self;
}

+(instancetype) allocWithZone:(struct _NSZone *)zone{
    return [userViewModel shareInstance] ;
}

-(instancetype) copyWithZone:(struct _NSZone *)zone{
    return [userViewModel shareInstance] ;
}
-(instancetype) mutablecopyWithZone:(NSZone *)zone
{
    return [userViewModel shareInstance] ;
}

/** 只有置成0,GCD才会认为它从未执行过.它默认为0.
 这样才能保证下次再次调用shareInstance的时候,再次创建对象.
 */
+(void)attempDealloc{
    onceToken = 0;
    shareBaseManager = nil;
}


-(void)getUserModelFromCache{
    //缓存返回的数据
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[MFUserDefault objectForKey:@"currentAPI"],kPostLogin];
    NSDictionary *dict = [_store getObjectById:urlString  fromTable:httpCache];
    if (dict) {
        MFUserModel *model = [MFUserModel  mj_objectWithKeyValues:dict[@"data"][@"userInfo"]];
        NSLog(@"%@",model);
    }
}

@end
