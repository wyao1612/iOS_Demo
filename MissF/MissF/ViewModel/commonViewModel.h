//
//  CommonViewModel.h
//  MissF
//
//  Created by wyao on 2017/7/14.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commonViewModel : NSObject
+(instancetype) shareInstance;
-(MFCommonModel*)getCommonModelFromCache;
- (void)postCommonDataSuccess:(OBJBlock)responSuccess failure:(ERRORCODEBlock)responFailure;
@end
