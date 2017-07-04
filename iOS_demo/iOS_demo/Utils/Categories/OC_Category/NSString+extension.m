//
//  NSString+extension.m
//  PowerStation
//
//  Created by wyao on 2017/5/11.
//  Copyright © 2017年 wyao. All rights reserved.
//

#import "NSString+extension.h"
#import <CommonCrypto/CommonDigest.h>//Hashing

@implementation NSString (extension)
#pragma maek - NSString+Archiver
+(NSString *)archivingFilePathWithName:(NSString*)pathName {
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *archivingFilePath = [documentsPath stringByAppendingPathComponent:pathName];
    NSLog(@"路径-->%@",archivingFilePath);
    return archivingFilePath;
}


+(void)writeNSArrayByArchivingWithPath:(NSString*)PathName andArray:(NSArray*)array{
    
    //1.准备存储归档数据的可变数据类型
    NSMutableData *mutableData = [NSMutableData data];
    NSLog(@"归档前数据长度:%lu", (unsigned long)mutableData.length);
    //2.创建NSKeyedArchiver对象 写到mutableData里面
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mutableData];
    //3.对要归档的数据进行编码操作(二进制)
    [archiver encodeObject:array forKey:@"array"];
    //4.完成编码操作
    [archiver finishEncoding];
    NSLog(@"归档之后的数据长度:%lu", (unsigned long)mutableData.length);
    //5.将编码后的数据写到文件中
    [mutableData writeToFile:PathName atomically:YES];
    
}

+(void)readDataByUnarchivingWithPath:(NSString*)PathName andArray:(NSArray*)array{
    //1.从文件中读取数据(NSData)
    NSData *data = [NSData dataWithContentsOfFile:PathName];
    //2.创建NSKeyedUnarchiver对象 读取Data
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //3.对数据进行解码操作
    NSArray *firstArray = [unarchiver decodeObjectForKey:@"array"];
    //4.完成解码操作
    [unarchiver finishDecoding];
    //验证
    NSLog(@"firstArray:%@", firstArray);
}

+(BOOL)iSBlankString:(id)string{
    if (![string isKindOfClass:[NSString class]]) {
        return YES;
    }else if(string == nil){
        return YES;
    }else if([string isKindOfClass:[NSNull class]]){
        return YES;
    }else if([string isEqualToString:@"(null)"]){
        return YES;
    }else if([string isEqualToString:@"<null>"]){
        return YES;
    }else if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0){
        return YES;
    }
    return NO;
}
// 涉及金额小数点控制
+(NSString *)fc_moneyDisposeWithMoney:(id)basemoney
{
    //
    if ([basemoney isKindOfClass:[NSNumber class]]) {
        //
        
        NSString * tmp = [NSString stringWithFormat:@"%0.2f",[basemoney doubleValue]];
        return tmp;
    }else if ([basemoney isKindOfClass:[NSString class]]){
        NSString * tmp = (NSString*)basemoney;
        
        double dd = [tmp doubleValue];
        tmp = [NSString stringWithFormat:@"%0.2f",dd];
        return tmp;
    }
    return @"暂无";
}
// 数据类型判断
+ (NSString *)fc_judgeObj:(id)baseobj placeholder:(NSString *)placeholder
{
    //    NSLog(@"baseobj class = %@",[baseobj class]);
    if ([baseobj isEqual: [NSNull null]] || baseobj == nil || baseobj == NULL ){
        //
        return placeholder;
        
    }else if ([baseobj isKindOfClass:[NSNumber class]]){
        //
        return [baseobj stringValue];
        
    }else if ([baseobj isKindOfClass:[NSString class]]){
        //
        NSString * tmp = (NSString *)baseobj;
        if ([tmp isEqualToString:@""]) {
            //
            return placeholder;
        }
        if ([[tmp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
            //
            return placeholder;
        }
        if ([tmp isEqualToString:@"null"]) {
            //
            return placeholder;
        }
    }else{
        
        NSString* tmps = [NSString stringWithFormat:@"%@",baseobj];
        
        return tmps;
    }
    
    return baseobj;
    
}

#pragma mark - NSString+Base64
- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - NSString+Date
-(NSString*)YMD:(BOOL)isMd{
    // 时间字符串
    //    NSString *string = @"2016-10-03 14:01:00";
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd";//yyyy-MM-dd HH:mm:ss
    
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:self];
    
    // 利用NSCalendar处理日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:date];
    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:date];
    
    if (isMd == true) {
        //NSLog(@"%zd月%zd日", month, day);
        return [NSString stringWithFormat:@"%zd月%zd日",month, day];
    }else{
        //NSLog(@"%zd年%zd月%zd日", year, month, day);
        return [NSString stringWithFormat:@"%zd年%zd月%zd日",year,month, day];
    }
}

/** 毫秒转日期*/
+(NSString *)ConvertStrToTime:(NSString *)timeStr YMDHMS:(BOOL)isMd{
    
    long long time=[timeStr longLongValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    // 利用NSCalendar处理日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:date];
    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:date];
    
    if (isMd == true) {
        return [NSString stringWithFormat:@"%zd月%zd日",month, day];
    }else{
        return [NSString stringWithFormat:@"%zd年%zd月%zd日",year,month, day];
    }
}

/** 毫秒转日期 转年/月/日*/
+(NSString *)ConvertStrToTime:(NSString *)timeStr{
    
    long long time=[timeStr longLongValue];
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time/1000.0];
    
    // 利用NSCalendar处理日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:date];
    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:date];
    
    return [NSString stringWithFormat:@"%zd/%zd/%zd",year,month,day];
}


-(NSString*)YMDHMS:(BOOL)isMd{
    // 时间字符串
    // NSString *string = @"2016-10-03 14:01:00";
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(为了转换成功)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";//yyyy-MM-dd HH:mm:ss
    
    // NSString * -> NSDate *
    NSDate *date = [fmt dateFromString:self];
    
    // 利用NSCalendar处理日期
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:date];
    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:date];
    
    if (isMd == true) {
        //NSLog(@"%zd月%zd日", month, day);
        return [NSString stringWithFormat:@"%zd月%zd日",month, day];
    }else{
        //NSLog(@"%zd年%zd月%zd日", year, month, day);
        return [NSString stringWithFormat:@"%zd年%zd月%zd日",year,month, day];
    }
}



//日期格式转字符串
- (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

//字符串转日期格式
- (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    return [self worldTimeToChinaTime:date];
}

//将世界时间转化为中国区时间
- (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}


//毫秒转换总时长
-(NSString *)convertStringWithTime:(float)time withNormal:(BOOL)isNormal{
    if (isnan(time)) time = 0.f;
    int min = time / (60.0*1000);
    int sec = (time - min * 60*1000)/1000;
    NSString * minStr = min > 9 ? [NSString stringWithFormat:@"%d",min] : [NSString stringWithFormat:@"0%d",min];
    NSString * secStr = sec > 9 ? [NSString stringWithFormat:@"%d",sec] : [NSString stringWithFormat:@"0%d",sec];
    
    NSString * timeStr;
    if (isNormal) {
        timeStr = [NSString stringWithFormat:@"%@:%@",minStr, secStr];
    }else{
        timeStr = [NSString stringWithFormat:@"%@分%@秒",minStr, secStr];
    }
    return timeStr;
}



- (NSString *)MD5Hash
{
    const char *cStr = [self UTF8String];
    
    unsigned char result[16];
    
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
/**  sha1加密*/
- (NSString*)sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}
/** 邮箱验证*/
- (BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
/** 数字验证*/
- (BOOL)validateNumber
{
    NSString *emailRegex = @"^[0-9.]{0,155}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
    
}

/** 密码必须是6-18位英文字母及数字的组合*/
-(BOOL)validatePassword{
    NSString *emailRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

/** 手机号码验证*/
- (BOOL) validateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|(147))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

+ (NSString *)getSecret
{
    //获取当前时间戳
    NSTimeInterval timeIn = [[NSDate date] timeIntervalSince1970];
    return  [NSString stringWithFormat:@"%.f",timeIn];
}

+ (NSString *)getDateTimeString
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    NSString *randomStr = [NSString randomStringWithLength:8];
    
    return [dateString stringByAppendingString:randomStr];
}


+ (NSString *)randomStringWithLength:(int)len
{
    NSString *letters = @"0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}

- (NSAttributedString *)attributeStrWithAttributes:(NSDictionary *)attributes range:(NSRange)range{
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc] initWithString:self];
    [muStr setAttributes:attributes range:range];
    return muStr;
}

#pragma mark - 私有方法获取文字宽度
-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=font;
    
    CGSize maxSize=CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
