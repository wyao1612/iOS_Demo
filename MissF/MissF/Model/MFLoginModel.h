//
//  MFLoginModel.h
//  iOS_demo
//
//  Created by wyao on 2017/7/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseObject.h"
#import "MFUserModel.h"
#import "MFOAuthModel.h"


@interface MFLoginModel : BaseObject
@property(strong,nonatomic) MFUserModel*  userInfo;
@property(strong,nonatomic) MFOAuthModel* oauth;
@end
