//
//  MFUserModel.h
//  iOS_demo
//
//  Created by wyao on 2017/7/6.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "BaseObject.h"

@interface MFUserModel : BaseObject
@property(copy,nonatomic) NSString* ID;
@property(copy,nonatomic) NSString* username;
@property(copy,nonatomic) NSString* avatar;
@property(copy,nonatomic) NSString* created;
@property(copy,nonatomic) NSString* updated;
@property(copy,nonatomic) NSString* headline;
@end
