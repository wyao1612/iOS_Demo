//
//  CommonViewModel.m
//  MissF
//
//  Created by wyao on 2017/7/14.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "commonViewModel.h"

@implementation commonViewModel



static YTKKeyValueStore *_store;
static commonViewModel *shareBaseManager = nil;
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
    return [commonViewModel shareInstance] ;
}

-(instancetype) copyWithZone:(struct _NSZone *)zone{
    return [commonViewModel shareInstance] ;
}
-(instancetype) mutablecopyWithZone:(NSZone *)zone
{
    return [commonViewModel shareInstance] ;
}

/** 只有置成0,GCD才会认为它从未执行过.它默认为0.
 这样才能保证下次再次调用shareInstance的时候,再次创建对象.
 */
+(void)attempDealloc{
    onceToken = 0;
    shareBaseManager = nil;
}


-(MFCommonModel*)getCommonModelFromCache{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[MFUserDefault objectForKey:@"currentAPI"],kcommonUrl];
    NSDictionary *dict = [_store getObjectById:urlString  fromTable:httpCache];
    if (dict) {
        MFCommonModel *model = [MFCommonModel  mj_objectWithKeyValues:dict[@"data"][@"common"]];
        //NSLog(@"%@",model);
        return model;
    }
    
    return nil;
}



- (void)postCommonDataSuccess:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure{
    
    [[MFNetAPIClient sharedInstance] postWithUrl:kcommonUrl refreshCache:YES params:nil success:^(id responseObject) {
        if ([responseObject[@"code"] isEqualToString:@"200"]) {
            MFCommonModel *model = [MFCommonModel  mj_objectWithKeyValues:responseObject[@"data"][@"common"]];
            responSuccess(model);
        }else{
            responFailure([responseObject[@"code"] integerValue], responseObject[@"message"]);
        }
    } fail:^(NSError *error) {
        responFailure(0, [NSString analyticalHttpErrorDescription:error]);
    }];
}


@end
