//
//  UIImage+Image.h
//  d427截图
//
//  Created by Rock on 16/4/27.
//  Copyright © 2016年 Garlic Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height;
+ (UIImage*) imageWithColor:(UIColor*)color andRadius:(CGFloat)radius;
+(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor;
/**
 黑色圆环
 */

+ (UIImage*) imageWithCycleColor:(UIColor*)color cycleRadius:(CGFloat)radius;
@end
