//
//  NSString+Hashing.m
//  TreatNew
//
//  Created by bsetech on 16/3/21.
//  Copyright © 2016年 StarLi. All rights reserved.
//

#import "NSString+Hashing.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Hashing)

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
//sha1加密
- (NSString*)sha1
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
   
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];    
    return output;
}
//邮箱验证
- (BOOL) validateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
//数字验证
- (BOOL)validateNumber
{
    NSString *emailRegex = @"^[0-9.]{0,155}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];

}

//手机号码验证
- (BOOL) validateMobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
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
@end
