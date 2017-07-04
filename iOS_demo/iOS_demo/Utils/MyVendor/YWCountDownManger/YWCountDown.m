//
//  YWCountDownManger.m
//  WSD
//
//  Created by wyao on 2017/4/14.
//  Copyright © 2017年 Tsou. All rights reserved.
//

#import "YWCountDown.h"
#include <sys/sysctl.h>

@interface YWCountDown ()
@property(nonatomic,retain) dispatch_source_t timer;
@property(nonatomic,assign) NSTimeInterval systemUpTime;
@property(nonatomic,assign) NSTimeInterval intervalTime;
@property(nonatomic,strong) NSString* countDown;
@end

@implementation YWCountDown


/**
 *  每秒回调一次
 */
-(void)countDownWithPER_SECBlock:(void (^)())PER_SECBlock
{
    if (_timer==nil) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                PER_SECBlock();
            });
        });
        dispatch_resume(_timer);
    }
}
/**
 *  主动销毁定时器
 *
 */
-(void)destoryTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}


#pragma mark - 通知监听
/**
 *  添加通知
 */
- (void)addNotification
{
    //监听是否触发home键挂起程序.(当有电话进来或者锁屏)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification object:nil];
    //程序重新激活
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

/**
 *  移除通知
 */
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}



- (void)applicationWillResignActive:(NSNotification *)notification
{
    self.systemUpTime = [self uptimeSinceLastBoot];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification
{
    NSTimeInterval currentupTime = [self uptimeSinceLastBoot];
    NSTimeInterval intervalTime = currentupTime - self.systemUpTime;
    if (intervalTime > 0) {
        self.intervalTime = intervalTime;
    }
}


#pragma mark -  系统当前运行了多长时间
-(NSTimeInterval)uptimeSinceLastBoot
{
    //获取当前设备时间时间戳 受用户修改时间影响
    struct timeval now;
    struct timezone tz;
    gettimeofday(&now, &tz);
    NSLog(@"当前设备时间时间戳--->gettimeofday: %ld", now.tv_sec);
    
    //获取系统上次重启的时间戳 受用户修改时间影响
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    
    double uptime = -1;
    
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0)
    {
        NSLog(@"系统上次重启的时间戳--->gettimeofday: %ld", boottime.tv_sec);
        //因为两个参数都会受用户修改时间的影响，因此它们想减的值是不变的
        uptime = now.tv_sec - boottime.tv_sec;
        uptime += (double)(now.tv_usec - boottime.tv_usec) / 1000000.0;
    }
    return uptime;
}


#pragma mark -  秒杀逻辑
- (void)countDownConfigWithMiaoShaString:(NSString*)MiaoSha
{
    if (![NSString iSBlankString:MiaoSha]) {
        if ([NSString iSBlankString:self.countDown]) {
            [self destoryTimer];
        }
        self.countDown = [NSString string];
        //后台传过来的剩余时间
        __block long remainTime = MiaoSha.longLongValue / 1000;
        __weak typeof(self) weakSelf = self;
        if (remainTime == 0) {
            return;
        }
        //每秒回调一次
        [self countDownWithPER_SECBlock:^{
            remainTime = remainTime - 1;
            if (weakSelf.intervalTime > 0) {
                remainTime = remainTime - weakSelf.intervalTime;
                weakSelf.intervalTime = 0;
            }
            [weakSelf updateDataInVisibleCellWithRemainTime:remainTime];
            
        }];
    }
}

#pragma mark - 刷新秒杀倒计时(毫秒级)
- (void)updateDataInVisibleCellWithRemainTime:(long)timeInterval
{
    if (timeInterval == 0) {
        //废弃倒计时，清空本地秒杀数据，重新请求
        [self destoryTimer];
         self.countDown = nil;
    }
    
    int days = (int)(timeInterval/(1000*3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = (int)(timeInterval-days*24*3600-hours*3600-minutes*60);
    
    NSString *hoursStr;
    NSString *minutesStr;
    NSString *secondsStr;
    
    if (hours < 10){
        //小时
        hoursStr = [NSString stringWithFormat:@"0%d",hours];
    }
    else{
        //小时
        hoursStr = [NSString stringWithFormat:@"%d",hours];
    }
    
    //分钟
    if(minutes<10){
       minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    }
    else{
       minutesStr = [NSString stringWithFormat:@"%d",minutes];
    }
    
    //秒
    if(seconds < 10){
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    }
    else{
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    }
   
    NSString *timeString =  [NSString stringWithFormat:@"%@:%@:%@",hoursStr,minutesStr,secondsStr];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(YWCountDownDelegateMiaoshaTime:)]) {
            [self.delegate YWCountDownDelegateMiaoshaTime:timeString];
        }
    }
}


@end
