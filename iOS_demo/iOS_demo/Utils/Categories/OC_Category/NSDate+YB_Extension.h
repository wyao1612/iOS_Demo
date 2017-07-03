//
//  NSDate+YB_Extension.h
//  GolfIOS
//
//  Created by yangbin on 16/12/14.
//  Copyright © 2016年 TSou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YB_Extension)

+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)year:(NSDate *)date;

+ (NSDate *)dateWithString:(NSString *)string;

+ (NSString *)timeLineStringWithString:(NSString *)timeStr;

@end
