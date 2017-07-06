//
//  MFOAuthModel.h
//  iOS_demo
//
//  Created by wyao on 2017/7/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseObject.h"

@interface MFOAuthModel : BaseObject
@property(copy,nonatomic) NSString* uid;
@property(copy,nonatomic) NSString* accessToken;
@property(copy,nonatomic) NSString* refreshToken;
@property(copy,nonatomic) NSString* accessExpires;
@property(copy,nonatomic) NSString* refreshExpires;
@end
