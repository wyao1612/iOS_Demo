//
//  NSString+extension.h
//  PowerStation
//
//  Created by wyao on 2017/5/11.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (extension)

/*******************--Archiver--********************/
+(NSString *)archivingFilePathWithName:(NSString*)pathName;
+(void)writeNSArrayByArchivingWithPath:(NSString*)PathName andArray:(NSArray*)array;
+(void)readDataByUnarchivingWithPath:(NSString*)PathName andArray:(NSArray*)array;
+(BOOL)iSBlankString:(id)string;
+(NSString *)fc_moneyDisposeWithMoney:(id)basemoney;
/*******************--Base64--********************/
/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;

/*******************--Date--********************/
/** 日期转换(年月日)*/
-(NSString*)YMD:(BOOL)isMd;
/** 日期转换（年月日时分秒）*/
-(NSString*)YMDHMS:(BOOL)isMd;
/** 毫秒转日期*/
+(NSString *)ConvertStrToTime:(NSString *)timeStr YMDHMS:(BOOL)isMd;
/** 毫秒转日期 转年/月/日*/
+(NSString *)ConvertStrToTime:(NSString *)timeStr;

/** 日期格式转字符串*/
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format;
/** 字符串转日期格式*/
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format;
/** 毫秒转换总时长*/
- (NSString *)convertStringWithTime:(float)time withNormal:(BOOL)isNormal;

/*******************--Hashing--********************/
/** MD5加密*/
- (NSString *)MD5Hash;
/** sha1加密*/
- (NSString *)sha1;
/** 邮箱验证*/
- (BOOL) validateEmail;
/** 手机号验证*/
- (BOOL) validateMobile;
/** 数字验证*/
- (BOOL)validateNumber;
/** 密码必须是6-12位英文字母及数字的组合*/
-(BOOL)validatePassword;
/** 获取时间戳*/
+ (NSString *)getSecret;
/** 七牛key*/
+ (NSString *)getDateTimeString;
/** 富文本字体转化*/
- (NSAttributedString *)attributeStrWithAttributes:(NSDictionary *)attributes range:(NSRange)range;
/** 获取文字大小*/
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;
/** 数据类型判断*/
+ (NSString *)fc_judgeObj:(id)baseobj placeholder:(NSString *)placeholder;


@end
