//
//  BaseObject.h
//  GolfIOS
//
//  Created by 张永亮 on 2016/10/24.
//  Copyright © 2016年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject
@property(nonatomic,strong) NSNumber *errorCode;        //错误码
@property(nonatomic,copy) NSString *errorMsg;           //错误信息
@end
