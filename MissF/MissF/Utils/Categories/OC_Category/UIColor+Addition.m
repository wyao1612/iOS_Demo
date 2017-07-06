//
//  UIColor+Addition.m


#import "UIColor+Addition.h"

@implementation UIColor (Addition)

+ (UIColor *)getColor:(NSString *)hexColor{
    //定义无符号整型数值
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    //提取指定下标索引、指定长度的十六进制字符串 扫描字符串  取出的red、green、blue都为 0 ~ 255的整型值
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    //返回通过十六进制颜色字符串获取的颜色
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

+ (instancetype)primaryColor {
    return [self colorWithHex:0x784203];
}

+ (instancetype)colorWithHex:(uint32_t)hex {
    uint8_t r = (hex & 0xff0000) >> 16;
    uint8_t g = (hex & 0x00ff00) >> 8;
    uint8_t b = hex & 0x0000ff;

    return [self colorWithRed:r green:g blue:b];
}
+ (instancetype)colorWithHex:(uint32_t)hex  alpha:(CGFloat)alpha{
    uint8_t r = (hex & 0xff0000) >> 16;
    uint8_t g = (hex & 0x00ff00) >> 8;
    uint8_t b = hex & 0x0000ff;
    
    return [self colorWithRed:r green:g blue:b alpha:alpha];
}

+ (instancetype)randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256) green:arc4random_uniform(256) blue:arc4random_uniform(256)];
}

+ (instancetype)colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue {
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
}


- (instancetype)colorWithAlpha:(CGFloat)alpha {
    const CGFloat *colors = CGColorGetComponents(self.CGColor);
    return [UIColor colorWithRed:colors[0] green:colors[1] blue:colors[2] alpha:alpha];
}



@end
