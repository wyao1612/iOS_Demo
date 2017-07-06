//
//  YWCountDownManger.h
//  WSD
//
//  Created by wyao on 2017/4/14.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YWCountDownDelegate <NSObject>

@optional
-(void)YWCountDownDelegateMiaoshaTime:(NSString*)timeString;
@end


@interface YWCountDown : NSString

/**
 秒杀配置项

 @param MiaoSha 从后台接收的秒杀时间
 */
- (void)countDownConfigWithMiaoShaString:(NSString*)MiaoSha;
@property(assign,nonatomic) id<YWCountDownDelegate> delegate;
@end
