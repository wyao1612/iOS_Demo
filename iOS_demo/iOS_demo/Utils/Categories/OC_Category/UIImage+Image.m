//
//  UIImage+Image.m
//  d427截图
//
//  Created by Rock on 16/4/27.
//  Copyright © 2016年 Garlic Studio. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)


#define CONTENT_MAX_WIDTH   300.0f
+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return theImage;
}


+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage*) imageWithColor:(UIColor*)color andRadius:(CGFloat)radius
{
    
    // borderWidth 表示边框的宽度
    
    CGSize imageSize = CGSizeMake(2*radius, 2*radius);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // borderColor表示边框的颜色
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddArc(context, radius, radius, radius, 0, M_PI * 2, 0);
    CGContextFillPath(context);
    
    //CGContextClip(context);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //   [newImage drawInRect:CGRectMake(0, 0, image.frame.size.width, image.frame.size.height)];
    UIGraphicsEndImageContext();
    return newImage;
    
}

+ (UIImage*) imageWithCycleColor:(UIColor*)color cycleRadius:(CGFloat)radius{
    // borderWidth 表示边框的宽度
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context,0,0,0,1.0);//画笔线的颜色
    CGContextSetLineWidth(context, 2.0);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, 0, 0, radius, 0, 2 * M_PI, 0);
    //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)imageFromText:(NSString*)str withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor withBgImage:(UIImage *)bgImage withBgColor:(UIColor *)bgColor
{
    // set the font type and size
    NSString *string = [str copy];
    UIFont *font = [UIFont fontWithName:@"Heiti SC" size:fontSize];

    
    CGFloat fHeight = 0.0f;

   
    CGSize size = CGSizeMake(200, 16);
    CGSize stringSize = [string boundingRectWithSize:size
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName:font,//设置文字的字体
                                                    NSKernAttributeName:@10,//文字之间的字距
                                                    }
                                          context:nil].size;
   
//        CGSize stringSize = [sContent sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_MAX_WIDTH, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    
    
    fHeight += stringSize.height;
    
    
    CGSize newSize = CGSizeMake(CONTENT_MAX_WIDTH+20, fHeight+50);
    
    
    // Create a stretchable image for the top of the background and draw it
    UIGraphicsBeginImageContextWithOptions(newSize,NO,0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    //如果设置了背景图片
    if(bgImage)
    {
        UIImage* stretchedTopImage = [bgImage stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [stretchedTopImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    }else
    {
        if(bgColor)
        {
            //填充背景颜色
            [bgColor set];
            UIRectFill(CGRectMake(0, 0, newSize.width, newSize.height));
        }
    }
    
    CGContextSetCharacterSpacing(ctx, 10);
    CGContextSetTextDrawingMode (ctx, kCGTextFill);
    [textColor set];
    
    
    
    
   
    
        CGRect rect = CGRectMake(10, 0, 200 , 16);
        
        [string drawInRect:rect withAttributes:@{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : fontSize ]} ];
//        [sContent drawInRect:rect withFont:font lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentLeft];
        
        
       
  
    
    // transfer image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
}

//+ (UIImage *)createOtherMerchantImage:(NSString *)str withBgImage:(UIImage *)image withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor
//
//{
//    
//    //    UIImage *image = [ UIImage imageNamed:@"otherMerchantHeaderBg" ];
//    
//    CGSize size= CGSizeMake (image. size . width , image. size . height ); // 画布大小
//    
//    UIGraphicsBeginImageContextWithOptions (size, NO , 0.0 );
//    
//    [image drawAtPoint : CGPointMake ( 0 , 0 )];
//    
//    // 获得一个位图图形上下文
//    
//    CGContextRef context= UIGraphicsGetCurrentContext ();
//    
//    CGContextDrawPath (context, kCGPathStroke );
//    
//    //画自己想画的内容。。。。。
//    
//    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
//    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    
//    //    [str drawAtPoint : CGPointMake ( image. size . width * 0.4 , image. size . height * 0.4 ) withAttributes : @{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : 50 ], NSForegroundColorAttributeName :[ UIColor blackColor ],NSParagraphStyleAttributeName:paragraphStyle} ];
//    
//    UIFont  *font = [UIFont boldSystemFontOfSize:fontSize];//定义默认字体
//    //计算文字的宽度和高度：支持多行显示
//    CGSize sizeText = [str boundingRectWithSize:size
//                                        options:NSStringDrawingUsesLineFragmentOrigin
//                                     attributes:@{
//                                                  NSFontAttributeName:font,//设置文字的字体
//                                                  NSKernAttributeName:@10,//文字之间的字距
//                                                  }
//                                        context:nil].size;
//    
//    //为了能够垂直居中，需要计算显示起点坐标x,y
//    CGRect rect = CGRectMake((size.width-sizeText.width)/2, (size.height-sizeText.height)/2, sizeText.width, sizeText.height);
//    
//    
//    [str drawInRect:rect withAttributes:@{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : fontSize ], NSForegroundColorAttributeName :textColor,NSParagraphStyleAttributeName:paragraphStyle} ];
//    
//    //画自己想画的内容。。。。。
//    
//    // 返回绘制的新图形
//    
//    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
//    
//    UIGraphicsEndImageContext ();
//    
//    return newImage;
//    
//}


@end
