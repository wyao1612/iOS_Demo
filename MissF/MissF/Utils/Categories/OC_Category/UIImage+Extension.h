//
//  UIImage+Extension.h
//  TTNews
//
//  Created by wyao on 16/4/3.
//  Copyright © 2016年 wyao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 * 圆形图片
 */
- (UIImage *)circleImage;
-(UIImage*) OriginImageScaleToSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height;
+ (UIImage*) imageWithColor:(UIColor*)color andRadius:(CGFloat)radius;
+(UIImage *)imageFromText:(NSArray*)arrContent withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor;
/**
 黑色圆环
 */
+ (UIImage*) imageWithCycleColor:(UIColor*)color cycleRadius:(CGFloat)radius;

/** 按比例缩放,size 是你要把图显示到多大区域*/
+ (UIImage *) imageCompressFitSizeScale:(UIImage *)sourceImage targetSize:(CGSize)size;
/** 指定宽度按比例缩放*/
-(UIImage *) imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

/**
 圆角图片

 @param image 被设置的image
 @param size size
 @param r 圆角半径
 @return 显示的图片
 */
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
/**
 设置UIImageView圆角
 
 @param imageView 被设置的imageView
 @param image     显示的图片
 */
+ (void)setImageViewBorderRadiusWith:(UIImageView *)imageView with:(UIImage *)image;
@end
