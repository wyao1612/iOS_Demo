//
//  NSDate+YB_Extension.m
//  GolfIOS
//
//  Created by yangbin on 16/12/14.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import "NSDate+YB_Extension.h"

@implementation NSDate (YB_Extension)

+ (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


+ (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

+ (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}


// 判断是否为今年
- (BOOL)isThisYear
{
    // 获取当前日期对象
    NSDate *curDate = [NSDate date];
    
    // 获取日历类
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    // 获取自己日期组件(年,月,等)
    NSDateComponents *selfCmp = [curCalendar components:NSCalendarUnitYear fromDate:self];
    
    // 获取当前时间日期组件(年,月,等)
    NSDateComponents *curCmp = [curCalendar components:NSCalendarUnitYear fromDate:curDate];
    
    return  curCmp.year == selfCmp.year;
}

// 判断是否是今天
- (BOOL)isThisToday
{
    // 获取日历类
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    
    return [curCalendar isDateInToday:self];
    
}

// 判断是否是昨天
- (BOOL)isThisYesterday
{
    NSCalendar *curCalendar = [NSCalendar currentCalendar];
    
    return [curCalendar isDateInYesterday:self];
}

+ (NSDate *)dateWithString:(NSString *)timeStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:timeStr];

    return date;
}


+ (NSString *)timeLineStringWithString:(NSString *)timeStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    /*
     // 如果我们得到的是其他地区时间格式，需要设置locale（我们获得的一开始是欧美时间，所以说这里写 en_US）
     fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
     
     // 设置日期格式（声明字符串里面每个数字和单词的含义）
     fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy"; // 因为我们直接获得到的_created_at是欧美时间(NSString类型，无法直接使用)，所以要先用欧美格式将我们获得到的字符串转化为NSDate，然后再设置一次格式，将NSDate转化成为字符串格式
     
     // 微博的创建日期（将_created_at字符串对象转化成为NSDate对象）
     NSDate *createDateUS = [fmt dateFromString:timeStr]; // 此时
     
     // 再次设置日期格式（然后再通过这个日期格式去处理时间字符串）
     fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
     */
    
    
    // 设置格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 发布日期对象
    NSDate *createDate = [fmt dateFromString:timeStr];
    if (createDate == nil) {
        //FIXME: - 有时候会出现时间为空的情况
        
        NSLog(@"为空为空为空为空为空为空为空为空%@",timeStr);
    }
    
    // 处理时间(用帖子发布时间与当前时间比较)
    // 判断是否是今年 年份是否相等 => 获取日期年份 => 日历,获取日期组件
    // 获取帖子发布时间与当前时间差值
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取两个日期差值
    NSDateComponents *cmp = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute  fromDate:createDate toDate:[NSDate date] options:NSCalendarWrapComponents];
    
    
    if ([createDate isThisYear]) {
        if ([createDate isThisToday]) {
            
            // 获取日期差值
            if (cmp.hour >= 1) {
                timeStr = [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            } else if (cmp.minute >= 2) {
                timeStr = [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            } else { // 刚刚
                timeStr = @"刚刚";
            }
            
        } else if ([createDate isThisYesterday]) { // 昨天
            // 昨天 21:10
            fmt.dateFormat = @"昨天 HH:mm";
            timeStr = [fmt stringFromDate:createDate];
            
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd";
            timeStr = [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        timeStr = [fmt stringFromDate:createDate];
    }
    
    return timeStr;
}

@end
