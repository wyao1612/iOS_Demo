//
//  UIColor+Addition.h

#import <UIKit/UIKit.h>

@interface UIColor (Addition)

+ (instancetype)primaryColor;

/// 使用 16 进制数字创建颜色，例如 0xFF0000 创建红色
///
/// @param hexColor 16 进制无符号32位整数
///
/// @return 颜色
+ (UIColor *)getColor:(NSString *)hexColor;
+ (instancetype)colorWithHex:(uint32_t)hex;
+ (instancetype)colorWithHex:(uint32_t)hex  alpha:(CGFloat)alpha;
/// 生成随机颜色
///
/// @return 随机颜色
+ (instancetype)randomColor;

/// 使用 R / G / B 数值创建颜色
///
/// @param red   red
/// @param green green
/// @param blue  blue
///
/// @return 颜色
+ (instancetype)colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue;
- (instancetype)colorWithAlpha:(CGFloat)alpha;

@end
