//
//  userViewModel.h
//  MissF
//
//  Created by wyao on 2017/7/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseObject.h"
#import "MFUserModel.h"

@interface userViewModel : BaseObject
+(instancetype) shareInstance;
@property(nonatomic,strong) MFUserModel *userModel;
@property(copy,nonatomic) NSString* global_key;
-(void)getUserModelFromCache;
@end
